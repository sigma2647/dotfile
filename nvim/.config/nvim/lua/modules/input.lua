local M = {}

-- 检查 fcitx5-remote 是否可执行
local function is_fcitx5_available()
    return vim.fn.executable("fcitx5-remote") == 1
end

-- 获取当前输入法状态
local function get_input_state()
    local result = vim.system({ "fcitx5-remote" }):wait()
    if result.code == 0 then
        return result.stdout:match("%d+") == "2"  -- 2 表示中文输入法
    end
    return false
end

-- 保存输入法状态
local last_input_state = false
local is_switching = false  -- 防止递归调用
local debug_mode = false     -- 调试模式

-- 调试函数
local function debug_log(message)
    if debug_mode then
        vim.notify("[Fcitx5] " .. message, vim.log.levels.INFO)
    end
end

-- 切换输入法状态
local function switch_input_method(mode, force_state)
    if not is_fcitx5_available() then return end
    if is_switching then
        debug_log("正在切换中，跳过")
        return
    end
    
    is_switching = true
    
    local args = {}
    local current_state = get_input_state()
    
    debug_log(string.format("模式: %s, 当前状态: %s, 上次状态: %s", 
              mode, current_state and "中文" or "英文", 
              last_input_state and "中文" or "英文"))
    
    if mode == "normal" then
        -- 只有当前是中文输入法时才保存状态
        if current_state then
            last_input_state = true
            debug_log("保存中文输入法状态")
        else
            -- 如果当前已经是英文，不改变上次保存的状态
            debug_log("当前已是英文，保持上次状态")
        end
        args = { "-c" } -- 切换到英文
    elseif mode == "insert" then
        -- 恢复到之前的状态
        if force_state ~= nil then
            -- 强制设置特定状态（用于调试）
            if force_state then
                args = { "-o" } -- 切换到中文
            else
                args = { "-c" } -- 保持英文
            end
        elseif last_input_state then
            args = { "-o" } -- 切换到中文
            debug_log("恢复中文输入法")
        else
            args = { "-c" } -- 保持英文
            debug_log("保持英文输入法")
        end
    else
        is_switching = false
        return
    end

    local result = vim.system({ "fcitx5-remote", unpack(args) }):wait()
    if result.code ~= 0 then
        vim.notify("切换输入法失败: " .. (result.stderr or ""), vim.log.levels.ERROR)
    else
        debug_log(string.format("成功切换到 %s", 
                  args[1] == "-c" and "英文" or "中文"))
    end
    
    is_switching = false
end

-- 获取当前模式
local function get_current_mode()
    return vim.api.nvim_get_mode().mode
end

function M.setup(opts)
    opts = opts or {}
    debug_mode = opts.debug or false
    
    if not is_fcitx5_available() then 
        if debug_mode then
            vim.notify("fcitx5-remote 不可用", vim.log.levels.WARN)
        end
        return 
    end

    local group = vim.api.nvim_create_augroup("Fcitx5InputSwitch", { clear = true })

    -- 更宽泛的模式匹配，监听所有模式变化
    vim.api.nvim_create_autocmd("ModeChanged", {
        group = group,
        pattern = "*",
        callback = function(event)
            local from_mode = event.match:match("(.-):")
            local to_mode = event.match:match(":(.*)")
            
            debug_log(string.format("模式变化: %s -> %s", from_mode or "?", to_mode or "?"))
            
            -- 进入普通模式相关的模式
            if to_mode and to_mode:match("^n") then
                vim.schedule(function()
                    switch_input_method("normal")
                end)
            -- 进入插入模式相关的模式
            elseif to_mode and (to_mode:match("^i") or to_mode:match("^R")) then
                vim.schedule(function()
                    switch_input_method("insert")
                end)
            end
        end,
    })
    
    -- 额外的保险措施：监听插入模式进入和离开
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = group,
        callback = function()
            debug_log("InsertEnter 触发")
            vim.schedule(function()
                switch_input_method("insert")
            end)
        end,
    })
    
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = group,
        callback = function()
            debug_log("InsertLeave 触发")
            vim.schedule(function()
                switch_input_method("normal")
            end)
        end,
    })
    
    -- 开启/关闭调试模式的命令
    vim.api.nvim_create_user_command('Fcitx5Debug', function()
        debug_mode = not debug_mode
        vim.notify(string.format("Fcitx5 调试模式: %s", debug_mode and "开启" or "关闭"))
    end, {})
    
    -- 手动切换输入法的命令（用于测试）
    vim.api.nvim_create_user_command('Fcitx5Toggle', function()
        local current = get_input_state()
        switch_input_method("insert", not current)
    end, {})
    
    -- 重置状态的命令
    vim.api.nvim_create_user_command('Fcitx5Reset', function()
        last_input_state = false
        vim.notify("Fcitx5 状态已重置")
    end, {})
end

return M 
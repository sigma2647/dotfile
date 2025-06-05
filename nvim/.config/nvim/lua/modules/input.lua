local M = {}

-- 配置选项
local config = {
    debug = false,
    enable_fallback = true,  -- 启用备用机制
    check_interval = 100,    -- 检查间隔(ms)
    retry_count = 3,         -- 重试次数
}

-- 状态管理
local state = {
    last_input_state = false,
    is_switching = false,
    fcitx5_available = nil,  -- 缓存可用性检查
    last_check_time = 0,     -- 上次检查时间
}

-- 检查 fcitx5-remote 是否可执行（带缓存）
local function is_fcitx5_available()
    if state.fcitx5_available == nil then
        state.fcitx5_available = vim.fn.executable("fcitx5-remote") == 1
    end
    return state.fcitx5_available
end

-- 获取当前输入法状态（优化版本）
local function get_input_state()
    if not is_fcitx5_available() then return false end
    
    local current_time = vim.uv.now()
    -- 避免频繁检查，增加防抖机制
    if current_time - state.last_check_time < config.check_interval then
        return state.last_input_state
    end
    
    state.last_check_time = current_time
    
    -- 重试机制
    for i = 1, config.retry_count do
        local result = vim.system({ "fcitx5-remote" }, { timeout = 1000 }):wait()
        if result.code == 0 and result.stdout then
            local status = result.stdout:match("%d+")
            if status then
                return status == "2"  -- 2 表示中文输入法
            end
        end
        -- 如果失败，短暂等待后重试
        if i < config.retry_count then
            vim.uv.sleep(50)
        end
    end
    
    return false
end

-- 调试函数（优化输出格式）
local function debug_log(message, level)
    if not config.debug then return end
    level = level or vim.log.levels.INFO
    local timestamp = os.date("%H:%M:%S")
    vim.notify(string.format("[%s Fcitx5] %s", timestamp, message), level)
end

-- 异步切换输入法（防止阻塞）
local function async_switch_fcitx5(args, callback)
    vim.system({ "fcitx5-remote", unpack(args) }, { timeout = 2000 }, function(result)
        vim.schedule(function()
            if callback then callback(result) end
        end)
    end)
end

-- 切换输入法状态（优化版本）
local function switch_input_method(mode, force_state)
    if not is_fcitx5_available() then 
        debug_log("fcitx5-remote 不可用", vim.log.levels.WARN)
        return 
    end
    
    if state.is_switching then
        debug_log("正在切换中，跳过")
        return
    end
    
    state.is_switching = true
    
    local function cleanup()
        state.is_switching = false
    end
    
    local args = {}
    local should_check_state = mode == "normal" and force_state == nil
    local current_state = should_check_state and get_input_state() or nil
    
    if config.debug then
        debug_log(string.format("模式: %s, 当前状态: %s, 上次状态: %s", 
                  mode, 
                  current_state ~= nil and (current_state and "中文" or "英文") or "未检查",
                  state.last_input_state and "中文" or "英文"))
    end
    
    if mode == "normal" then
        -- 优化：只有当前是中文输入法时才保存状态
        if current_state then
            state.last_input_state = true
            debug_log("保存中文输入法状态")
        else
            debug_log("当前已是英文，保持上次状态")
        end
        args = { "-c" } -- 切换到英文
    elseif mode == "insert" then
        if force_state ~= nil then
            args = force_state and { "-o" } or { "-c" }
            debug_log(string.format("强制切换到%s", force_state and "中文" or "英文"))
        elseif state.last_input_state then
            args = { "-o" } -- 切换到中文
            debug_log("恢复中文输入法")
        else
            args = { "-c" } -- 保持英文
            debug_log("保持英文输入法")
        end
    else
        cleanup()
        return
    end

    -- 异步执行切换
    async_switch_fcitx5(args, function(result)
        if result.code ~= 0 then
            local error_msg = result.stderr or "未知错误"
            debug_log(string.format("切换输入法失败: %s", error_msg), vim.log.levels.ERROR)
            
            -- 备用机制：如果启用了fallback，尝试直接命令
            if config.enable_fallback then
                debug_log("尝试备用切换方法...")
                vim.system({ "fcitx5-remote", unpack(args) }):wait()
            end
        else
            debug_log(string.format("成功切换到 %s", 
                      args[1] == "-c" and "英文" or "中文"))
        end
        cleanup()
    end)
end

-- 防抖处理的模式切换
local switch_timer = nil
local function debounced_switch(mode, delay)
    delay = delay or 50 -- 默认50ms延迟
    
    if switch_timer then
        switch_timer:stop()
        switch_timer:close()
    end
    
    switch_timer = vim.uv.new_timer()
    switch_timer:start(delay, 0, function()
        switch_timer:close()
        switch_timer = nil
        vim.schedule(function()
            switch_input_method(mode)
        end)
    end)
end

function M.setup(opts)
    -- 合并配置
    config = vim.tbl_deep_extend('force', config, opts or {})
    
    if not is_fcitx5_available() then 
        debug_log("fcitx5-remote 不可用", vim.log.levels.WARN)
        return 
    end

    debug_log("输入法切换模块已初始化")
    
    local group = vim.api.nvim_create_augroup("Fcitx5InputSwitch", { clear = true })

    -- 主要的模式切换监听（使用防抖）
    vim.api.nvim_create_autocmd("ModeChanged", {
        group = group,
        pattern = "*",
        callback = function(event)
            local from_mode = event.match:match("(.-):")
            local to_mode = event.match:match(":(.*)")
            
            debug_log(string.format("模式变化: %s -> %s", from_mode or "?", to_mode or "?"))
            
            -- 进入普通模式相关的模式
            if to_mode and to_mode:match("^n") then
                debounced_switch("normal")
            -- 进入插入模式相关的模式  
            elseif to_mode and (to_mode:match("^i") or to_mode:match("^R")) then
                debounced_switch("insert")
            end
        end,
    })
    
    -- 备用监听器（移除重复的InsertEnter/Leave，避免冲突）
    if config.enable_fallback then
        vim.api.nvim_create_autocmd("FocusGained", {
            group = group,
            callback = function()
                debug_log("窗口获得焦点，检查输入法状态")
                -- 重新检查fcitx5可用性
                state.fcitx5_available = nil
            end,
        })
    end
    
    -- 命令定义
    local commands = {
        {
            name = 'Fcitx5Debug',
            callback = function()
                config.debug = not config.debug
                vim.notify(string.format("Fcitx5 调试模式: %s", config.debug and "开启" or "关闭"))
            end,
            desc = "切换 Fcitx5 调试模式"
        },
        {
            name = 'Fcitx5Toggle',
            callback = function()
                local current = get_input_state()
                switch_input_method("insert", not current)
            end,
            desc = "手动切换输入法"
        },
        {
            name = 'Fcitx5Reset',
            callback = function()
                state.last_input_state = false
                state.fcitx5_available = nil
                vim.notify("Fcitx5 状态已重置")
            end,
            desc = "重置输入法状态"
        },
        {
            name = 'Fcitx5Status',
            callback = function()
                local current = get_input_state()
                local status = string.format(
                    "当前状态: %s | 保存状态: %s | 可用性: %s",
                    current and "中文" or "英文",
                    state.last_input_state and "中文" or "英文",
                    is_fcitx5_available() and "是" or "否"
                )
                vim.notify(status)
            end,
            desc = "显示输入法状态信息"
        }
    }
    
    -- 批量创建命令
    for _, cmd in ipairs(commands) do
        vim.api.nvim_create_user_command(cmd.name, cmd.callback, { desc = cmd.desc })
    end
end

-- 清理函数
function M.cleanup()
    if switch_timer then
        switch_timer:stop()
        switch_timer:close()
        switch_timer = nil
    end
end

return M
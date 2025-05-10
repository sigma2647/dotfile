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

-- 切换输入法状态
local function switch_input_method(mode)
    if not is_fcitx5_available() then return end

    local args = {}
    if mode == "normal" then
        -- 保存当前状态并切换到英文
        last_input_state = get_input_state()
        args = { "-c" } -- 切换到英文
    elseif mode == "insert" then
        -- 恢复到之前的状态
        if last_input_state then
            args = { "-o" } -- 切换到中文
        else
            args = { "-c" } -- 保持英文
        end
    else
        return
    end

    local result = vim.system({ "fcitx5-remote", unpack(args) }):wait()
    if result.code ~= 0 then
        vim.notify("切换输入法失败: " .. (result.stderr or ""), vim.log.levels.ERROR)
    end
end

function M.setup()
    if not is_fcitx5_available() then return end

    local group = vim.api.nvim_create_augroup("Fcitx5InputSwitch", { clear = true })

    -- 进入普通模式时切换到英文输入法
    vim.api.nvim_create_autocmd("ModeChanged", {
        group = group,
        pattern = "*:n",
        callback = function()
            switch_input_method("normal")
        end,
    })

    -- 进入插入模式时恢复之前的输入法
    vim.api.nvim_create_autocmd("ModeChanged", {
        group = group,
        pattern = "*:i",
        callback = function()
            switch_input_method("insert")
        end,
    })
end

return M 
local M = {}

-- 检查 fcitx5 是否可用
local function check_fcitx5()
    local handle = io.popen("which fcitx5-remote 2>/dev/null")
    if handle then
        local result = handle:read("*a")
        handle:close()
        return result ~= ""
    end
    return false
end

-- 切换输入法
local function switch_input_method(mode)
    if not check_fcitx5() then return end
    
    local cmd = "fcitx5-remote"
    if mode == "normal" then
        cmd = cmd .. " -c"  -- 切换到英文
    elseif mode == "insert" then
        cmd = cmd .. " -o"  -- 切换到之前的输入法
    end
    
    vim.fn.system(cmd)
end

function M.setup()
    if not check_fcitx5() then return end

    -- 普通模式切换到英文
    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*:n",
        callback = function() switch_input_method("normal") end,
    })

    -- 插入模式恢复输入法
    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*:i",
        callback = function() switch_input_method("insert") end,
    })
end

return M 
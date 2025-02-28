-- core/vscode.lua

local M = {}

-- 键位映射辅助函数
local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- VSCode 命令调用辅助函数
local function vscode_cmd(cmd)
    return string.format([[<Cmd>call VSCodeNotify('%s')<CR>]], cmd)
end

-- VSCode 特定配置
function M.setup()
    -- 基础设置
    local options = {
        clipboard = "unnamedplus", -- 使用系统剪贴板
        ignorecase = true,         -- 搜索时忽略大小写
        smartcase = true,          -- 搜索时智能大小写
        scrolloff = 8,             -- 增加上下文可见行数
        timeoutlen = 300,          -- 减少键位映射等待时间
        updatetime = 100,          -- 更快的更新时间（对于 CursorHold 事件）
        wrapscan = true,      -- 搜索到文件底部时从顶部继续搜索
        virtualedit = "block" -- 在可视块模式下允许超出实际文本编辑
    }
    
    for k, v in pairs(options) do
      vim.opt[k] = v
    end

    vim.g.mapleader = " "                                   -- 设置leader键为空格
    -- 常用键位映射
    -- 窗口导航
    map('n', '<C-j>', [[<Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>]])
    map('n', '<C-k>', [[<Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>]])
    map('n', '<C-h>', [[<Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>]])
    map('n', '<C-l>', [[<Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>]])
    
    -- 文件操作
    map('n', '<leader>f', [[<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>]])
    map('n', '<leader>s', [[<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>]])
    
    -- 代码操作
    map('n', 'gd', [[<Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>]])
    map('n', 'gr', [[<Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>]])
    map('n', '<leader>rn', [[<Cmd>call VSCodeNotify('editor.action.rename')<CR>]])
    map('n', '<leader>ca', [[<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>]])

    map('n', '<leader>ee', vscode_cmd('workbench.action.focusSideBar'))    -- 聚焦到文件树   

    -- 搜索相关
    map('n', '<leader>fw', [[<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>]])
    map('n', '<leader>r', [[<Cmd>call VSCodeNotify('editor.action.startFindReplaceAction')<CR>]])
    map('n', '<leader>/', [[<Cmd>call VSCodeNotify('actions.find')<CR>]])
    map('n', '*', vscode_cmd('editor.action.findWithSelection'))   -- 搜索当前选中文本
    map('n', '<C-d>', vscode_cmd('editor.action.addSelectionToNextFindMatch')) -- 选中下一个匹配项
    
    -- 注释
    map('n', 'gcc', [[<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>]])
    map('v', 'gc', [[<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>]])
    map('v', '<C-n>', [[<Cmd>call VSCodeNotify('editor.action.addSelectionToNextFindMatch')<CR>]])


    map('n', '<leader>z', [[<Cmd>call VSCodeNotify('workbench.action.toggleZenMode')<CR>]])

    -- 面板操作
    map('n', '<leader>e', [[<Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>]])
    map('n', '<leader>E', [[<Cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<CR>]])

    map('n', '<leader>t', [[<Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>]])
    map('n', '<leader>a', [[<Cmd>call VSCodeNotify('workbench.action.toggleActivityBarVisibility')<CR>]])
    -- map("n", "K", [[<Cmd>call VSCodeNotify('editor.action.showHover')<CR>]])
    map('n', 'K', vscode_cmd('editor.action.showHover'))

    map('n', '<TAB>', [[<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>]])
    map('n', '<S-TAB>', [[<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>]])

    map('n', '<C-w>', [[<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>]])
    
    -- 缩进操作保持 Visual 模式
    map('v', '<', '<gv')
    map('v', '>', '>gv')
    
    -- 移动行
    map('n', '<A-j>', [[<Cmd>call VSCodeNotify('editor.action.moveLinesDownAction')<CR>]])
    map('n', '<A-k>', [[<Cmd>call VSCodeNotify('editor.action.moveLinesUpAction')<CR>]])
    map('v', '<A-j>', [[<Cmd>call VSCodeNotify('editor.action.moveLinesDownAction')<CR>]])
    map('v', '<A-k>', [[<Cmd>call VSCodeNotify('editor.action.moveLinesUpAction')<CR>]])
    
    -- 折叠
    map('n', 'za', [[<Cmd>call VSCodeNotify('editor.toggleFold')<CR>]])
    map('n', 'zR', [[<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>]])
    map('n', 'zM', [[<Cmd>call VSCodeNotify('editor.foldAll')<CR>]])

    map("n", "H", "^")                -- 快速到行首
    map("n", "L", "$")                -- 快速到行尾
    map("v", "H", "^")                -- 可视模式行首
    map("v", "L", "$")                -- 可视模式行尾
    -- require("core.keymaps")
    --

    -- map('n', '<C-\\>', vscode_cmd('workbench.terminal.toggleTerminal'))
    --map('n', '<C-\\>'      , [[<Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>]])
    map("n", [[<c-\>]], [[<Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>]])




end
return M

local map = vim.api.nvim_buf_set_keymap
-- local opt = {noremap = true, silent = true }
-- map(0, 'n', '<C-a>', '<CMD>echo "hi"<CR>', {noremap = false, silent = false })   -- execute cell
--vim.cmd([[set ft=vimwiki]])

local map = vim.api.nvim_buf_set_keymap
-- local opt = {noremap = true, silent = true }

-- map(0, "n", "<C-c><C-c>", "<CMD>IPythonCellExecuteCell<CR>", { noremap = false, silent = false }) -- execute cell

vim.o.number = false
vim.o.relativenumber = false
-- 2024-2025 Treesitter 增强功能
-- 禁用 markdown 的 treesitter 缩进（如果存在）
pcall(function()
  require('nvim-treesitter.configs').setup({
    indent = { enable = true, disable = { 'markdown' } },
  })
end)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- 设置 conceal 选项
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = "nic"
    
    -- 设置缩进和格式选项
    vim.opt_local.autoindent = true
    vim.opt_local.formatoptions = vim.opt_local.formatoptions + 'r'
    vim.cmd('setlocal comments-=fB:*')
    
    -- 设置 bullet conceal 规则
    vim.cmd([[syntax match markdownBullet /^\s*-/ conceal cchar=•]])
  end,
})

-- 启用 Treesitter 折叠
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldenable = true
vim.opt_local.foldlevel = 99         -- 默认展开所有折叠

-- 支持的代码块语言
vim.g.markdown_fenced_languages = {
  'python',
  'javascript', 'js=javascript',
  'typescript',
  'bash', 'sh',
  'html', 'css',
  'lua',
  'vim',
  'json',
  'yaml',
  'rust',
  'go',
  'c', 'cpp'
}

-- 更好的 markdown 语法设置
vim.g.markdown_syntax_conceal = 0  -- 不强制隐藏语法

-- 增强的 markdown 渲染设置
vim.opt_local.linebreak = true      -- 在词边界换行
vim.opt_local.breakindent = true    -- 保持缩进对齐
vim.opt_local.showbreak = "↪ "      -- 换行标识符

-- 设置更好的颜色高亮
vim.cmd([[
  " 代码块样式
  highlight markdownCode guibg=#2d3748 guifg=#a0aec0
  highlight markdownCodeBlock guibg=#2d3748 guifg=#a0aec0
  
  " 标题样式
  highlight markdownH1 guifg=#ff6b6b gui=bold
  highlight markdownH2 guifg=#4ecdc4 gui=bold
  highlight markdownH3 guifg=#45b7d1 gui=bold
  highlight markdownH4 guifg=#96ceb4 gui=bold
  highlight markdownH5 guifg=#feca57 gui=bold
  highlight markdownH6 guifg=#ff9ff3 gui=bold
  
  " 强调文本
  highlight markdownBold guifg=#f8f8f2 gui=bold
  highlight markdownItalic guifg=#f8f8f2 gui=italic
  
  " 列表样式
  highlight markdownListMarker guifg=#ff79c6
  highlight markdownOrderedListMarker guifg=#ff79c6
  
  " 链接样式
  highlight markdownUrl guifg=#8be9fd gui=underline
  highlight markdownLink guifg=#bd93f9
  
  " 引用块样式
  highlight markdownBlockquote guifg=#6272a4 gui=italic
]])

-- 添加折叠切换快捷键
vim.keymap.set('n', '<leader>mf', 'za', { noremap = true, silent = true, desc = "Toggle markdown fold" })
vim.keymap.set('n', '<leader>mF', 'zA', { noremap = true, silent = true, desc = "Toggle all markdown folds" })


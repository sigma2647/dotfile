local map = vim.api.nvim_buf_set_keymap
-- local opt = {noremap = true, silent = true }
-- map(0, 'n', '<C-a>', '<CMD>echo "hi"<CR>', {noremap = false, silent = false })   -- execute cell
--vim.cmd([[set ft=vimwiki]])

local map = vim.api.nvim_buf_set_keymap
-- local opt = {noremap = true, silent = true }

-- map(0, "n", "<C-c><C-c>", "<CMD>IPythonCellExecuteCell<CR>", { noremap = false, silent = false }) -- execute cell

vim.o.number = false
vim.o.relativenumber = false
-- Set syntax highlighting for markdown code blocks
vim.opt_local.conceallevel = 0     -- Don't hide markdown syntax
-- vim.opt_local.foldmethod = 'syntax' -- Enable folding by syntax
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
-- vim.g.markdown_folding = 1        -- Enable markdown folding
vim.g.markdown_syntax_conceal = 0  -- Don't conceal syntax

-- Set color for code blocks if needed (adjust according to your colorscheme)
vim.cmd([[
  highlight link markdownCode Normal
  highlight link markdownCodeBlock Normal
]])

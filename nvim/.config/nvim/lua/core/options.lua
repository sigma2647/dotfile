vim.g.mapleader = " "                                   -- 设置leader键为空格
vim.g.netrw_banner = 0					-- gets rid of the annoying banner for netrw
vim.g.netrw_altv = 1					-- change from left splitting to right splitting
vim.g.netrw_liststyle=3					-- tree style view in netrw
vim.opt.title = true					-- show title
vim.cmd('set path+=**')					-- search current directory recursively
vim.opt.syntax = "ON"
vim.opt.backup = false
vim.opt.compatible = false				-- turn off vi compatibility mode
vim.cmd('colorscheme catppuccin')			-- set colorscheme
vim.o.termguicolors = true

vim.opt.scrolloff = 3					-- scroll page when cursor is 3 lines from top/bottom
vim.opt.sidescrolloff = 3				-- scroll page when cursor is 3 spaces from left/right


vim.opt.number = true       	-- 开启相对行号
vim.opt.relativenumber = true       	-- 开启相对行号

-- vim.opt.cursorline = true               -- 启用当前行高亮 
vim.opt.cursorlineopt = 'both'
--
vim.opt.clipboard = "unnamedplus"
vim.opt.syntax = "enable"               -- 开启语法高亮
vim.opt.tabstop = 4                     -- 设置缩进 
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.mouse = "a"                     -- 启用鼠标
vim.g.noswapfile = 1
vim.opt.scrolloff = 6
vim.opt.ignorecase = true               -- 搜索时忽略大小写
vim.opt.smartcase = true
vim.opt.incsearch = true				-- enable incremental searching
vim.opt.wrap = true						-- 开启换行
vim.opt.fileencoding = "utf-8"


vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none"})
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none"})

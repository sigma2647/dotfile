-- 基础设置
vim.g.mapleader = " "                                   -- 设置leader键为空格
vim.opt.compatible = false                             -- 关闭 vi 兼容模式
vim.opt.mouse = "a"                                    -- 启用鼠标支持
vim.opt.clipboard = "unnamedplus"                      -- 系统剪贴板支持
vim.opt.fileencoding = "utf-8"                         -- 文件编码
vim.opt.termguicolors = true                          -- 启用真彩色支持

vim.opt.fileencodings = "utf-8,gbk,big5,cp936,gb18030,euc-jp,euc-kr,latin1,ucs-bom,ucs" --编码自动识别

-- 界面设置
vim.opt.title = true                                  -- 显示标题
vim.opt.number = true                                 -- 显示行号
vim.opt.relativenumber = true                         -- 显示相对行号
vim.opt.cursorlineopt = 'both'                        -- 光标行高亮
vim.opt.cursorcolumn = true                           -- 光标列高亮
vim.opt.scrolloff = 6                                 -- 光标距离顶部/底部的行数
vim.opt.sidescrolloff = 3                             -- 光标距离左右边界的列数
vim.opt.wrap = true                                   -- 自动换行
vim.opt.fillchars = {eob = " "}                       -- 设置空行显示字符
vim.opt.autoread = true

-- 搜索设置
vim.opt.ignorecase = true                             -- 搜索时忽略大小写
vim.opt.smartcase = true                              -- 智能大小写匹配
vim.opt.incsearch = true                              -- 实时搜索
vim.cmd('set path+=**')                               -- 递归搜索当前目录

-- 编辑设置
vim.opt.tabstop = 4                                   -- Tab 键显示的空格数
vim.opt.shiftwidth = 4                                -- 自动缩进空格数
vim.opt.expandtab = true                              -- 将 Tab 转换为空格

-- 性能优化
vim.opt.backup = false                                -- 不创建备份文件
vim.g.noswapfile = 1                                  -- 不创建交换文件
vim.opt.lazyredraw = true                            -- 延迟重绘，提高性能
vim.opt.updatetime = 300                             -- 减少更新延迟
vim.opt.timeoutlen = 300
vim.opt.wildignorecase = true

-- 文件浏览器设置（优化性能）
-- 统一到 modules/filetree.lua 内设置 netrw 选项，避免分散配置

-- 语法高亮
vim.opt.syntax = "enable"                            -- 启用语法高亮

-- 主题设置
vim.cmd('colorscheme catppuccin')                    -- 设置主题

-- 透明背景设置
vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none"})
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none"})

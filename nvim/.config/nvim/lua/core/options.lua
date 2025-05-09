-- 基础设置
vim.g.mapleader = " "                                   -- 设置leader键为空格
vim.opt.compatible = false                             -- 关闭 vi 兼容模式
vim.opt.mouse = "a"                                    -- 启用鼠标支持
vim.opt.clipboard = "unnamedplus"                      -- 系统剪贴板支持
vim.opt.fileencoding = "utf-8"                         -- 文件编码
vim.opt.termguicolors = true                          -- 启用真彩色支持

-- 界面设置
vim.opt.title = true                                  -- 显示标题
vim.opt.number = true                                 -- 显示行号
vim.opt.relativenumber = true                         -- 显示相对行号
vim.opt.cursorlineopt = 'both'                        -- 光标行高亮
vim.opt.scrolloff = 6                                 -- 光标距离顶部/底部的行数
vim.opt.sidescrolloff = 3                             -- 光标距离左右边界的列数
vim.opt.wrap = true                                   -- 自动换行
vim.opt.fillchars = {eob = " "}                       -- 设置空行显示字符

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

-- 文件浏览器设置
vim.g.netrw_banner = 0                               -- 关闭 netrw 横幅
vim.g.netrw_altv = 1                                 -- 右侧分割
vim.g.netrw_liststyle = 3                            -- 树形视图
vim.g.netrw_winsize = 25                            -- 设置窗口宽度
vim.g.netrw_preview = 1                             -- 垂直分割时在右侧预览
vim.g.netrw_alto = 1                                -- 水平分割时在下方预览
vim.g.netrw_hide = 1                                -- 隐藏隐藏文件
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]   -- 隐藏以点开头的文件
vim.g.netrw_keepdir = 1                             -- 保持当前目录
vim.g.netrw_special_syntax = 1                      -- 启用特殊语法高亮
vim.g.netrw_localcopydircmd = 'cp -r'              -- 复制目录命令
vim.g.netrw_localmkdir = 'mkdir -p'                -- 创建目录命令
vim.g.netrw_localrmdir = 'rm -rf'                  -- 删除目录命令

-- 语法高亮
vim.opt.syntax = "enable"                            -- 启用语法高亮

-- 主题设置
vim.cmd('colorscheme catppuccin')                    -- 设置主题

-- 透明背景设置
vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none"})
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none"})

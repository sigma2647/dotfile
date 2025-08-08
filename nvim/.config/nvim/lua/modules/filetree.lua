local M = {}

-- 查找已打开的 netrw 窗口
local function find_netrw_win()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == 'netrw' then
      return win
    end
  end
  return nil
end

-- 打开侧边栏（使用 netrw Lexplore）
local function open_tree()
  vim.cmd('Lexplore')
end

-- 切换文件树（netrw）显示
function M.toggle()
  local win = find_netrw_win()
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  else
    open_tree()
  end
end

-- 设置键位映射和自动命令
function M.setup()
  -- 统一设置 netrw 全局选项（从 options.lua 移到此处）
  vim.g.netrw_banner = 0
  vim.g.netrw_liststyle = 3
  vim.g.netrw_browse_split = 4
  vim.g.netrw_altv = 1
  vim.g.netrw_fastbrowse = 2
  vim.g.netrw_silent = 1
  vim.g.netrw_keepdir = 0
  vim.g.netrw_hide = 1
  vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]
  vim.g.netrw_winsize = 25

  -- 切换文件树快捷键
  vim.keymap.set('n', '<leader>e', M.toggle, { noremap = true, silent = true, desc = 'Toggle file explorer' })

  -- 自动命令组
  local group = vim.api.nvim_create_augroup('FileTree', { clear = true })

  -- 当 netrw 是最后一个窗口时自动关闭
  vim.api.nvim_create_autocmd('BufEnter', {
    group = group,
    callback = function()
      if vim.bo.filetype == 'netrw' and vim.fn.winnr('$') == 1 then
        vim.cmd('quit')
      end
    end,
  })

  -- 为 netrw 设置缓冲区本地快捷键
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = 'netrw',
    callback = function()
      local opts = { buffer = true, noremap = true, silent = true }
      -- 刷新目录
      vim.keymap.set('n', 'R', '<cmd>edit .<cr>', opts)
      -- 新建文件/目录、重命名、删除（映射到 netrw 默认按键）
      vim.keymap.set('n', 'a', '%', opts)  -- 新建文件
      vim.keymap.set('n', 'A', 'd', opts)  -- 新建目录
      vim.keymap.set('n', 'r', 'R', opts)  -- 刷新/重命名由 netrw 内置 R/m
      vim.keymap.set('n', 'd', 'D', opts)  -- 删除
    end,
  })
end

return M

-- lua/modules/filetree.lua
local M = {}

-- 存储netrw窗口ID
local tree_winnr = nil
local tree_bufnr = nil

-- 获取窗口宽度的20%，最小15列，最大30列
local function get_width()
  local width = math.floor(vim.api.nvim_win_get_width(0) * 0.2)
  return math.max(math.min(width, 30), 15)
end

-- 创建文件树窗口
local function open_tree()
  -- 计算宽度
  local width = get_width()
  
  -- 创建左侧分割窗口
  vim.cmd('topleft vertical ' .. width .. ' new')
  tree_winnr = vim.api.nvim_get_current_win()
  tree_bufnr = vim.api.nvim_get_current_buf()
  
  -- 设置窗口和缓冲区选项
  local win_opts = {
    number = false,
    relativenumber = false,
    wrap = false,
    signcolumn = 'no',
    foldcolumn = '0',
    cursorcolumn = false,
    cursorline = true,
    colorcolumn = '0'
  }
  
  local buf_opts = {
    buftype = 'nofile',
    bufhidden = 'wipe',
    buflisted = false,
    swapfile = false,
    modifiable = false,
    filetype = 'filetree',
  }
  
  for opt, value in pairs(win_opts) do
    vim.api.nvim_win_set_option(tree_winnr, opt, value)
  end
  
  for opt, value in pairs(buf_opts) do
    vim.api.nvim_buf_set_option(tree_bufnr, opt, value)
  end
  
  -- 打开netrw并隐藏横幅
  vim.cmd('Ex')
  vim.g.netrw_banner = 0
  vim.g.netrw_liststyle = 3  -- 树状显示
  vim.g.netrw_browse_split = 4  -- 在之前的窗口中打开文件
  vim.g.netrw_winsize = width
  vim.g.netrw_altv = 1  -- 分割窗口位于右侧
end

-- 切换文件树显示
function M.toggle()
  if tree_winnr and vim.api.nvim_win_is_valid(tree_winnr) then
    vim.api.nvim_win_close(tree_winnr, true)
    tree_winnr = nil
    tree_bufnr = nil
  else
    open_tree()
  end
end

-- 设置键位映射和自动命令
function M.setup()
  -- 设置快捷键
  vim.keymap.set('n', '<leader>e', function()
    M.toggle()
  end, { noremap = true, silent = true, desc = 'Toggle file explorer' })
  
  -- 创建自动命令组
  local group = vim.api.nvim_create_augroup('FileTree', { clear = true })
  
  -- 当文件树是最后一个窗口时自动关闭
  vim.api.nvim_create_autocmd('BufEnter', {
    group = group,
    callback = function()
      if vim.bo.filetype == 'filetree' and vim.fn.winnr('$') == 1 then
        vim.cmd('quit')
      end
    end,
  })
  
  -- 设置文件树快捷键
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = 'filetree',
    callback = function()
      local opts = { buffer = true, noremap = true, silent = true }
      -- 刷新
      vim.keymap.set('n', 'R', '<cmd>Ex<cr>', opts)
      -- 创建文件
      vim.keymap.set('n', 'a', '%', opts)
      -- 创建目录
      vim.keymap.set('n', 'A', 'd', opts)
      -- 重命名
      vim.keymap.set('n', 'r', 'R', opts)
      -- 删除
      vim.keymap.set('n', 'd', 'D', opts)
    end,
  })
end

return M

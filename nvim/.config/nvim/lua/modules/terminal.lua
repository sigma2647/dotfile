-- lua/modules/terminal.lua
local M = {}

-- 私有变量
local config = {
  height = 15,
  position = 'botright',
  mapping = '<C-\\>',
  auto_insert = true,
  hide_numbers = true,      -- 隐藏行号
  hide_statusline = false,  -- 是否隐藏状态栏
  buffer_name = 'Terminal', -- 终端名称
  -- 终端退出行为
  on_exit = 'close',       -- 可选值: 'close', 'new'
  -- 可选的终端设置
  shell = vim.o.shell,     -- 使用系统默认shell
  direction = 'horizontal' -- 可选值: 'horizontal', 'vertical'
}

-- 存储终端缓冲区ID
local term_buf = nil

-- 私有函数：检查缓冲区是否有效
local function is_valid_buffer(buf)
  return buf and vim.api.nvim_buf_is_valid(buf)
end

-- 私有函数：获取终端窗口（如果存在）
local function find_term_win()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if buf == term_buf then
      return win
    end
  end
  return nil
end

-- 私有函数：设置终端缓冲区选项
local function setup_terminal_buffer(buf)
  -- 设置缓冲区选项
  vim.api.nvim_buf_set_option(buf, 'buflisted', false)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'hide')
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'modified', false)
  
  -- 隐藏行号
  if config.hide_numbers then
    vim.api.nvim_win_set_option(0, 'number', false)
    vim.api.nvim_win_set_option(0, 'relativenumber', false)
    vim.api.nvim_win_set_option(0, 'signcolumn', 'no')
  end
  
  -- 设置缓冲区名称
  if config.buffer_name then
    pcall(function()
      vim.api.nvim_buf_set_name(buf, config.buffer_name)
    end)
  end
  
  -- 可选：隐藏状态栏
  if config.hide_statusline then
    vim.api.nvim_win_set_option(0, 'statusline', ' ')
  end
end

-- 私有函数：创建分割窗口
local function create_split()
  if config.direction == 'vertical' then
    vim.cmd(string.format('%s vsplit', config.position))
  else
    vim.cmd(string.format('%s split', config.position))
  end

  -- 设置窗口大小
  if config.direction == 'vertical' then
    vim.cmd(string.format('vertical resize %d', config.height))
  else
    vim.cmd(string.format('resize %d', config.height))
  end
end

-- 私有函数：创建或显示终端
local function create_or_show_terminal()
  create_split()
  
  if is_valid_buffer(term_buf) then
    vim.api.nvim_win_set_buf(0, term_buf)
  else
    -- 简化的终端创建方式
    vim.cmd('terminal')
    term_buf = vim.api.nvim_get_current_buf()
    setup_terminal_buffer(term_buf)
  end
  
  if config.auto_insert then
    vim.cmd('startinsert')
  end
end

-- 公开函数：切换终端
function M.toggle()
  local term_win = find_term_win()
  
  if term_win then
    -- 如果终端已打开，关闭它
    vim.api.nvim_win_close(term_win, true)
  else
    create_or_show_terminal()
  end
end

-- 公开函数：设置配置
function M.setup(user_config)
  -- 合并用户配置
  if user_config then
    config = vim.tbl_deep_extend('force', config, user_config)
  end
  
  -- 设置快捷键
  vim.keymap.set({'n', 't'}, config.mapping, function()
    M.toggle()
  end, { desc = 'Toggle terminal', silent = true })

  -- 设置自动命令
  local group = vim.api.nvim_create_augroup('TerminalModule', { clear = true })
  
  -- 终端打开时自动进入插入模式
  if config.auto_insert then
    vim.api.nvim_create_autocmd('TermOpen', {
      group = group,
      pattern = '*',
      callback = function(event)
        -- 只处理我们的终端缓冲区
        if event.buf == term_buf then
          setup_terminal_buffer(event.buf)
        end
        vim.cmd('startinsert')
      end,
    })
  end
  
  -- 终端关闭处理
  vim.api.nvim_create_autocmd('TermClose', {
    group = group,
    callback = function()
      if config.on_exit == 'close' then
        if #vim.api.nvim_list_wins() > 1 then
          vim.cmd('close')
        else
          vim.cmd('enew')
        end
        term_buf = nil
      elseif config.on_exit == 'new' then
        term_buf = nil
        create_or_show_terminal()
      end
    end,
  })

  -- 可选：设置终端特定的选项
  vim.api.nvim_create_autocmd('TermEnter', {
    group = group,
    callback = function()
      -- 在终端模式下可以添加特定设置
      vim.opt_local.scrolloff = 0
      vim.opt_local.sidescrolloff = 0
    end,
  })
end

-- 公开函数：获取当前终端缓冲区
function M.get_term_buf()
  return term_buf
end

-- 公开函数：发送命令到终端
function M.send_command(cmd)
  if is_valid_buffer(term_buf) then
    vim.api.nvim_chan_send(vim.bo[term_buf].channel, cmd .. '\n')
  end
end

-- 公开函数：重新启动终端
function M.restart()
  if term_buf then
    if find_term_win() then
      vim.api.nvim_win_close(find_term_win(), true)
    end
    term_buf = nil
    M.toggle()
  end
end

return M

function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "                                   -- 设置leader键为空格
map("n", "<leader>w", ":w<CR>")              -- 保存文件

map("n", "<leader>q", ":q<CR>")              -- 退出Neovim

map("n", "<leader>v", ":vsplit<CR>")         -- 分屏
map("n", "<leader>h", ":split<CR>")


map('n', '<C-h>', ':wincmd h<CR>')                  -- 设置窗口导航快捷键
map('n', '<C-j>', ':wincmd j<CR>')                  -- 设置窗口导航快捷键
map('n', '<C-k>', ':wincmd k<CR>')                  -- 设置窗口导航快捷键
map('n', '<C-l>', ':wincmd l<CR>')                  -- 设置窗口导航快捷键

map("n", "H", "^")
map("n", "L", "$")
map("v", "H", "^")
map("v", "L", "$")
map("n", "<leader>h", ":nohlsearch<CR>")
map("n", "Q", ":q<CR>")
map("n", "S", ":w<CR>")

map("n", "<tab>", ":bn<CR>")
map("n", "<s-tab>", ":bp<CR>")


map("v", "p", 'P')                          -- visual模式下覆盖粘贴不污染剪贴板


-- insert mode specific
map('i', '<A-b>', '<S-Left>', { silent = false })
map('i', '<A-f>', '<S-Right>', { silent = false })
map('i', '<C-a>', '<home>', { silent = false })
map('i', '<C-e>', '<end>', { silent = false })
map('i', '<C-b>', '<left>', { silent = false })
map('i', '<C-f>', '<right>', { silent = false })
map('i', '<C-k>', '<C-o>D', { silent = false })

map('i', '<C-c>', '<Esc>')

-- Command mode specific
map('c', '<A-b>', '<S-Left>', { silent = false })
map('c', '<A-f>', '<S-Right>', { silent = false })
map('c', '<C-a>', '<home>', { silent = false })
map('c', '<C-e>', '<end>', { silent = false })
map('c', '<C-b>', '<left>', { silent = false })
map('c', '<C-f>', '<right>', { silent = false })
map('c', '<C-k>', '<C-\\>e getcmdpos() == 1 ? "" : getcmdline()[:getcmdpos()-2]<CR>',{ silent = false })

-- 终端相关快捷键
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move to left window' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move to bottom window' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move to top window' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move to right window' })


-- 缩进操作保持 Visual 模式
map('v', '<', '<gv')
map('v', '>', '>gv')

vim.keymap.set("n", "<leader>n", function()
  local is_number = vim.wo.number
  if is_number then
    vim.wo.number = false
    vim.wo.relativenumber = false
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
  end
end, { desc = "Toggle line numbers" })


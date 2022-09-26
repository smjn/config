local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

map('n', '<leader>n', ':NERDTreeToggle<CR>', opts)
map('n', 'C-h', ':set nohlsearch!<CR>', opts)

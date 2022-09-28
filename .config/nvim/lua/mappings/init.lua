local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

vim.g.mapleader = " "

map("n", "<leader>n", ":NERDTreeToggle<CR>", opts)
map("n", "C-h", ":set nohlsearch!<CR>", opts)

local function smjn_toggleTransparentBg()
    if not vim.g.smjn_transparent_enabled or vim.g.smjn_transparent_enabled ~= 1 then
        vim.g.smjn_transparent_enabled = 1
        vim.api.nvim_exec("hi Normal guibg=None ctermbg=None", true)
    else
        local co = vim.api.nvim_exec("colorscheme", true)
        vim.cmd("colorscheme " .. co)
        vim.g.smjn_transparent_enabled = 0
    end
end

vim.keymap.set("n", "<leader>o", smjn_toggleTransparentBg, opts)
vim.keymap.set("n", "<leader>h", ":set nohlsearch!<CR>", opts)

-- Telescope
vim.keymap.set("n", "<leader>ff",
               "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({previewer=false}))<CR>",
               opts)
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
vim.keymap.set("n", "<leader>fc", ":Telescope colorscheme<CR>", opts)

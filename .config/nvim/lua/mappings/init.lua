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

vim.keymap.set("n", "<leader>h", smjn_toggleTransparentBg, opts)

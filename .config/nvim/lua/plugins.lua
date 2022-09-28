return require("packer").startup(function()
    use "wbthomason/packer.nvim"
    use "EdenEast/nightfox.nvim"
    use "preservim/nerdtree"
    use {
        "w0rp/ale",
        ft = {
            "sh", "zsh", "bash", "html", "markdown", "vim", "python", "lua",
            "c", "cpp"
        },
        cmd = "ALEEnable",
        config = "vim.cmd[[ALEEnable]]"
    }
    use "tpope/vim-commentary"
    use "tpope/vim-surround"
    use "kien/ctrlp.vim"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-cmp" -- Autocompletion plugin
    use "hrsh7th/cmp-nvim-lsp" -- LSP source for nvim-cmp
    use "saadparwaiz1/cmp_luasnip" -- Snippets source for nvim-cmp
    use "L3MON4D3/LuaSnip" -- Snippets plugin
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use {
        "luochen1990/rainbow",
        config = function() vim.g.rainbow_active = 1 end
    }
    use "morhetz/gruvbox"
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
end)

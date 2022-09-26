return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'EdenEast/nightfox.nvim' 
    use 'preservim/nerdtree'
    use {
        'w0rp/ale',
        ft = {'sh', 'zsh', 'bash', 'html', 'markdown', 'vim', 'python'},
        cmd = 'ALEEnable',
        config = 'vim.cmd[[ALEEnable]]'
    }
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'kien/ctrlp.vim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use {
        'luochen1990/rainbow',
        config = function()
            vim.g.rainbow_active = 1
        end
    }
    use 'vim-airline/vim-airline'
    use {
        'vim-airline/vim-airline-themes',
        config = function()
            vim.g.airline_theme = 'minimalist'
        end
    }
    use 'morhetz/gruvbox'
end)

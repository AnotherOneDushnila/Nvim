vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use))

    use 'wbthomason/packer.nvim


    use { "catppuccin/nvim", as = "catppuccin" } -- catppuccin
	use { "morhetz/gruvbox", as = "gruvbox" }
	use { "ldelossa/vimdark", as = "vimdark" }
	use { "hachy/eva01.vim", as = "eva01" } -- neon
	use { "savq/melange-nvim", as = "melange" } -- mars
	use { "EdenEast/nightfox.nvim", as = "nightfox" } -- uranus
	use { "smallwat3r/vim-efficient", as = "vim-efficient" }
	use { "zacanger/angr.vim", as = "angr" }
	use { "pbrisbin/vim-colors-off", as = "vim-colors-off" }


	use {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig'
	}

    use {
        "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
      }
    }

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })


    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
      -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
      end}

    use("catgoose/nvim-colorizer.lua")

    use 'norcalli/nvim-colorizer.lua'
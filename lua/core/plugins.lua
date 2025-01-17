require("packer").startup(function()
    -- Plugin Loader
    use("wbthomason/packer.nvim")

    -- For performance
    use("lewis6991/impatient.nvim")

    -- lua snippet engine
    use({
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!:).
	run = "make install_jsregexp"
    })

    -- Language Server installer
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    -- LSP
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("configs.lspconfig")
        end,
    })

    -- Autocompletion
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("configs/cmp")
        end,
    })
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lua")

    -- snippets
    use("rafamadriz/friendly-snippets")

    -- Utils
    use("nvim-lua/plenary.nvim")
    use("jose-elias-alvarez/null-ls.nvim")
    use("tpope/vim-surround")

    -- Sessions
    use("rmagatti/auto-session")

    -- Customisation
    use("navarasu/onedark.nvim")
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("configs.lualine")
        end,
    })
    use("arkav/lualine-lsp-progress")
    use("kyazdani42/nvim-web-devicons")

    -- Code
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("configs.nvim-treesitter")
        end,
    })
    use({
        "folke/todo-comments.nvim",
        config = function()
            require("configs.todo-comments")
        end,
    })
    use({
        "christoomey/vim-sort-motion",
    })
    use("jose-elias-alvarez/typescript.nvim")
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("configs.trouble")
        end,
    })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("configs.comment")
        end,
    })
    -- Fix commenting in TS contexts (with embedded languages)
    use({
        "JoosepAlviste/nvim-ts-context-commentstring",
    })

    -- Git
    use("tpope/vim-fugitive")
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("configs.gitsigns")
        end,
    })

    -- Searching

    -- fzf
    -- Lua nice api wrapping
    use({
        "ibhagwan/fzf-lua",
        -- optional for icon support
        requires = { "nvim-tree/nvim-web-devicons" },
    })
    -- base package, just installs fzf
    use({ "junegunn/fzf", run = "./install --bin" })

    use("tpope/vim-abolish")

    -- File tree
    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("configs.nvim-tree")
        end,
    })

    -- Code runing
    use({
        "michaelb/sniprun",
        run = "bash install.sh",
    })

    -- Colorscheme
    use({
        "bluz71/vim-nightfly-colors",
        name = "nightfly",
    })
end)

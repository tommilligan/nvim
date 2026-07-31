-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        scope = {
          -- Disable annoying visual noise for current indent indications
          enabled = false,
        },
      },
    },
  },

  -- Theme files for colorscheme.
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
  },

  -- Configure LazyVim to load theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightfly",
    },
  },

  -- Ensure additional treesitter languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "rust" } },
  },

  -- Diagnostics and formatting for Rust files
  {
    "mrcjkb/rustaceanvim",
  },
  -- Help write Cargo.toml files with right names and versions
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup()
    end,
  },
}

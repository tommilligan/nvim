-- Go support tuned for a work monorepo. Overrides the parts of LazyVim's lang.go extra
-- (imported in config/lazy.lua) that don't match its CI.
--
-- Go binaries come from mise, not Mason:
--   gopls          global mise config (~/.config/mise/config.toml)
--   goimports      the repo's `make tools` (from its tools.go)
--   golangci-lint  the repo's mise.toml
-- The last two are only on PATH when nvim is started from a shell inside that repo.

-- Go tools the extras would otherwise have Mason install.
local not_from_mason = { "goimports", "gofumpt", "golangci-lint", "delve" }

return {
  {
    "neovim/nvim-lspconfig",
    -- Plain-table opts are deep-merged with the extra's, so only changed keys are listed.
    opts = {
      servers = {
        gopls = {
          mason = false, -- start gopls from PATH instead of installing it with Mason
          settings = {
            gopls = {
              gofumpt = false, -- CI checks plain gofmt
              staticcheck = false, -- CI only runs the SA checks; the full set is noise
              -- Inline type hints: keep parameter names only.
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = true,
                rangeVariableTypes = false,
              },
            },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    -- Lists replace rather than merge, so this drops the extra's gofumpt.
    -- goimports is gofmt plus adding/removing imports.
    opts = {
      formatters_by_ft = {
        go = { "goimports" },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    -- ensure_installed is an `opts_extend` list: plain tables append to it and can't
    -- remove entries. A function receives the options merged so far and filters them.
    -- Specs that load after this file can still add Go tools back.
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not vim.tbl_contains(not_from_mason, tool)
      end, opts.ensure_installed or {})
    end,
  },

  {
    "mfussenegger/nvim-lint",
    -- The extra already lints Go with golangcilint. Drop LazyVim's default InsertLeave
    -- trigger, which is too heavy for a large repo. This applies to all filetypes.
    opts = {
      events = { "BufWritePost", "BufReadPost" },
    },
  },
}

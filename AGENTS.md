# Agent context: nvim config

A personal Neovim config built on [LazyVim](https://github.com/LazyVim/LazyVim) (started
from LazyVim/starter). Requires Neovim 0.12+.

**This repo is public on GitHub.** Never commit secrets or references to private
information: no employer or company names, private repo names, internal paths or URLs,
or work email addresses. Refer to work context generically ("at work", "the work repo").

## Layout

| Path | Purpose |
|---|---|
| `init.lua` | Entry point. Only does `require("config.lazy")`. |
| `lua/config/lazy.lua` | Bootstraps lazy.nvim and declares the spec: LazyVim core, then extras, then `lua/plugins/`. |
| `lua/config/options.lua` | Editor options (clipboard, 2-space indent, no wrap, no conceal, no animations). |
| `lua/config/keymaps.lua` | User keymaps (currently empty). |
| `lua/config/autocmds.lua` | User autocmds (Go line-length settings). |
| `lua/plugins/*.lua` | User plugin specs. Each file returns a list of specs. `example.lua` holds the theme, snacks tweaks, Rust and TypeScript. `go.lua` holds Go. |
| `lazyvim.json` | Extras enabled through `:LazyExtras` (currently none; extras are imported explicitly in `lazy.lua` instead). |
| `lazy-lock.json` | Pinned plugin commits. Updated by `:Lazy sync` / `:Lazy update`; commit it separately from config changes. |
| `stylua.toml` | Lua formatting: 2 spaces, 120 columns. |
| `.neoconf.json` | lua_ls settings for editing this config. |

Installed plugin sources, including LazyVim's own defaults, live in
`~/.local/share/nvim/lazy/<plugin>/`. Read them there instead of guessing defaults, e.g.
`LazyVim/lua/lazyvim/plugins/extras/lang/go.lua` or
`LazyVim/lua/lazyvim/plugins/lsp/init.lua`.

## Startup order

1. `init.lua` → `lua/config/lazy.lua` clones lazy.nvim if needed, then `require("lazy").setup`.
2. LazyVim loads `config/options.lua` **before** plugins start up.
3. Specs are collected in this order:
   1. LazyVim core (`lazyvim.plugins`)
   2. each extra, in its import order in `lazy.lua`, including specs nested in an
      extra's `dependencies`
   3. `lua/plugins/*.lua`, alphabetically by file name
4. `config/autocmds.lua` loads at startup when nvim is given a file argument, and
   otherwise on `VeryLazy`. `config/keymaps.lua` loads on `VeryLazy`.
5. `VeryLazy` fires on `UIEnter`. Format-on-save, nvim-lint triggers and treesitter parser
   installs are all set up around then.

## How plugin `opts` merge

Several specs can configure the same plugin. lazy.nvim applies their `opts` in spec order
(see `_values` in `lazy.nvim/lua/lazy/core/plugin.lua`):

- **Plain table:** deep-merged into the result so far. **Lists replace** the existing list
  (e.g. `formatters_by_ft.go = { "goimports" }` drops the extra's `gofumpt`).
- **Keys named in the plugin's `opts_extend`** are **appended** instead. Examples are
  `ensure_installed` for Mason and nvim-treesitter. A plain table can only add to these,
  never remove.
- **Function `opts(plugin, opts)`:** receives the result so far and can edit or return it.
  Use this to remove entries or keys. It only sees specs applied **before** it, so a later
  file can undo it.
- An empty table `{}` merges as a no-op. To delete a key, use a function or `vim.NIL`.

## Interactions with LazyVim defaults

- **Mason is enabled** by LazyVim. It installs `lua-language-server`, `stylua`, `shfmt`, and
  `tree-sitter-cli` (needed to compile treesitter parsers). It puts its `bin` **first** on
  PATH, so anything it installs hides system or mise binaries of the same name.
- **Tools come from local installs, not Mason**, where the project pins them. TypeScript
  uses the project's `tsc`. Go uses mise-managed binaries:
  - LSP servers: set `mason = false` in the server's opts, so LazyVim starts the binary
    from PATH.
  - Formatters and linters added by extras: filter them out of Mason's `ensure_installed`
    with a function `opts` (see `lua/plugins/go.lua`).
- **Personal Go tools** (gopls, dlv) are pinned in `~/.config/mise/config.toml` using the
  `go:` backend. Repo-specific tools come from that repo's mise config, so nvim must be
  started from a shell inside the repo (zsh runs `mise activate`).
- **Rust** uses `rustaceanvim` and `crates.nvim` directly, not the LazyVim extra.
  TypeScript uses `typescript-tools.nvim`.
- **Indentation:** `options.lua` sets `expandtab` with width 2 globally. Neovim's Go
  ftplugin overrides it with `noexpandtab` for Go buffers.
- LazyVim leaves **codelens** display off and **inlay hints** on. The Go extra turns on
  every gopls hint; `go.lua` cuts them back.

## Preferences

- **Minimal visual noise:** animations off, indent scope off, `conceallevel = 0`, fewer
  inlay hints.
- **Fewer tools.** Add capabilities step by step, each reviewable on its own.
- **Comments** should explain non-obvious Lua and LazyVim behaviour inline, briefly.
- **Commit messages** are short and lowercase, e.g. "add typescript lsp/lazy config".

## Testing changes headlessly

```sh
nvim --headless "+Lazy! install" +qa   # install missing plugins (doesn't update the lockfile like :Lazy sync)
```

Gotchas when scripting checks:

- `+cmd` / `+luafile` run **before** `VimEnter`, so `VeryLazy` setup (format-on-save, lint
  autocmds, parser installs) hasn't happened yet.
- Headless nvim never fires `UIEnter`, so `VeryLazy` never fires on its own. Register
  `VimEnter` → `vim.schedule(function() vim.cmd("doautocmd UIEnter") end)`, then run checks
  from a `User VeryLazy` callback.
- Add a `vim.defer_fn(function() vim.cmd("qa!") end, ms)` hard stop, so a missed event
  can't hang the run.
- `print` output after startup may not reach stdout. Write results to a file with
  `vim.fn.writefile`.
- To read resolved plugin options without starting the plugin:
  `require("lazy.core.plugin").values(require("lazy.core.config").plugins["<name>"], "opts", false)`.

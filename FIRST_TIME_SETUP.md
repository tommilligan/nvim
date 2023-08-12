# First time setup

## System

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\\n ~/.local/share/nvim/site/pack/packer/start/packer.nvim
npm install -g typescript typescript-language-server eslint_d bash-language-server @fsouza/prettierd
cargo install stylua selene
```

## nvim

```vim
:PackerSync
```

## Mason

```vim
:MasonInstall rust-analyzer codelldb rustfmt
```

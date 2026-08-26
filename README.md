# Nvim Files

Based on Neovim from scratch https://github.com/LunarVim/Neovim-from-scratch

## Setup on a new machine (macOS or Fedora Linux)

```sh
git clone https://github.com/weldyss/nvimfiles.git ~/.config/nvim
bash ~/.config/nvim/scripts/install-deps.sh
nvim
```

`scripts/install-deps.sh` installs everything this config depends on for both
platforms:

- LSP servers: `lua_ls`, `pyright`, `ts_ls` (typescript-language-server), `gopls`
- CLI tools used by plugins: `ripgrep`/`fd` (telescope), `lazygit`, `glow`
- Build tools required by `nvim-treesitter` to compile parsers (`gcc`, `make`)
- Neovim remote plugin providers (`:checkhealth provider`): `pynvim` (Python),
  `neovim` npm package (Node.js), `neovim` gem (Ruby)
- `deno`, required by the `vim-denops/denops.vim` plugin

It's safe to re-run any time — every step skips already-installed tools.

On first launch, Packer will bootstrap itself and install all plugins
(`:PackerSync` if anything looks incomplete), and `nvim-treesitter` will
install its curated parser list automatically.


local configs = require("nvim-treesitter.configs")
configs.setup {
  ensure_installed = "all",
  sync_install = false,
  ignore_install = { "blueprint", "fusion", "ipkg", "jsonc", "t32" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
}

require("ts_context_commentstring").setup {
  enable_autocmd = false,
}

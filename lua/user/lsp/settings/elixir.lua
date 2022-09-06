-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
return {
  filetypes = { "elixir", "ex", "exs", "eex", "leex", "sface", "eexilir", "heex" },
  repo = "mhanberg/elixir-ls", -- defaults to elixir-lsp/elixir-ls
  branch = "mh/all-workspace-symbols", -- defaults to nil, just checkouts out the default branch, mutually exclusive with the `tag` option
  tag = "v0.9.0", -- defaults to nil, mutually exclusive with the `branch` option

  cmd = { "/home/weldyss/.local/share/nvim/lsp_servers/elixir/elixir-ls/language_server.sh" },
  dialyzerEnabled = true,
  fetchDeps = true,
  enableTestLenses = false,
  suggestSpecs = false
}

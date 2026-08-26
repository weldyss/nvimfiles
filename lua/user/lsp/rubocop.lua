vim.lsp.config.rubocop = {
  cmd = { "bundle", "exec", "rubocop", "--lsp" },
  root_markers = { 'Gemfile', '.git' },
  filetypes = { 'ruby' },
}

vim.lsp.enable("rubocop")

-- NOTE: keymaps, format-on-save and completion for this client are wired up
-- generically for any LSP client in user.lsp.servers (LspAttach autocmd),
-- so this file only needs to declare/enable the server itself.

vim.cmd("set completeopt+=noselect")

vim.diagnostic.config({
  virtual_lines = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
    header = "",
    prefix = "",
  },
})

vim.lsp.config.rubocop = {
  cmd = { 'rubocop', '--lsp' },
  root_markers = { 'Gemfile', '.git' },
  filetypes = { 'ruby' },
}

vim.lsp.enable("rubocop")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({
            filter = function(c)
              return c.name == "rubocop"
            end,
            bufnr = ev.buf,
          })
        end,
      })
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion. enable(true, client.id, ev.buf, { autotrigger = true }) end
    end
})

vim.cmd("set completeopt+=noselect")

vim.diagnostic.config({
  virtual_lines = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
    header = "",
    prefix = "",
  },
})

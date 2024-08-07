local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not_status_ok then
  return
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server.name == "jsonls" then
    local jsonls_opts = require("user.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server.name == "pyright" then
    local pyright_opts = require("user.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server.name == "elixirls" then
    local elixir_opts = require("user.lsp.settings.elixir")
    opts = vim.tbl_deep_extend("force", elixir_opts, opts)
  end

  if server.name == "tsserver" then
    local ts_opts = require("user.lsp.settings.tsserver")
    opts = vim.tbl_deep_extend("force", ts_opts, opts)
  end

  if server.name == "stimulus_lsp" then
    local stimulus_opts = require("user.lsp.settings.stimulus_lsp")
    opts = vim.tbl_deep_extend("force", stimulus_opts, opts)
  end

  server:setup(opts)

end)

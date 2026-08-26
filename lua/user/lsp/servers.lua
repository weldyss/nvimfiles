-- Common general-purpose LSP servers, wired up via Neovim's native
-- vim.lsp.enable/vim.lsp.config API (same approach as rubocop.lua/html.lua),
-- using the default server configs shipped by nvim-lspconfig.
--
-- All binaries below (lua-language-server, pyright, ts_ls, gopls) can be
-- installed on both macOS and Fedora Linux by running:
--   bash ~/.config/nvim/scripts/install-deps.sh

-- needed to install "lua-language-server" (see scripts/install-deps.sh)
vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
vim.lsp.enable("lua_ls")

-- needed to install "pyright" (npm install -g pyright)
vim.lsp.enable("pyright")

-- needed to install "typescript-language-server" (npm install -g typescript typescript-language-server)
vim.lsp.enable("ts_ls")

-- needed to install "gopls" (go install golang.org/x/tools/gopls@latest)
vim.lsp.enable("gopls")

-- Generic keymaps/format-on-save/completion wiring, applied to ANY LSP client
-- that attaches (rubocop, html/cssls/stimulus_ls included), not just the ones above.
local augroup = vim.api.nvim_create_augroup("UserLspGeneralServers", {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "lr", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>lf", function() vim.lsp.buf.format { async = true } end, bufopts)

    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = ev.buf, event = "BufWritePre" })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, filter = function(c) return c.id == client.id end })
        end,
      })
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

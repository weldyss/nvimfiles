local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

    vim.keymap.set('n', 'lr', vim.lsp.buf.rename, bufopts)

    vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
end 


--[[ require("user.lsp.mason") ]]
--[[ require("user.lsp.handlers").setup() ]]
--[[ require("user.lsp.null-ls") ]]
require("user.lsp.ruby_lsp")
require("user.lsp.rubocop")
require("user.lsp.html")

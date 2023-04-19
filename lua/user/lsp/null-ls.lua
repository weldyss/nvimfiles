local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local ruby_code_actions = require("ruby-code-actions")

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
    formatting.black.with { extra_args = { "--fast" } },
    code_actions.gitsigns,
    formatting.rubocop,
    diagnostics.rubocop,
    formatting.stylua,
    diagnostics.eslint,

    ruby_code_actions.insert_frozen_string_literal,
    ruby_code_actions.autocorrect_with_rubocop
  },
}

local trouble_status_ok, trouble = pcall(require, "trouble")
if not trouble_status_ok then
  return
end

-- NOTE: trouble.nvim was rewritten upstream; this uses the current config schema
-- (the previous v1-style options like `mode`/`action_keys`/`signs` are gone/ignored).
trouble.setup {
  auto_open = false, -- automatically open the list when you have diagnostics
  auto_close = false, -- automatically close the list when you have no diagnostics
  auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_jump = false, -- for the given modes, automatically jump if there is only a single result
  focus = false,
  indent_guides = true, -- add an indent guide below the fold icons
  win = {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    size = 10, -- height/width of the list depending on position
  },
  preview = {
    type = "main",
    scratch = true,
  },
  keys = {
    ["?"] = "help",
    q = "close", -- close the list
    ["<esc>"] = "cancel", -- cancel the preview and get back to your last window / buffer / cursor
    r = "refresh", -- manually refresh
    ["<cr>"] = "jump", -- jump to the diagnostic or open / close folds
    ["<tab>"] = "jump",
    ["<c-s>"] = "jump_split", -- open buffer in new split
    ["<c-v>"] = "jump_vsplit", -- open buffer in new vsplit
    o = "jump_close", -- jump to the diagnostic and close the list
    P = "toggle_preview", -- toggle auto_preview
    p = "preview", -- preview the diagnostic location
    zM = "fold_close_all", -- close all folds
    zm = "fold_close_all",
    zR = "fold_open_all", -- open all folds
    zr = "fold_open_all",
    zA = "fold_toggle_recursive", -- toggle fold of current file
    za = "fold_toggle",
    k = "prev", -- previous item
    j = "next", -- next item
  },
}

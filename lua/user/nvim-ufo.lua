local status_ok, nvim_ufo = pcall(require, "nvim-ufo")
if not status_ok then
  return
end

nvim_ufo.setup({
  open_fold_hl_timeout = 150,
  close_fold_kinds = {'imports', 'comment'},
  preview = {
    win_config = {
      border = {'', '─', '', '', '', '─', '', ''},
      winhighlight = 'Normal:Folded',
      winblend = 0
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>'
    }
  },
  provider_selector = function(bufnr, filetype, buftype)
    return ftMap[filetype]
  end
})

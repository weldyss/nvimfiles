local status_ok, obsidian = pcall(require, "obsidian")
if not status_ok then
  return
end

obsidian.setup {
  dir = "~/Documents/Notes/notes",
  daily_notes = {
    folder = "daily",
  },
  completion = {
    nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
  }
}

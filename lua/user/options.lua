-- got from :help options
local options = {
  backup = false,
  cmdheight = 2,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  mousemodel="popup",
  termguicolors = true,
  pumheight = 10,
  autoindent = true,
  autoread = true,
  ruler = true,
  showmode = false,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  timeoutlen = 1000,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  cursorline = true,
  number = true,
  relativenumber = false,
  numberwidth = 4,
  wrap = true,
  scrolloff = 8,
  signcolumn = "yes",
  sidescrolloff = 8,
  listchars = "nbsp:☠,tab:▸␣,eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:•",
  list = true,
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldcolumn = "1",
  foldlevel = 99,
  foldlevelstart = -1,
  foldenable = true
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

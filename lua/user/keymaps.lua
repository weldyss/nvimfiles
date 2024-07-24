local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap comma as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--      normal       = "n"
--      insert       = "i"
--      visual       = "v"
--      visual_block = "x"
--      terminal     = "t"
--      command      = "c"

-- Normal mode
keymap("n", "<esc>", "<Nop>", opts)

-- Yanking current file path
keymap("n", "<A-y>", ":let @*=expand(\"%\")<CR>", opts)

-- Window Navigation
keymap("n", "<C-h>", "C-w>h", opts)
keymap("n", "<C-j>", "C-w>j", opts)
keymap("n", "<C-k>", "C-w>k", opts)
keymap("n", "<C-l>", "C-w>l", opts)

keymap("n", "<leader>e", ":Neotree toggle<cr>", opts)
keymap("n", "<leader>g", ":Neotree float git_status<cr>", opts)
keymap("n", "<leader>bf", ":Neotree right buffers<cr>", opts)
keymap("n", "<leader>ff", "<cmd>Lf<cr>",opts)

-- Tab Navigation
keymap("n", "<C-T>", ":tabclose<cr>", opts)
keymap("n", "<C-t>", ":tabnew<cr>", opts)
keymap("n", "<C-[>", ":tabprevious<cr>", opts)
keymap("n", "<C-]>", ":tabnext<cr>", opts)

-- Buffer navigations
keymap("n", "<S-h>", ":bprevious<cr>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
--
-- Re-order to previous/next
keymap("n", "<A-<>", ":BufferLineMovePrev<CR>", opts)
keymap("n", "<A->>", ":BufferLineMoveNext<CR>", opts)
--
-- Goto buffer in position...
keymap("n", '<A-1>', ":BufferLineGoToBuffer 1<CR>", opts)
keymap("n", '<A-2>', ":BufferLineGoToBuffer 2<CR>", opts)
keymap("n", '<A-3>', ":BufferLineGoToBuffer 3<CR>", opts)
keymap("n", '<A-4>', ":BufferLineGoToBuffer 4<CR>", opts)
keymap("n", '<A-5>', ":BufferLineGoToBuffer 5<CR>", opts)
keymap("n", '<A-6>', ":BufferLineGoToBuffer 6<CR>", opts)
keymap("n", '<A-7>', ":BufferLineGoToBuffer 7<CR>", opts)
keymap("n", '<A-8>', ":BufferLineGoToBuffer 8<CR>", opts)
keymap("n", '<A-9>', ":BufferLineGoToBuffer 9<CR>", opts)

-- Pin/unpin buffer
keymap('n', '<A-p>', ':BufferLineTogglePin<CR>', opts)

-- Close buffer
keymap('n', '<A-c>', ':BufferLinePickClose<CR>', opts)

-- Create buffers
keymap("n", "<leader>sp", ":split<CR>", opts)
keymap("n", "<leader>vs", ":vsplit<CR>", opts)

-- Resize buffers/splits
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Clear highlighted search
keymap("n", "<CR>", ":nohlsearch<CR>", opts)

-- insert mode

-- kk to go to normal
keymap("i", "kk", "<esc>", opts)

-- Visual mode

-- Indent text mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block
-- Move block up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal mode
-- Terminal Navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- keymap ("n" "<leader>f", <cmd>Telescope find_files<cr>, opts)
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>p", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>o", "<cmd>Telescope buffers<cr>", opts)

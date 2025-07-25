local fn = vim.fn

-- Installing Packer automatically
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end


-- Autocommand that reloads neovim when saving plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- To not see errors on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Having popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install plugins
return packer.startup(function(use)
  -- Put plugins here
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "folke/tokyonight.nvim"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "windwp/nvim-autopairs"
  use "numToStr/Comment.nvim"
  use "L3MON4D3/LuaSnip"
  use "onsails/lspkind-nvim"
  use "windwp/nvim-ts-autotag"
  use "rafamadriz/friendly-snippets"
  use "akinsho/bufferline.nvim"
  use "tiagovla/scope.nvim"
  use "moll/vim-bbye"
  use "akinsho/toggleterm.nvim"
  use{"folke/trouble.nvim", requires = "nvim-tree/nvim-web-devicons"}
  use "David-Kunz/cmp-npm"
  use ({'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }})
  use 'NvChad/nvim-colorizer.lua'

  -- Tree
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }

  -- Searching files
  use 'nvim-pack/nvim-spectre'

  -- LSP installations
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  use "github/copilot.vim"
  use 'vim-denops/denops.vim'
  use 'nekowasabi/aider.vim'
  use ({ "nekowasabi/aider.vim"
  , dependencies = "vim-denops/denops.vim"
  , config = function()
    vim.g.aider_command = 'aider --no-auto-commits'
    vim.g.aider_buffer_open_type = 'floating'
    vim.g.aider_floatwin_width = 100
    vim.g.aider_floatwin_height = 20

    vim.api.nvim_create_autocmd('User',
      {
        pattern = 'AiderOpen',
        callback =
            function(args)
              vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = args.buf })
              vim.keymap.set('n', '<Esc>', '<cmd>AiderHide<CR>', { buffer = args.buf })
            end
      })
    vim.api.nvim_set_keymap('n', '<C>at', ':AiderRun<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C>aa', ':AiderAddCurrentFile<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C>ar', ':AiderAddCurrentFileReadOnly<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C>aw', ':AiderAddWeb<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C>ax', ':AiderExit<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C>ai', ':AiderAddIgnoreCurrentFile<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C>aI', ':AiderOpenIgnore<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C>aI', ':AiderPaste<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C>ah', ':AiderHide<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<C>av', ':AiderVisualTextWithPrompt<CR>', { noremap = true, silent = true })
  end
  })

  use('MunifTanjim/prettier.nvim')
  use({ "mhanberg/elixir.nvim", requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" }})

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-symbols.nvim"

  -- Highlight words
  use "RRethy/vim-illuminate"
  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  use "kdheepak/lazygit.nvim"
  use "lewis6991/gitsigns.nvim"

  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  }

  use({
    "lmburns/lf.nvim",
    config = function()
      -- This feature will not work if the plugin is lazy-loaded
      vim.g.lf_netrw = 1

      require("lf").setup({
        escape_quit = false,
        border = "rounded",
      })

      vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")

    end,
    requires = {"toggleterm.nvim"}
  })

  use {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    }
  }

  -- Markdown plugins
  use "ellisonleao/glow.nvim"
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  use "renerocksai/calendar-vim"

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

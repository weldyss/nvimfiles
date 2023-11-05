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
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"
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

  -- LSP installations
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use({"jose-elias-alvarez/null-ls.nvim", requires = { {'nvim-lua/plenary.nvim'}, {'semanticart/ruby-code-actions.nvim'}}})

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

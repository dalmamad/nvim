local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim"}, -- Useful lua functions used by lots of plugins
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.toggleterm")
    end,
  },
  {
    "willothy/flatten.nvim",
    config = true,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("plugins.alpha")
    end,
  },
  {
    "folke/which-key.nvim",
    commit = "61553aeb3d5ca8c11eea8be6eadf478062982ac9",
    config = function()
      require("plugins.whichkey")
    end,
  },
  { "moll/vim-bbye",                    commit = "25ef93ac5a87526111f43e5110675032dbcacf56" },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("plugins.bufferline")
    end,
  },
  {
    "lewis6991/impatient.nvim",
    commit = "d3dd30ff0b811756e735eb9020609fa315bfbbcc",
    config = function()
      require("plugins.impatient")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    commit = "bfa0d99ba6f98d077dd91779841f1c88b7b5c165",
    config = function()
      require("plugins.lualine")
    end,
  },
  -- Colorschemes
  { "folke/tokyonight.nvim",            commit = "ecae454c303d5190fb0ded096205a99fae16c6d4" },
  { "lunarvim/darkplus.nvim",           commit = "d308e9538f0e50cc3e80afc4ed904ab8b8e10fe6" },
  { "nyoom-engineering/oxocarbon.nvim", commit = "749562ce8ffbcc5c4f69ec0dab4f4cdd0a8d2e47" },
  { "luisiacc/gruvbox-baby",            commit = "309b405d64af29126b1eb8d9be2f280ee2aec15d" },
  { "Shatur/neovim-ayu",                commit = "5af91fe1176e764f7706b11b43793f31635e9520" },
  { "catppuccin/nvim",                  name = "catppuccin",                                priority = 1000 },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.project")
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end,
  }, -- enable LSP
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.null-ls")
    end,
  }, -- for formatters and linters
  {
    "williamboman/mason.nvim",
    config = function()
      require("plugins.mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("plugins.mason-lspconfig")
    end,
  },

  -- cmp plugins
  {"hrsh7th/cmp-cmdline"},
  {"hrsh7th/cmp-path"},
  {"hrsh7th/cmp-nvim-lsp"},
  { "hrsh7th/cmp-buffer"},
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp")
    end,
  },                                                                                      -- The completion plugin
  -- snippets
  {"hrsh7th/cmp-vsnip"},
  {"hrsh7th/vim-vsnip"},
  { "rafamadriz/friendly-snippets"}, -- a bunch of snippets to use
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("plugins.telescope")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs")
    end,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    commit = "5f01c1a89adafc52bf34e3bf690f80d9d726715d",
    config = function()
      require("plugins.comment")
    end,
  },

  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-blankline")
    end,
  },

  -- Highlight yanked text
  {
    "machakann/vim-highlightedyank",
    lazy = false,
    config = function()
      require("plugins.highlightedyank")
    end,
  },

  -- File Explorer
  {
    "dalmamad/nvim-tree.lua",
    commit = "fcdec7d186aee8ed39ef79c87666c1401f6a4d48",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.nvim-tree")
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    commit = "d076301a634198e0ae3efee3b298fc63c055a871",
    config = function()
      require("plugins.gitsigns")
    end,
  },
  -- git conflict
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("plugins.git-conflict")
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("plugins.diffview")
    end
  },
  {
    "tpope/vim-fugitive",
  },

  --Notes
  {
    "folke/todo-comments.nvim",
    commit = "1b9df577262b2c4c4ea422161742927f80ffa131",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.todo-comments")
    end,
  },

  {
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.code-runner")
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    config = function()
      require("plugins.obsidian")
    end,
  },

  -- Window
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      require("plugins.windows")
    end,
  },

  -- Motions
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
      require("plugins.hop")
    end,
  },

  -- Rest
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
    }
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("plugins.rest")
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("plugins.nvim-surround")
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Debug
  {
    "mfussenegger/nvim-dap",
    dependencies = {"rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio","leoluz/nvim-dap-go"},
    config = function ()
      require("plugins.dap")
    end
  },

  -- not using anymore

  -- use({
  --   "nvim-neorg/neorg",
  --   run = ":Neorg sync-parsers", -- This is the important bit!
  --   config = function()
  --     require("plugins.neorg")
  --   end,
  -- })

  -- use {"nvim-neorg/neorg-telescope"}

  --   "lambdalisue/suda.vim",
  -- "nvim-tree/nvim-web-devicons"

  -- Notify
  -- use({
  --   "rcarriga/nvim-notify",
  --   config = function()
  --     require("plugins.notify")
  --   end,
  -- })

  --Debug
  -- {
  --   "dalmamad/debugprint.nvim",
  --   branch = "dalmamad",
  --   config = function()
  --     require("plugins.debugprint")
  --   end,
  -- },
  
  -- buffer completions
  -- { "hrsh7th/cmp-path",             commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" },
  -- path completions
  -- { "saadparwaiz1/cmp_luasnip",     commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" },
  -- snippet completions
  -- { "hrsh7th/cmp-nvim-lsp",         commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" },
  -- { "hrsh7th/cmp-nvim-lua",         commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" },

  -- { "L3MON4D3/LuaSnip"}, --snippet engine
})

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
  { "nvim-tree/nvim-web-devicons", commit = "05e1072f63f6c194ac6e867b567e6b437d3d4622" },
  { "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }, -- Useful lua functions used by lots of plugins
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
  { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" },
  {
    "akinsho/bufferline.nvim",
    commit = "c7492a76ce8218e3335f027af44930576b561013",
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
    -- requires = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("plugins.lualine")
    end,
  },
  -- Colorschemes
  { "folke/tokyonight.nvim", commit = "ecae454c303d5190fb0ded096205a99fae16c6d4" },
  { "lunarvim/darkplus.nvim", commit = "d308e9538f0e50cc3e80afc4ed904ab8b8e10fe6" },
  { "nyoom-engineering/oxocarbon.nvim", commit = "749562ce8ffbcc5c4f69ec0dab4f4cdd0a8d2e47" },
  { "luisiacc/gruvbox-baby", commit = "309b405d64af29126b1eb8d9be2f280ee2aec15d" },
  { "Shatur/neovim-ayu", commit = "5af91fe1176e764f7706b11b43793f31635e9520" },

  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.project")
    end,
  },
  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a",
    config = function()
      require("plugins.cmp")
    end,
  }, -- The completion plugin
  { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }, -- buffer completions
  { "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }, -- path completions
  { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }, -- snippet completions
  { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" },
  { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" },

  -- snippets
  { "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a", }, --snippet engine
  { "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }, -- a bunch of snippets to use

  -- LSP
  {
    "neovim/nvim-lspconfig",
    commit = "e96f639b608a596aa1ea8abb7e5b799cedbb0b1a",
    config = function()
      require("plugins.lsp")
    end,
  }, -- enable LSP
  {
    "jose-elias-alvarez/null-ls.nvim",
    commit = "b3d2ebdb75cf1fa4290822b43dc31f61bd0023f8",
    config = function()
      require("plugins.null-ls")
    end,
  }, -- for formatters and linters
  {
    "williamboman/mason.nvim",
    commit = "2381f507189e3e10a43c3932a3ec6c2847180abc",
    config = function()
      require("plugins.mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    commit = "4674ed145fd0e72c9bfdb32b647f968b221bf2f2",
    config = function()
      require("plugins.mason-lspconfig")
    end,
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    -- commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0",
    config = function()
      require("plugins.telescope")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- commit = "4953fdf73ef5ada18e1e969019803605f4f4a4ac",
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
    commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec",
    config = function()
      require("plugins.autopairs")
    end,
  }, -- Autopairs, integrates with both cmp and treesitter

  -- Comment
  {
    "numToStr/Comment.nvim",
    commit = "5f01c1a89adafc52bf34e3bf690f80d9d726715d",
    config = function()
      require("plugins.comment")
    end,
  },

  -- indent
  { "lukas-reineke/indent-blankline.nvim", 
    config = function()
      require("plugins.indent-blankline")
    end,
  },

  -- File Explorer
  {
    "dalmamad/nvim-tree.lua",
    commit = "fcdec7d186aee8ed39ef79c87666c1401f6a4d48",
    -- requires = { "nvim-tree/nvim-web-devicons" },
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
  {'akinsho/git-conflict.nvim', version = '*', config = function()
    require('plugins.git-conflict')
  end},
  -- use { "mfussenegger/nvim-dap" }

  --Notes
  {
    "folke/todo-comments.nvim",
    commit = "1b9df577262b2c4c4ea422161742927f80ffa131",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
      require("plugins.todo-comments")
    end,
  },

  { 'CRAG666/code_runner.nvim', dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
      require("plugins.code-runner")
    end,
  },

  -- use({
  --   "nvim-neorg/neorg",
  --   run = ":Neorg sync-parsers", -- This is the important bit!
  --   config = function()
  --     require("plugins.neorg")
  --   end,
  -- })
  -- use {"nvim-neorg/neorg-telescope"}

  {
    "epwalsh/obsidian.nvim",
    config = function()
      require("plugins.obsidian")
    end,
  },

  -- Notify
  -- use({
  --   "rcarriga/nvim-notify",
  --   config = function()
  --     require("plugins.notify")
  --   end,
  -- })

  --Debug
  {
    "dalmamad/debugprint.nvim",
    branch = 'dalmamad',
    config = function()
      require("plugins.debugprint")
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
  "rest-nvim/rest.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
      require("plugins.rest")
  end
},

  -- Sudo
  {
    "lambdalisue/suda.vim",
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
})

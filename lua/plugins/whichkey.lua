local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<leader>"] = "LD",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",       -- none, single, double, shadow, rounded
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },                                             -- min and max height of the columns
    width = { min = 20, max = 50 },                                             -- min and max width of the columns
    spacing = 3,                                                                -- spacing between columns
    align = "left",                                                             -- align columns left, center or right
  },
  ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                             -- show help message on the command line when the popup is visible
  triggers = "auto",                                                            -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for ce rtain buf types and file types.
  -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}

local opts_1 = {
  mode = "n", -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = false, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mappings_1 = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["w"] = { "<cmd>update<CR>", "Save" },
  ["q"] = { "<cmd>q<CR>", "Quit" },
  ["Q"] = { "<cmd>tabclose<CR>", "Quit Tab" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["m"] = { "<cmd>MarkdownPreview<CR>", "Markdown Preview" },
  ["P"] = { "<Plug>RestNvimLast<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["F"] = { "<cmd>Neoformat<CR>", "Format" },
  -- ["r"] = { "<cmd>RunCode<CR>", "Runner" },
  r = {
    name = "Rest",
    r = { "<cmd>Rest run<cr>", "HTTP Request" },
    l = { "<cmd>Rest run last<cr>", "Last" },
  },
  f = {
    name = "Find",
    f = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Find files",
    },
    g = { "<cmd>Telescope live_grep <cr>", "live grep" },
    t = { "<cmd>TodoTelescope <cr>", "Todos" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    p = { "<cmd>Telescope projects<CR>", "Projects" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    o = { "<cmd>Telescope oldfiles hidden=true<cr>", "Old File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    a = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Next Hunk" },
    A = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Next Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    L = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    h = { "<cmd>DiffviewFileHistory %<cr>", "Current file history" },
    H = { "<cmd>DiffviewFileHistory <cr>", "Files history" },
    O = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = { "<cmd>GitConflictListQf<cr>", "List conflicts" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
  l = {
    name = "LSP",
    -- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    -- d = {
    --   "<cmd>Telescope lsp_document_diagnostics<cr>",
    --   "Document Diagnostics",
    -- },
    -- w = {
    --   "<cmd>Telescope lsp_workspace_diagnostics<cr>",
    --   "Workspace Diagnostics",
    -- },
    -- f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    -- j = {
    --   "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
    --   "Next Diagnostic",
    -- },
    -- k = {
    --   "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
    --   "Prev Diagnostic",
    -- },
    -- l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    -- q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    -- s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    -- S = {
    --   "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    --   "Workspace Symbols",
    -- },
  },
  t = {
    name = "All Terminals",
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<c-w>s:term<cr>", "Horizontal" },
    v = { "<c-w>v:term<cr>", "Horizontal" },
    -- h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    -- v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    a = { "<cmd>ToggleTermToggleAll<cr>", "ToggleAll" },
  },
  n = {
    name = "Obsidian",
    n = { "<cmd>ObsidianNewNote<cr>", "New Note" },
    d = { "<cmd>ObsidianToday<cr>", "Today Note" },
  },
  o = {
    name = "DB",
    o = { "<cmd>DBUIToggle<cr>", "Toggle"}
  }
  
  
}

local opts_2 = {
  mode = "n", -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "<leader><leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mappings_2 = {
  ["s"] = { "<cmd>source %<cr>", "Source" },
  ["S"] = { "<cmd>:e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR> | <cmd>NvimTreeToggle<cr><cr>", "Settings" },
  ["m"] = { "<cmd>Mason<cr> ", "Mason" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    C = { "<cmd>PackerClean<cr>", "Clean" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
}
which_key.setup(setup)
which_key.register(mappings_1, opts_1)
which_key.register(mappings_2, opts_2)

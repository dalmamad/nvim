local status_ok, alpha = pcall(require, "alpha")

if not status_ok then
  return
end

local header =  {
      [[███    ██ ███████  ██████  ██    ██ ██ ███    ███]],
      [[████   ██ ██      ██    ██ ██    ██ ██ ████  ████]],
      [[██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██]],
      [[██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██]],
      [[██   ████ ███████  ██████    ████   ██ ██      ██]]
}

local theme = require("alpha.themes.theta")
local config = theme.config
local dashboard = require("alpha.themes.dashboard")
local buttons = {
    type = "group",
    val = {
        { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
    { type = "padding", val = 1 },
    dashboard.button("f", " 󰈞  Find file", ":lua require('telescope.builtin').find_files({hidden = false, find_command = {'find','.','-type','f'}})<cr>"),
    dashboard.button("p", "   Projects", ":Telescope projects<CR>"),
    dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("s", "   Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR> | <cmd>NvimTreeToggle<cr>"),
    dashboard.button("d", "   Dotfiles", ":e ~/dotfiles <cr>"),
    dashboard.button("c", "   Code", ":e ~/code <cr>"),
    dashboard.button("n", " 󰺿  Notes", ":e ~/notes <cr>"),
    -- dashboard.button("n", " 󰺿  Notes", ":chdir ~/notes | :lua require('telescope.builtin').find_files({cwd = '~/notes', hidden = false, find_command = {'find','.','-type','f'}})<cr>"),
    dashboard.button("o", " 󰺿  NewNote", ":chdir ~/notes | :lua require('telescope.builtin').find_files({cwd = '~/notes', hidden = false, find_command = {'find','.','-type','f'}})<cr>"),
    dashboard.button("q", " 󰿅  Quit", ":qa<CR>"),
  },
    position = "center",
}


local output = {
    type = "text",
    val = header,
    opts = {hl='macro', position = "center", },
  }
config.layout[2] = output
config.layout[6] = buttons
alpha.setup(config)

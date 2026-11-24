local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

-- Neovim 0.12: vim.treesitter.get_parser() returns `nil, err` instead of raising
-- when no parser is installed, so Comment's ft.calculate() (which only checks
-- pcall's first return value) indexes a nil tree and throws "attempt to index
-- local 'tree' (a nil value)". Fall back to the filetype's commentstring.
local ft = require("Comment.ft")
local calculate = ft.calculate
rawset(ft, "calculate", function(ctx)
  local ok, parser = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
  if not ok or parser == nil then
    return ft.get(vim.bo.filetype, ctx.ctype)
  end
  return calculate(ctx)
end)

comment.setup({

  ---Add a space b/w comment and the line
  padding = true,
  ---Whether the cursor should stay at its position
  sticky = true,
  ---Lines to be ignored while (un)comment
  ignore = nil,
  ---LHS of toggle mappings in NORMAL mode
  toggler = {
    ---Line-comment toggle keymap
    -- line = 'gcc',
    line = "<space>/",
    ---Block-comment toggle keymap
    block = "<space>?",
  },
  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  opleader = {
    ---Line-comment keymap
    -- line = "gc",
    line = "<space>/",
    ---Block-comment keymap
    -- block = "gb",
    block = "<space>?",
  },
  ---LHS of extra mappings
  extra = {
    ---Add comment on the line above
    above = "gcO",
    ---Add comment on the line below
    below = "gco",
    ---Add comment at the end of line
    eol = "gcA",
  },
  ---Enable keybindings
  ---NOTE: If given `false` then the plugin won't create any mappings
  mappings = {
    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    basic = true,
    ---Extra mapping; `gco`, `gcO`, `gcA`
    extra = true,
  },
  ---Function to call after (un)comment
  post_hook = nil,

  ---Function to call before (un)comment
  pre_hook = nil,
})

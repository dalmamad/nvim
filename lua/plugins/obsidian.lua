local daily_path = "dailies"
local valut = "~/notes"

require("obsidian").setup({
  dir = valut,
  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = daily_path,
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "%Y-%m-%d",
    -- Optional, if you want to change the date format of the default alias of daily notes.
    alias_format = "%B %-d, %Y",
    -- Optional, default tags to add to each new daily note created.
    default_tags = { "daily-notes" },
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = nil
  },
})

local  replace_all = function(s, old, new)
    local result = ""
    local i, j = 1, 1
    while true do
      local pos = string.find(s, old, i)
      if not pos then
          result = result .. string.sub(s, i)
        break
      end
      result = result .. string.sub(s, i, pos - 1) .. new
      i = pos + string.len(old)
    end
    return result
end

local obsidian_new_note = function ()
  local title = vim.fn.input("Title: ", "", "file")
  if title ~= "" then
    local dir = valut .. "/" .. daily_path
    local date = os.date("%Y-%m-%d")
    local filename = date .. "_" .. title .. ".md"
    local full_path = dir .. "/" .. filename
    vim.fn.system("touch", full_path)
    title = replace_all(title,"-"," ")
    vim.fn.system("echo '# ".. title .."' > " .. full_path)
    vim.cmd("e " .. full_path)
  end
end


vim.api.nvim_create_user_command('ObsidianNewNote', obsidian_new_note, {})

vim.keymap.set("n", "<leader>nn", obsidian_new_note, { noremap = true, silent = true })

-- this will automatically wrap the text for markdown files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function()
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.cmd [[setlocal spell spelllang=en_us]]
  end,
})

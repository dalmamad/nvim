vim.g.db_ui_use_nerd_fonts = 1
vim.g.dbs = {
	{ name = "postgres", url = "postgres://postgres@localhost:5432/postgres" },
	{ name = "openmaptiles", url = "postgres://openmaptiles:openmaptiles@localhost:5433/openmaptiles" },
}

vim.cmd([[
  autocmd FileType dbui nmap <buffer> l <Plug>(DBUI_SelectLine)
]])

-- Execute Vim script functions and commands in Lua
vim.api.nvim_exec2(
	[[
  function! DBUI_ExecuteQuery(query)
  if !exists('g:currentDBConn') || !has_key(g:currentDBConn, 'url') || g:currentDBConn.url == ''
    echo "First choose a DB"
  else
    let cmd = ":DB " . g:currentDBConn.url . " " . a:query
    execute cmd
  endif
  endfunction

  function! GetVisualSelection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
  endfunction

  function! DBUI_ExecuteVisualSelection() range
  let selected_text = GetVisualSelection()
  call DBUI_ExecuteQuery(selected_text)
  endfunction

  command! -range DBUIExecuteOutsideQuery <line1>,<line2>call DBUI_ExecuteVisualSelection()
]],
	{ output = false }
)

vim.cmd([[
let g:db_ui_table_helpers = {
  \ 'postgresql': {
  \   'List Functions': 'SELECT routine_name FROM information_schema.routines WHERE routine_schema = ''{schema}'';',
  \ }
\ }
]])

-- Global variable to hold the selected value
vim.g.selected_name = "default"

-- Command to select a name
vim.api.nvim_create_user_command("DBUISelectDB", function()
	local DBNames = {}
	for _, connection in ipairs(vim.g.dbs) do
		table.insert(DBNames, connection.name)
	end
	vim.ui.select(DBNames, {
		prompt = "Select a database:",
		format_item = function(item)
			return item
		end,
	}, function(choice)
		if choice then
			vim.g.selected_name = choice
			local url
			for _, connection in pairs(vim.g.dbs) do
				if connection.name == choice then
					url = connection.url
					break
				end
			end
			vim.g.currentDBConn = { name = choice, url = url }
		else
			print("No choice made.")
		end
	end)
end, { nargs = 0 })

vim.api.nvim_create_user_command("DBUIShowCurrectDBConn", function()
	print(" name: " .. vim.g.currentDBConn.name .. " url: " .. vim.g.currentDBConn.url)
end, { nargs = 0 })

-- KEYS

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>oe", "<Plug>(DBUI_ExecuteQuery)", opts)
vim.api.nvim_set_keymap("v", "<Leader>oe", "<Plug>(DBUI_ExecuteQuery)", opts)

vim.api.nvim_set_keymap("n", "<leader>os", ":DBUISelectDB<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>oS", ":DBUIShowCurrectDBConn<CR>", opts)
vim.api.nvim_set_keymap("v", "<leader>oE", ":DBUIExecuteOutsideQuery<CR>", opts)

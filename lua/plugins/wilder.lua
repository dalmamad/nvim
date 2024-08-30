-- local wilder = require('wilder')
-- wilder.setup({modes = {':', '/', '?'}})

vim.cmd([[
" Default keys
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<C-j>',
      \ 'previous_key': '<C-K>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \ })
]])

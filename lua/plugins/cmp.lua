local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- local snip_status_ok, luasnip = pcall(require, "luasnip")
-- if not snip_status_ok then
--   return
-- end
-- require("luasnip.loaders.from_vscode").lazy_load() -- You can pass { paths = "./my-snippets/"} as well
-- require("luasnip/loaders/from_vscode").lazy_load()
-- require("luasnip.loaders.from_snipmate").lazy_load()

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
  Text = "T",
  Method = "m",
  Function = "F",
  Constructor = "C",
  Field = "f",
  Variable = "v",
  Class = "c",
  Interface = "I",
  Module = "M",
  Property = "P",
  Unit = "U",
  Value = "V",
  Enum = "E",
  Keyword = "k",
  Snippet = "S",
  Color = "C",
  File = "F",
  Reference = "R",
  Folder = "D",
  EnumMember = "E",
  Constant = "C",
  Struct = "S",
  Event = "e",
  Operator = "O",
  TypeParameter = "T",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- elseif luasnip.expandable() then
        -- luasnip.expand()
        -- elseif luasnip.expand_or_jumpable() then
        -- luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        -- elseif luasnip.jumpable(-1) then
        -- luasnip.jump(-1)
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        -- luasnip = "[luasnip]",
        vsnip = "[Snippet]",
        -- snippy = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        -- neorg = "[Neorg]"
      })[entry.source.name]
      return vim_item
    end,
  },

  sources = cmp.config.sources({
    { name = 'vim-dadbod-completion' },
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' }, -- For luasnip users.
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  },{
      { name = 'buffer' },
    })
  -- confirm_opts = {
  --   behavior = cmp.ConfirmBehavior.Replace,
  --   select = false,
  -- },
  -- window = {
  --   documentation = {
  --     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  --   },
  -- },
  -- experimental = {
  --   ghost_text = true,
  --   native_menu = false,
  -- },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = {
    ['<Tab>'] = {
      c = function(_)
        if cmp.visible() then
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          else
            cmp.select_next_item()
          end
        else
          cmp.complete()
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          end
        end
      end,
    },
    ['<S-Tab>'] = {
      c = function(_)
        if cmp.visible() then
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          else
            cmp.select_prev_item()
          end
        else
          cmp.complete()
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          end
        end
      end,
    },
    ['<C-j>'] = {
      c = function(_)
        if cmp.visible() then
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          else
            cmp.select_next_item()
          end
        else
          cmp.complete()
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          end
        end
      end,
    },
    ['<C-k>'] = {
      c = function(_)
        if cmp.visible() then
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          else
            cmp.select_prev_item()
          end
        else
          cmp.complete()
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          end
        end
      end,
    },
    -- ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    -- ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    -- ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
    -- ['<CR>'] = cmp.mapping({
    --   i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    --   c = function(fallback)
    --     if cmp.visible() then
    --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
    --     else
    --       fallback()
    --     end
    --   end
    -- }),
    -- ... Your other configuration ...
  },
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    })
})

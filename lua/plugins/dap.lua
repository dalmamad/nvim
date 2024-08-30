local dap, dapui = require("dap"), require("dapui")
require('dap-go').setup()

dapui.setup({
  {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = ""
    },
    layouts = { {
      elements = { {
        id = "scopes",
        size = 0.25
      }, {
          id = "breakpoints",
          size = 0.25
        }, {
          id = "stacks",
          size = 0.25
        }, {
          id = "watches",
          size = 0.25
        } },
      position = "left",
      size = 40
    }, {
        elements = { {
          id = "repl",
          size = 0.5
        }, {
            id = "console",
            size = 0.5
          } },
        position = "bottom",
        size = 10
      } },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
  }
})

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end


local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<M-k>", dapui.float_element('stacks'), opts)
vim.keymap.set("n", "<M-k>", dapui.eval, opts)
vim.keymap.set("n", "<Leader>df", dap.run_to_cursor, opts)
vim.keymap.set("n", "<Leader>dd","<cmd>DapToggleBreakpoint<cr>" , opts)
vim.keymap.set("n", "<Leader>dr","<cmd>DapToggleBreakpoint<cr>" , opts)
vim.keymap.set("n", "<Leader>ds","<cmd>DapContinue<cr>" , opts)
vim.keymap.set("n", "<F5>","<cmd>DapContinue<cr>" , opts)
vim.keymap.set("n", "<F1>","<cmd>DapStepOver<cr>" , opts)
vim.keymap.set("n", "<F2>","<cmd>DapStepIn<cr>" , opts)
vim.keymap.set("n", "<F3>","<cmd>DapStepOut<cr>" , opts)
vim.keymap.set("n", "<Leader>dx","<cmd>DapDisconnect<cr>" , opts)


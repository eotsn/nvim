return {
  -- Debug Adapter Protocol client implementation for Neovim
  'mfussenegger/nvim-dap',

  dependencies = {
    -- Fancy UI for the debugger
    {
      'rcarriga/nvim-dap-ui',
        -- stylua: ignore
        keys = {
          { '<leader>du', function() require('dapui').toggle({ }) end, desc = 'Dap UI' },
          { '<leader>de', function() require('dapui').eval() end, desc = 'Eval', mode = {'n', 'v'} },
        },
      opts = {},
    },

    -- Virtual text for the debugger
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },

    -- Integrate with the `which-key` popup menu
    {
      'folke/which-key.nvim',
      optional = true,
      opts = {
        defaults = {
          ['<leader>d'] = { name = '+debug' },
        },
      },
    },

    -- Debugger extension for go
    {
      'leoluz/nvim-dap-go',
      opts = {},
    },
  },

  -- stylua: ignore
  keys = {
    { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Breakpoint Condition' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
    { '<leader>dc', function() require('dap').continue() end, desc = 'Continue' },
    { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor' },
    { '<leader>dg', function() require('dap').goto_() end, desc = 'Go to line (no execute)' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
    { '<leader>dj', function() require('dap').down() end, desc = 'Down' },
    { '<leader>dk', function() require('dap').up() end, desc = 'Up' },
    { '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last' },
    { '<leader>do', function() require('dap').step_out() end, desc = 'Step Out' },
    { '<leader>dO', function() require('dap').step_over() end, desc = 'Step Over' },
    { '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },
    { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
    { '<leader>ds', function() require('dap').session() end, desc = 'Session' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
    { '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = 'Widgets' },
  },

  config = function()
    local dap = require 'dap'

    -- Set up debug configuration for Godot (4+)
    dap.adapters.godot = {
      type = 'server',
      host = '127.0.0.1',
      port = 6006,
    }
    dap.configurations.gdscript = {
      {
        type = 'godot',
        name = 'Launch Scene',
        request = 'launch',
        project = '${workspaceFolder}',
        launch_scene = true,
      },
    }
  end,
}

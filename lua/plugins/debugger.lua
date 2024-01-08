return {
  -- Debug Adapter Protocol client implementation for Neovim
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        keys = {
          {
            "<leader>du",
            function()
              require("dapui").toggle()
            end,
            desc = "Toggle DAP UI",
          },
        },
        config = true,
      },

      -- Virtual text for the debugger
      { "theHamsta/nvim-dap-virtual-text", config = true },

      -- Debugger extension for go
      { "leoluz/nvim-dap-go", config = true },
    },
    -- stylua: ignore
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle line breakpoint", },
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug/Continue", },
      { "<leader>dR", function() require("dap").restart() end, desc = "Restart debugger session", },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate debugger session", },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over", },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into", },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out", },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor", },
    },
    config = function()
      local dap = require("dap")

      -- Set up debug configuration for Godot 4
      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }
      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch Scene",
          project = "${workspaceFolder}",
          launch_scene = true,
        },
      }
    end,
  },
}

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
      },

      -- Virtual text for the debugger
      "theHamsta/nvim-dap-virtual-text",

      -- Debugger extension for go
      "leoluz/nvim-dap-go",
    },
    -- stylua: ignore
    keys = {
      -- Intellij-like keybindings
      --    https://www.jetbrains.com/help/idea/debugging-code.html
      { "<C-F8>", function() require("dap").toggle_breakpoint() end, desc = "Toggle line breakpoint", },
      { "<S-F9>", function() require("dap").continue() end, desc = "Debug/Continue", },
      { "<C-F5>", function() require("dap").restart() end, desc = "Restart debugger session", },
      { "<C-F2>", function() require("dap").terminate() end, desc = "Terminate debugger session", },
      { "<F8>", function() require("dap").step_over() end, desc = "Step over", },
      { "<F7>", function() require("dap").step_into() end, desc = "Step into", },
      { "<S-F8>", function() require("dap").step_out() end, desc = "Step out", },
      { "<M-F9>", function() require("dap").run_to_cursor() end, desc = "Run to cursor", },
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

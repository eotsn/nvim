-- Better diagnostics list and others
return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = {
    icons = false,
    use_diagnostic_signs = true,
  },
  keys = {
    {
      "]d",
      function()
        if require("trouble").is_open() then
          require("trouble").next { skip_groups = true, jump = true }
        else
          vim.diagnostic.goto_next()
        end
      end,
      desc = "Go to next diagnostic message",
    },
    {
      "[d",
      function()
        if require("trouble").is_open() then
          require("trouble").previous { skip_groups = true, jump = true }
        else
          vim.diagnostic.goto_prev()
        end
      end,
      desc = "Go to previous diagnostic message",
    },
    { "<leader>xx", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace diagnostics" },
  },
}

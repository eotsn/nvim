return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "tokyobones"

      local lush = require "lush"
      local base = require "tokyobones"
      local specs = lush.parse(function()
        return {
          ---@diagnostic disable-next-line: undefined-global
          ColorColumn { base.CursorLine },
        }
      end)
      lush.apply(lush.compile(specs))
    end,
  },
}

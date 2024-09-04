return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local harpoon = require "harpoon"
    -- stylua: ignore
    return {
      { "<leader>a", function() harpoon:list():add() end },
      { "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
      { "<C-j>", function() harpoon:list():select(1) end },
      { "<C-k>", function() harpoon:list():select(2) end },
      { "<C-l>", function() harpoon:list():select(3) end },
    }
  end,
}

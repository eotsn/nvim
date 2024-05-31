return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  branch = "harpoon2",
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup()

    vim.keymap.set("n", "<C-h><C-a>", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<C-h><C-l>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set("n", "<leader>" .. idx, function()
        harpoon:list():select(idx)
      end)
    end
  end,
}

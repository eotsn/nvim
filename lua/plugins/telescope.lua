return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",

    -- FZF sorter for telescope written in c
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require "telescope"

    telescope.setup {
      defaults = {
        preview = {
          hide_on_startup = true,
        },
      },
    }

    pcall(telescope.load_extension, "fzf")

    local builtin = require "telescope.builtin"

    vim.keymap.set("n", "<leader>sf", builtin.find_files)
    vim.keymap.set("n", "<leader>sg", builtin.live_grep)
    vim.keymap.set("n", "<leader>sh", builtin.help_tags)
    vim.keymap.set("n", "<leader>sr", builtin.resume)
    vim.keymap.set("n", "<leader>sw", builtin.grep_string)
  end,
}

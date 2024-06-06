return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup {
      columns = {
        "permissions",
        "size",
        "mtime",
        "icon",
      },
    }

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}

return {
  {
    "stevearc/oil.nvim",
    keys = {
      { "-", "<Cmd>Oil<CR>" },
    },
    opts = {
      columns = {
        "permissions",
        "size",
        "mtime",
        "icon",
      },
      view_options = {
        show_hidden = true,
      },
    },
  },
}

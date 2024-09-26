return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    groups = {
      all = {
        ["@comment.todo"] = { link = "Comment" },
      },
    },
  },
  config = function(_, opts)
    require("nightfox").setup(opts)
    vim.cmd [[colorscheme dayfox]]
  end,
}

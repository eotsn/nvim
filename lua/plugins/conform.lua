return {
  "stevearc/conform.nvim",
  keys = {
    {
      "gq",
      function()
        require("conform").format()
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    format = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gofumpt" },
    },
  },
}

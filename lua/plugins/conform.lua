return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      go = { "gofumpt" },
      lua = { "stylua" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
    },
  },
}

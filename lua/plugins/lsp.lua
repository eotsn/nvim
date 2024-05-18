return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    "neovim/nvim-lspconfig",

    -- Automatically install LSP servers
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Useful LSP status updates
    { "j-hui/fidget.nvim", tag = "legacy", config = true },

    -- Lightweight yet powerful formatter plugin for Neovim
    "stevearc/conform.nvim",

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",
  },
  config = function()
    require("neodev").setup()

    local lsp_zero = require "lsp-zero"

    lsp_zero.on_attach(function(_, bufnr)
      lsp_zero.default_keymaps { buffer = bufnr }
    end)

    require("mason").setup {}
    require("mason-lspconfig").setup {
      ensure_installed = { "clangd", "gopls", "lua_ls" },
      handlers = {
        lsp_zero.default_setup,
      },
    }

    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofumpt" },
      },
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        require("conform").format { bufnr = args.buf }
      end,
    })
  end,
}

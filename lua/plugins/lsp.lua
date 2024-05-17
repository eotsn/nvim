return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      "neovim/nvim-lspconfig",

      -- Automatically install LSP servers
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful LSP status updates
      { "j-hui/fidget.nvim", tag = "legacy", config = true },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
    config = function()
      local lsp_zero = require "lsp-zero"

      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps { buffer = bufnr }
      end)

      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup()

      require("mason").setup {}
      require("mason-lspconfig").setup {
        ensure_installed = { "clangd", "gopls", "lua_ls" },
        handlers = {
          lsp_zero.default_setup,
        },
      }
    end,
  },
}

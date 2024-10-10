return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    { "j-hui/fidget.nvim", opts = {} },
  },
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      gopls = {
        settings = {
          gopls = {
            usePlaceholders = true,
          },
        },
      },
      emmet_language_server = {},
      vtsls = {
        settings = {
          vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            suggest = {
              completeFunctionCalls = true,
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    local servers = opts.servers or {}

    local capabilities = {}
    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = vim.tbl_keys(servers),
      handlers = {
        function(server_name)
          local config = servers[server_name] or {}
          config.capabilities = vim.tbl_deep_extend("force", {}, capabilities)
          require("lspconfig")[server_name].setup(config)
        end,
      },
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function()
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0 })
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = 0 })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
        vim.keymap.set({ "n", "v" }, "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
      end,
    })
  end,
}

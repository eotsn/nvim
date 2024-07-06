return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",

      -- Automatically install LSP servers
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      { "j-hui/fidget.nvim", opts = {} },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              codelens = {
                enable = true,
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              staticcheck = true,
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("neodev").setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = opts.servers or {}

      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr })

          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
          vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = bufnr })

          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = bufnr })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = bufnr })
          vim.keymap.set("n", "<space>cc", vim.lsp.codelens.run, { buffer = bufnr })

          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.keymap.set("n", "<space>ch", function()
              ---@diagnostic disable-next-line: missing-parameter
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end)
          end

          if client and client.server_capabilities.codeLensProvider and vim.lsp.codelens then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = bufnr,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end,
      })
    end,
  },
}

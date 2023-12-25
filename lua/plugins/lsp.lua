return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    opts = {
      servers = {
        gopls = {},
        html = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
    },
    config = function(_, opts)
      local servers = opts.servers

      local on_attach = function()
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
        -- vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename)

        vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
        vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_declarations<CR>')
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>')
        vim.keymap.set('n', 'gI', '<cmd>Telescope lsp_implementations<CR>')
        vim.keymap.set('n', '<leader>D', '<cmd>Telescope lsp_type_definitions<CR>')
        vim.keymap.set('n', '<leader>ds', '<cmd>Telescope lsp_document_symbols<CR>')
        vim.keymap.set('n', '<leader>ws', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')

        vim.keymap.set('n', 'K', vim.lsp.buf.hover)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
      end

      -- `mason-lspconfig` requires that these setup functions are called in this order
      -- before setting up the servers
      require('mason').setup()
      require('mason-lspconfig').setup()

      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require('neodev').setup()

      -- `nvim-cmp` supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure that the servers are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }

      require('lspconfig').gdscript.setup {
        -- For GDScript development on Windows we use `ncat` instead of the default
        cmd = { 'ncat', '127.0.0.1', '6005' },
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        settings = {},
      }
    end,
  },
}

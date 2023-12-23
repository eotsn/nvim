return {
  -- A git wrapper so awesome, it should be illegal
  {
    'tpope/vim-fugitive',
    dependencies = {
      -- GitHub extensions for fugitive
      'tpope/vim-rhubarb',
    },
    lazy = false,
    keys = {
      { '<leader>gs', '<cmd>:Git<CR>', desc = 'Git status' },
    },
  },

  -- Automatically adjust `shiftwidth` and `expandtab` heuristically
  'tpope/vim-sleuth',

  -- Snippets!
  {
    'L3MON4D3/LuaSnip',
    -- stylua: ignore
    build = (not jit.os:find 'Windows')
        and 'echo "NOTE: jsregexp is optional, so not a big deal if it fails to build"; make install_jsregexp'
      or nil,
    dependencies = {
      -- Preconfigured snippets for different languages
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
  },

  -- Auto-completion
  {
    'hrsh7th/nvim-cmp',
    version = false, -- Last release is way too old
    event = 'InsertEnter',
    dependencies = {
      -- Additional completion sources
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    opts = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      return {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item
          ['<S-CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
      }
    end,
  },

  -- Get AI-based suggestions in real-time
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        auto_trigger = true,
      },
    },
  },

  -- Simple, unified, single tabpage interface that lets you easily review all
  -- changed files for any git rev.
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<C-g>', '<cmd>DiffviewOpen<CR>', desc = 'Open diff view' },
    },
    opts = {
      use_icons = false,
      keymaps = {
        view = {
          ['gq'] = '<cmd>DiffviewClose<CR>',
        },
        file_panel = {
          ['gq'] = '<cmd>DiffviewClose<CR>',
        },
      },
    },
  },
}

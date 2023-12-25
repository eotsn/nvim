return {
  -- Fuzzy finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        -- Alternative fzf sorter for telescope written in c
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    cmd = 'Telescope',
    keys = {
      -- Find
      { '<leader>fr', '<cmd>Telescope oldfiles<CR>', desc = 'Recent' },
      { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Find files' },
      -- Search
      { '<leader>sR', '<cmd>Telescope resume<CR>', desc = 'Resume' },
      { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Buffer' },
      { '<leader>sd', '<cmd>Telescope diagnostics<CR>', desc = 'Document diagnostics' },
      { '<leader>sg', '<cmd>Telescope live_grep<CR>', desc = 'Grep' },
      { '<leader>sh', '<cmd>Telescope help_tags<CR>', desc = 'Help pages' },
      { '<leader>sw', '<cmd>Telescope grep_string<CR>', desc = 'Word' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<F4>'] = require('telescope.actions.layout').toggle_preview,
            },
          },
          preview = {
            hide_on_startup = true,
          },
        },
      }
      -- Enable telescope fzf native, if installed
      require('telescope').load_extension 'fzf'
    end,
  },

  -- Show a popup with the active keymaps of the command typed
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { 'n', 'v' },
        ['g'] = { name = '+goto' },
        ['gs'] = { name = '+surround' },
        ['<leader>b'] = { name = '+buffer' },
        ['<leader>c'] = { name = '+code' },
        ['<leader>d'] = { name = '+debug' },
        ['<leader>f'] = { name = '+file/find' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>gh'] = { name = '+hunks' },
        ['<leader>s'] = { name = '+search' },
        ['<leader>x'] = { name = '+diagnostics/quickfix' },
      },
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  -- Highlight git diffs
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set('n', '<leader>ghp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })

        -- stylua: ignore start
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })

        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
        -- stylua: ignore end
      end,
    },
  },

  -- Better diagnostics list and others
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = {
      icons = false,
      use_diagnostic_signs = true,
    },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xL', '<cmd>TroubleToggle loclist<CR>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>TroubleToggle quickfix<CR>', desc = 'Quickfix List (Trouble)' },
    },
  },

  -- Obfuscate matched patterns in defined filetypes
  {
    'laytan/cloak.nvim',
    opts = {},
  },
}

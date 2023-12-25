return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { lsp_fallback = true, async = false, timeout_ms = 500 }
      end,
      mode = { 'n', 'v' },
      desc = 'Format Buffer',
    },
    {
      '<leader>cF',
      function()
        require('conform').format { formatters = { 'injected' } }
      end,
      mode = { 'n', 'v' },
      desc = 'Format Injected Langs',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports', 'gofumpt' },
      gdscript = { 'gdformat' },
    },
  },
}

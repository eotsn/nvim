return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require "cmp"

    cmp.setup {
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-i>"] = cmp.mapping.confirm { select = true },
      },
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
    }

    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
    end, { silent = true })
  end,
}

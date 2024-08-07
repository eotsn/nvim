return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      vim.opt.completeopt = "menu,menuone,noselect"

      local cmp = require "cmp"

      cmp.setup {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        mapping = {
          ["<C-n>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              cmp.complete()
            end
          end, { "i", "s", "c" }),
          ["<C-p>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
            else
              cmp.complete()
            end
          end, { "i", "s", "c" }),
          ["<C-y>"] = cmp.mapping.confirm { select = true },
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
  },
}

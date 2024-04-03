return {
  -- Snippets!
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows")) and "make install_jsregexp" or nil,
    dependencies = {
      -- Preconfigured snippets for different languages
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- latest release is way to old
    event = "InsertEnter",
    dependencies = {
      -- Additional completion sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      return {
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      }
    end,
  },
}

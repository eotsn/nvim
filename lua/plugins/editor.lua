return {
  -- A git wrapper so awesome, it should be illegal
  {
    "tpope/vim-fugitive",
    lazy = false,
    dependencies = {
      -- GitHub extensions for fugitive
      "tpope/vim-rhubarb",
    },
    keys = {
      { "<leader>gs", "<Cmd>Git<CR>", desc = "Git status" },
    },
  },

  -- Automatically adjust `shiftwidth` and `expandtab` heuristically
  "tpope/vim-sleuth",

  -- Highlight git diffs
  {

    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        map({ "n", "v" }, "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Jump to next hunk" })
        map({ "n", "v" }, "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Jump to previous hunk" })
        map({ "n", "v" }, "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
      end,
    },
  },

  -- Better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      icons = false,
      use_diagnostic_signs = true,
    },
    keys = {
      {
        "]d",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.diagnostic.goto_next()
          end
        end,
        desc = "Go to next diagnostic message",
      },
      {
        "[d",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            vim.diagnostic.goto_prev()
          end
        end,
        desc = "Go to previous diagnostic message",
      },
      { "<leader>xx", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace diagnostics" },
    },
  },

  -- Obfuscate matched patterns in defined filetypes
  { "laytan/cloak.nvim", config = true },
}

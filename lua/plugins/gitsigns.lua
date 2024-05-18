return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup {
      on_attach = function(bufnr)
        local gitsigns = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end)

        map("n", "<leader>hp", gitsigns.preview_hunk)
        map("n", "<leader>hr", gitsigns.reset_hunk)
        map("n", "<leader>hb", function()
          gitsigns.blame_line { full = true }
        end)
      end,
    }
  end,
}

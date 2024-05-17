return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
    },
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
      map({ "n", "v" }, "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
    end,
  },
}

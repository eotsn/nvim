return {
  "ibhagwan/fzf-lua",
  config = function()
    local fzf = require "fzf-lua"

    fzf.setup {
      winopts = {
        split = "belowright new",
        preview = { hidden = "hidden" },
      },
    }

    vim.keymap.set("n", "<leader>sf", fzf.files)
    vim.keymap.set("n", "<leader>sg", fzf.live_grep)
    vim.keymap.set("n", "<leader>sh", fzf.helptags)
    vim.keymap.set("n", "<leader>sr", fzf.resume)
  end,
}

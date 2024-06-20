return {
  "tpope/vim-fugitive",
  dependencies = {
    -- GitHub extension for fugitive.vim
    "tpope/vim-rhubarb",
  },
  lazy = false,
  config = function()
    vim.keymap.set("n", "<leader>gs", "<CMD>:tab Git<CR>")
    vim.keymap.set("n", "<leader>gl", "<CMD>:tab Git log --graph --oneline --decorate<CR>")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "fugitive", "git" },
      callback = function()
        vim.schedule(function()
          vim.keymap.set("n", "q", "<C-w>q", { buffer = true })
        end)
      end,
    })
  end,
}

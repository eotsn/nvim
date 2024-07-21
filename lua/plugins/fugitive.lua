return {
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "GBrowse" },
    dependencies = { "tpope/vim-rhubarb" },
    keys = {
      { "<leader>gs", "<Cmd>:tab Git<CR>" },
      { "<leader>gl", "<Cmd>:tab Git log --graph --oneline --decorate<CR>" },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "fugitive", "git" },
        callback = function()
          vim.schedule(function()
            vim.keymap.set("n", "q", "<C-w>q", { buffer = true })
          end)
        end,
      })
    end,
  },
}

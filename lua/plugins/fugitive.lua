return {
  "tpope/vim-fugitive",
  dependencies = {
    -- GitHub extension for fugitive.vim
    "tpope/vim-rhubarb",
  },
  lazy = false,
  keys = {
    { "<leader>gs", "<CMD>:vertical rightbelow Git<CR>" },
    { "<leader>gl", "<CMD>:vertical rightbelow Git log --graph --oneline --decorate<CR>" },
  },
}

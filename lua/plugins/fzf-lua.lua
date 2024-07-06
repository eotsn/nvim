return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>sf", "<Cmd>:FzfLua files<CR>" },
      { "<leader>sg", "<Cmd>:FzfLua live_grep<CR>" },
      { "<leader>sh", "<Cmd>:FzfLua helptags<CR>" },
      { "<leader>sr", "<Cmd>:FzfLua resume<CR>" },
    },
    opts = {
      winopts = {
        split = "belowright new",
        preview = { hidden = "hidden" },
      },
      grep = { rg_glob = true },
    },
  },
}

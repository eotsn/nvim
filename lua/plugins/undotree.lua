return {
  {
    "mbbill/undotree",
    keys = {
      { "<F5>", "<Cmd>:UndotreeToggle<CR>" },
    },
    init = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
}

return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "<F5>", ":UndotreeToggle<CR>" },
  },
  init = function()
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}

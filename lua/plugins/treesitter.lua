return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-refactor",
  },
  main = "nvim-treesitter.configs",
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    refactor = {
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "<localleader>r",
        },
      },
    },
  },
}

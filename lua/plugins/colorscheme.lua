return {
  -- Soothing pastel theme for (Neo)vim
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      color_overrides = {
        -- Turn 'mocha' into 'breve'
        mocha = {
          base = "#000000",
          crust = "#000000",
          mantle = "#000000",
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

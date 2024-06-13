return {
  "miikanissi/modus-themes.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("modus-themes").setup {
      style = "modus_operandi",
      on_highlights = function(highlights, colors)
        highlights.Whitespace = { fg = colors.bg_dim }
      end,
    }

    vim.cmd.colorscheme "modus"
  end,
}

return {
  -- Get AI-based suggestions in real-time
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          -- This overlaps with the default completion keymap, but behaves
          -- nicely
          accept = "<C-y>",
        },
      },
    },
  },

  -- Comments
  { "numToStr/Comment.nvim", lazy = false, config = true },

  -- Fast and feature-rich surround actions
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
}

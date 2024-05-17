return {
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
}

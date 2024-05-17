local is_windows = jit.os:find "Windows"

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = is_windows
          and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        or "make",
      enabled = vim.fn.executable(is_windows and "cmake" or "make") == 1,
    },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>sb", "<Cmd>Telescope buffers<CR>", desc = "Search buffers" },
    { "<leader>sf", "<Cmd>Telescope find_files<CR>", desc = "Search files" },
    { "<leader>sg", "<Cmd>Telescope live_grep<CR>", desc = "Search by grep" },
    { "<leader>sh", "<Cmd>Telescope help_tags<CR>", desc = "Search help tags" },
    { "<leader>sr", "<Cmd>Telescope resume<CR>", desc = "Search resume" },
    { "<leader>sw", "<Cmd>Telescope grep_string<CR>", desc = "Search current word" },
  },
  config = function()
    local telescope = require "telescope"
    local action_layout = require "telescope.actions.layout"
    telescope.setup {
      defaults = {
        layout_config = {
          width = 0.9,
          preview_width = 0.6,
        },
        mappings = {
          n = {
            ["<M-p>"] = action_layout.toggle_preview,
          },
          i = {
            ["<M-p>"] = action_layout.toggle_preview,
          },
        },
        preview = {
          hide_on_startup = true,
        },
      },
    }
    -- Enable telescope fzf native, if installed
    pcall(telescope.load_extension, "fzf")
  end,
}

local is_windows = jit.os:find("Windows")

return {
  -- Fuzzy finder (files, lsp, etc)
  {
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
      { "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>sg", "<Cmd>Telescope live_grep<CR>", desc = "Search by grep" },
      { "<leader>sh", "<Cmd>Telescope help_tags<CR>", desc = "Search help tags" },
      { "<leader>sr", "<Cmd>Telescope resume<CR>", desc = "Resume search" },
      { "<leader>sw", "<Cmd>Telescope grep_string<CR>", desc = "Search for word under cursor" },
    },
    opts = {
      defaults = {
        preview = {
          hide_on_startup = true,
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      -- Enable telescope fzf native, if installed
      pcall(telescope.load_extension, "fzf")
    end,
  },
}

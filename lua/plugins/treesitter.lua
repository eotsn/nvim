return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main", -- Let's go experimental!
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- Load treesitter early when opening a file from the cmdline
    opts = {
      ensure_install = "community",
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}

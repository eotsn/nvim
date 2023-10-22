return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        -- fzf sorter for telescope written in c
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>?", "<cmd>Telescope oldfiles<CR>" },
      { "<leader><space>", "<cmd>Telescope buffers<CR>" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>" },

      { "<leader>gf", "<cmd>Telescope git_files<CR>" },
      { "<leader>sf", "<cmd>Telescope find_files<CR>" },
      { "<leader>sh", "<cmd>Telescope help_tags<CR>" },
      { "<leader>sw", "<cmd>Telescope grep_string<CR>" },
      { "<leader>sg", "<cmd>Telescope live_grep<CR>" },
      { "<leader>sd", "<cmd>Telescope diagnostics<CR>" },
      { "<leader>sr", "<cmd>Telescope resume<CR>" },
    },
    config = function()
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<F4>"] = require("telescope.actions.layout").toggle_preview,
            },
          },
          preview = {
            hide_on_startup = true,
          },
        },
      }
      -- enable telescope fzf native, if installed
      require("telescope").load_extension "fzf"
    end,
  },

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })

        vim.keymap.set({ "n", "v" }, "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })

        vim.keymap.set({ "n", "v" }, "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
      end,
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local harpoon = require "harpoon"

      harpoon:setup {}

      -- stylua: ignore
      vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>hd", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>hf", function() harpoon:list():select(4) end)
    end,
  },

  -- obfuscate matched patterns in defined filetypes
  { "laytan/cloak.nvim", opts = {} },
}

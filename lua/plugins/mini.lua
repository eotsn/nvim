return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  config = function()
    local map = vim.keymap.set

    require("mini.ai").setup()
    require("mini.extra").setup()
    require("mini.move").setup()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.trailspace").setup()

    -- mini.jump2d ============================================================

    require("mini.jump2d").setup {
      view = {
        dim = true,
        n_steps_ahead = 2,
      },
      mappings = {
        start_jumping = "", -- Unbind <CR>
      },
    }

    map("n", "<space>", "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>")

    -- mini.pick ==============================================================

    local pick = require "mini.pick"

    pick.setup { source = { show = pick.default_show } }

    map("n", "<leader>ff", "<Cmd>Pick files<CR>")
    map("n", "<leader>fd", "<Cmd>Pick diagnostic scope='all'<CR>")
    map("n", "<leader>fg", "<Cmd>Pick grep_live<CR>")
    map("n", "<leader>fG", "<Cmd>Pick grep pattern='<cword>'<CR>")
    map("n", "<leader>fh", "<Cmd>Pick help<CR>")
    map("n", "<leader>fH", "<Cmd>Pick hl_groups<CR>")

    -- mini.files =============================================================

    local files = require "mini.files"

    files.setup { content = { prefix = function() end } }

    map("n", "<leader>ed", "<Cmd>lua MiniFiles.open()<CR>")
    map("n", "<leader>ef", "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>")

    -- mini.hipatterns ========================================================

    local hipatterns = require "mini.hipatterns"

    hipatterns.setup {
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}

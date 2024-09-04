-- stylua: ignore start
vim.g.mapleader      = ","
vim.g.localmapleader = "\\"

-- Options ====================================================================

vim.opt.expandtab     = true                 -- Convert tabs to spaces
vim.opt.ignorecase    = true                 -- Ingore case in search patterns
vim.opt.inccommand    = "split"              -- Preview substitution commands in separate window
vim.opt.list          = true                 -- Show helpful character indicators
vim.opt.shiftwidth    = 4                    -- Number of spaces to use for each step of (auto)indent
vim.opt.signcolumn    = "yes"                -- Always draw the signcolumn
vim.opt.smartcase     = true                 -- Make search patterns with capitals case-sensitive
vim.opt.spelllang     = { "en", "sv" }       -- Define spelling dictionaries
vim.opt.spelloptions:append "camel"          -- Consider each part of CamelCased words when spelling
vim.opt.splitbelow    = true                 -- Put new horizontal windows below current
vim.opt.splitright    = true                 -- Put new vertical windows to the right of current
vim.opt.tabstop       = 4                    -- Number of spaces that tabs counts for
vim.opt.termguicolors = true                 -- True color support
vim.opt.undofile      = true                 -- Save undo history

vim.opt.listchars = { extends = "…", nbsp = "␣", precedes = "…", space = "⋅", tab = "» " }
--stylua: ignore end

-- Keymaps ====================================================================

vim.keymap.set("i", "<C-c>", "<Esc>")

-- Yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Display the next/previous item in the quickfix list
vim.keymap.set("n", "<C-j>", "<Cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<Cmd>cprev<CR>zz")

-- Remap up/down for dealing with word wrap
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Autocommands ===============================================================

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function()
        vim.cmd.nohlsearch()
      end)
    end
  end,
})

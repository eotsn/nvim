-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before loading
-- lazy.nvim so that mappings are correct
vim.g.mapleader = ","
vim.g.localmapleader = "\\"

vim.opt.termguicolors = true -- True color support

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers

vim.opt.splitbelow = true -- Put new windows below the current
vim.opt.splitright = true -- Put new windows right of the current

vim.opt.ignorecase = true -- Ignore case in search patterns ...
vim.opt.smartcase = true -- ... unless it contains capital characters

vim.opt.signcolumn = "yes" -- Always draw the signcolumn
vim.opt.colorcolumn = "80" -- Show visual guide(s) to help with aligment

vim.opt.inccommand = "split" -- Preview off-screen results

vim.opt.cursorline = true -- Highlight the current line ...
vim.opt.cursorlineopt = "number" -- ... but only the line number

-- Integrate ThePrimeagen's fzf-powered tmux session manager
vim.keymap.set("n", "<C-f>", "<CMD>silent !tmux neww tmux-sessionizer<CR>")

-- Remap up/down for dealing with word wrap
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move visual selection up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor at its current position when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor line centered while scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without overwriting the unnamed (or default) register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Quickfix list navigation
vim.keymap.set("n", "<C-j>", "<Cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<Cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<Cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<Cmd>lprev<CR>zz")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Setup lazy.nvim
require("lazy").setup({ import = "plugins" }, {
  change_detection = {
    notify = false,
  },
})

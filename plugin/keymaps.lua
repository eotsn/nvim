local set = vim.keymap.set

set("n", "<C-f>", "<CMD>silent !tmux neww tmux-sessionizer<CR>")

-- Remap up/down for dealing with word wrap
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move visual selection up/down
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor at its current position when joining lines
set("n", "J", "mzJ`z")

-- Keep cursor line centered while scrolling
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Paste without overwriting the unnamed (or default) register
set("x", "<leader>p", [["_dP]])

-- Yank into system clipboard
set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])

-- Quickfix list navigation
set("n", "<C-j>", "<CMD>cnext<CR>zz")
set("n", "<C-k>", "<CMD>cprev<CR>zz")
set("n", "<leader>j", "<CMD>lnext<CR>zz")
set("n", "<leader>k", "<CMD>lprev<CR>zz")

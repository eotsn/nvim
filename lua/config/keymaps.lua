local map = vim.keymap.set

map("n", "<leader>fe", vim.cmd.Ex, { desc = "File explorer (current dir)" })

-- Remap up/down for dealing with word wrap
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move visual selection up/down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor at its current position when joining lines
map("n", "J", "mzJ`z")

-- Keep cursor line centered while scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Paste without overwriting the unnamed (or default) register
map("x", "<leader>p", [["_dP]])

-- Yank into system clipboard
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

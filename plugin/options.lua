local opt = vim.opt

opt.colorcolumn = "100"

-- Enable highlighting of the current line
opt.cursorline = true

-- Enable relative line numbers
opt.number = true
opt.relativenumber = true
opt.statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum} "

-- Enable mouse mode
opt.mouse = "a"

-- Show some invisible characters (tabs...
opt.list = false
opt.listchars = "tab:» ,space:·,trail:-,nbsp:+"

-- Always show the signcolumn
opt.signcolumn = "yes"

-- Show some additional lines of context around the cursor
opt.scrolloff = 8

-- Insert indents automatically
opt.smartindent = true

-- Number of spaces that a <Tab> counts for
opt.tabstop = 4

-- Number of spaces to use for each step of (auto)indent
opt.shiftwidth = 4

-- Use spaces instead of tabs for indentation
opt.expandtab = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Show partial off-screen search results
opt.inccommand = "split"

-- Enable true color (24-bit) support
opt.termguicolors = true

-- Save undo history
opt.undofile = true

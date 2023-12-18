-- [[ Set Neovim options ]]
-- See `:help vim.o`
vim.o.completeopt = 'menuone,noselect'
vim.o.conceallevel = 3 -- Hide * markup for bold and italic
vim.o.cursorline = true -- Enable highlighting of the current line
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.ignorecase = true -- Ignore case
vim.o.list = true -- Show some invisible characters (tabs...
vim.o.listchars = 'tab:» ,space:·,trail:-,nbsp:+'
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.number = true -- Print line number
vim.o.relativenumber = true -- Relative line numbers
vim.o.scrolloff = 8 -- Lines of context
vim.o.shiftwidth = 4 -- Size of an indent
vim.o.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.smartindent = true -- Insert indents automatically
vim.o.tabstop = 4 -- Number of spaces tabs count for
vim.o.termguicolors = true -- True color support
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 200 -- Save swap file and trigger CursorHold
vim.o.wrap = false -- Disable line wrap

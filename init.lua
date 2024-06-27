do
  local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
  else
  end
  do end (vim.opt.rtp):prepend(lazypath)
end
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.colorcolumn = "100"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.list = true
vim.o.listchars = "tab:\194\187 ,space:\194\183,trail:-,nbsp:+"
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum} "
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undofile = true
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")
vim.keymap.set({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})
vim.keymap.set({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({"n", "x"}, "<leader>p", "\"_dP")
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<C-j>", "<CMD>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<CMD>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<CMD>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<CMD>lprev<CR>zz")
local function _2_()
  return vim.highlight.on_yank()
end
vim.api.nvim_create_autocmd("TextYankPost", {group = vim.api.nvim_create_augroup("YankHighlight", {clear = true}), callback = _2_})
local function _3_()
  vim.opt.expandtab = false
  return nil
end
vim.api.nvim_create_autocmd("FileType", {pattern = "go", callback = _3_})
local function _4_()
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  return nil
end
vim.api.nvim_create_autocmd("FileType", {pattern = "lua", callback = _4_})
local plugins = {}
local function _5_()
  return vim.cmd.colorscheme("modus_operandi")
end
local function _6_(_241, _242)
  _241.Whitespace = {fg = _242.bg_dim}
  return nil
end
table.insert(plugins, {"miikanissi/modus-themes.nvim", init = _5_, lazy = false, opts = {variant = "tinted", on_highlights = _6_}, priority = 1000})
local function _7_()
  local oil = require("oil")
  return oil.open()
end
table.insert(plugins, {"stevearc/oil.nvim", keys = {{"-", _7_}}, lazy = false, opts = {columns = {"permissions", "size", "mtime", "icon"}}})
local function _8_()
  local function _9_()
    if pcall(vim.treesitter.start) then
      return false
    else
      return nil
    end
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _9_})
end
table.insert(plugins, {"nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate", init = _8_, lazy = false, opts = {ensure_install = "community"}})
local function _11_()
  local fzf = require("fzf-lua")
  return fzf.files()
end
local function _12_()
  local fzf = require("fzf-lua")
  return fzf.live_grep()
end
local function _13_()
  local fzf = require("fzf-lua")
  return fzf.helptags()
end
local function _14_()
  local fzf = require("fzf-lua")
  return fzf.resume()
end
table.insert(plugins, {"ibhagwan/fzf-lua", keys = {{"<leader>sf", _11_}, {"<leader>sg", _12_}, {"<leader>sh", _13_}, {"<leader>sr", _14_}}, opts = {grep = {rg_glob = true}, winopts = {split = "belowright new", preview = {hidden = "hidden"}}}})
local function _15_()
  local lsp_zero = require("lsp-zero")
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")
  local function _16_(_241, _242)
    return lsp_zero.default_keymaps({buffer = _242})
  end
  lsp_zero.on_attach(_16_)
  mason.setup({})
  mason_lspconfig.setup({handlers = {lsp_zero.default_setup}})
  return lspconfig.fennel_ls.setup({settings = {["fennel-ls"] = {["extra-globals"] = "vim"}}})
end
table.insert(plugins, {"VonHeikemen/lsp-zero.nvim", branch = "v3.x", config = _15_, dependencies = {"neovim/nvim-lspconfig", "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"}})
local function _17_()
  local conform = require("conform")
  return conform.format()
end
table.insert(plugins, {"stevearc/conform.nvim", keys = {{"<leader>f", _17_}}, opts = {formatters_by_ft = {lua = {"stylua"}, go = {"goimports", "gofumpt"}}}})
local function _18_()
  local mini_ai = require("mini.ai")
  local mini_surround = require("mini.surround")
  mini_ai.setup()
  return mini_surround.setup()
end
table.insert(plugins, {"echasnovski/mini.nvim", config = _18_})
local function _19_()
  local function _20_()
    local function _21_()
      return vim.keymap.set("n", "q", "<c-w>q", {buffer = true})
    end
    return vim.schedule(_21_)
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = {"fugitive", "git"}, callback = _20_})
end
table.insert(plugins, {"tpope/vim-fugitive", config = _19_, dependencies = {"tpope/vim-rhubarb"}, keys = {{"<leader>gs", "<cmd>:tab Git<cr>"}, {"<leader>gl", "<cmd>:tab Git log --graph --oneline --decorate<cr>"}}, lazy = false})
table.insert(plugins, {"jinh0/eyeliner.nvim", opts = {highlight_on_key = true, dim = true}})
table.insert(plugins, {"laytan/cloak.nvim", lazy = false})
local function _22_()
  local opts = {}
  local function on_attach(buffer)
    local gs = package.loaded.gitsigns
    local function _23_()
      if vim.wo.diff then
        return vim.cmd.normal({args = {"]c"}, bang = true})
      else
        return gs.nav_hunk("next")
      end
    end
    vim.keymap.set("n", "]c", _23_, {buffer = buffer})
    local function _25_()
      if vim.wo.diff then
        return vim.cmd.normal({args = {"[c"}, bang = true})
      else
        return gs.nav_hunk("prev")
      end
    end
    vim.keymap.set("n", "[c", _25_, {buffer = buffer})
    vim.keymap.set("n", "<leader>ghp", gs.preview_hunk_inline)
    return vim.keymap.set("n", "<leader>ghr", gs.reset_hunk)
  end
  opts["on_attach"] = on_attach
  return opts
end
table.insert(plugins, {"lewis6991/gitsigns.nvim", event = {"BufReadPost", "BufNewFile", "BufWritePre"}, opts = _22_})
table.insert(plugins, {"nvim-lua/plenary.nvim", lazy = true})
local function _27_()
  local keys
  local function _28_()
    return require("harpoon"):list():add()
  end
  local function _29_()
    local harpoon = require("harpoon")
    return (harpoon.ui):toggle_quick_menu(harpoon:list())
  end
  keys = {{"<leader>H", _28_}, {"<leader>h", _29_}}
  local tbl_17_auto = keys
  for i = 1, 5, 1 do
    local val_18_auto
    local function _30_()
      return require("harpoon"):list():select(i)
    end
    val_18_auto = {("<leader>" .. i), _30_}
    table.insert(tbl_17_auto, val_18_auto)
  end
  return tbl_17_auto
end
table.insert(plugins, {"ThePrimeagen/harpoon", branch = "harpoon2", keys = _27_, opts = {settings = {save_on_toggle = true}}})
local function _31_()
  vim.g.copilot_enabled = 0
  return nil
end
local function _32_()
  if (vim.g.copilot_enabled ~= 0) then
    return vim.cmd.Copilot({"disable"})
  else
    return vim.cmd.Copilot({"enable"})
  end
end
table.insert(plugins, {"github/copilot.vim", init = _31_, keys = {{"<leader>cc", _32_}}})
local function _34_()
  vim.g.undotree_SetFocusWhenToggle = 1
  return nil
end
table.insert(plugins, {"mbbill/undotree", cmd = "UndotreeToggle", init = _34_, keys = {{"<F5>", "<cmd>UndotreeToggle<cr>"}}})
local function _35_()
  local cmp = require("cmp")
  return {sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "nvim_lsp_signature_help"}, {name = "path"}}, {{name = "buffer"}})}
end
table.insert(plugins, {"hrsh7th/nvim-cmp", dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lsp-signature-help", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path"}, event = {"InsertEnter"}, opts = _35_})
local lazy = require("lazy")
return lazy.setup(plugins)

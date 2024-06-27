;;; init.fnl

;; This is my personal Neovim configuration. It's intentionally lean
;; with only a small number of extensions to boost productivity,
;; excluding mostly anything which is aimed towards "prettifying" the
;; user interface.
;;
;; Why Fennel? During my excursion into Emacs a while back I found
;; that I strongly preferred defining my configuration with Elisp
;; instead of JSON, or any other language. Coming back to Neovim, Lua
;; wasn't too bad; however, Fennel brings back my familiar Lisp-like
;; syntax, meta-programming, etc., as well as some nice improvements
;; to functions, tables, loops, and variables.
;;
;; However, while Neovim's Lua API is nice there are several instances
;; where applying idiomatic Fennel is hard when working with libraries
;; and frameworks (I'm looking at you lazy.nvim). Personally, I find
;; the tradeoffs are still worth it.

;;; Code:



;; Make sure to setup `mapleader` and `maplocalleader` before loading
;; lazy.nvim so that mappings are correct.
(set vim.g.mapleader " ")
(set vim.g.maplocalleader "\\")

;;; Options:

(macro opt! [name ?value]
  "Sets the value of an option. If the value is absent it is assumed
  to be an on/off option and will be set to true."
  (let [value (or ?value true)]
    `(tset vim.opt ,name ,value)))

;; Show the popup menu for any match, and without a default selection.
;; This makes autocomplete a deliberate action, which is a preference
;; of mine.
(opt! :completeopt "menu,menuone,noselect")

;; Case-insensitive searching UNLESS \C or capital in search, and show
;; off-screen results in a split.
(opt! :ignorecase) 
(opt! :smartcase)
(opt! :inccommand :split)

;; I find it useful to be able to easily distinguish between spaces,
;; tabs, etc. in files which could contain any mix of these, and where
;; auto-format is not supported.
(opt! :list)
(opt! :listchars "tab:» ,space:·,trail:-,nbsp:+")

;; Relative line numbers pairs extremely well with the ability to
;; multiply or iterate commands in Neovim.
(opt! :number)
(opt! :relativenumber)

;; Right-align the current line number. This is one of the few purely
;; cosmetic changes you'll find in this config...
(opt! :statuscolumn "%s%=%{v:relnum?v:relnum:v:lnum} ")
(opt! :signcolumn "yes")
(opt! :scrolloff 8)

;; Replace tabs with spaces, which is the norm for most (popular)
;; languages. However, unlike most languagues I like to keep the width
;; at 4 instead of 2.
(opt! :expandtab)
(opt! :tabstop 4)
(opt! :softtabstop 4)
(opt! :shiftwidth 4)
(opt! :smartindent)

;; Save undo history to backtrack changes across sessions. Especially
;; powerful when combined with undotree.
(opt! :undofile)

;; I find disabling line wrapping makes me more thoughtful of how I
;; structure my code. Nicely complemented by colorcolumn.
(opt! :wrap)
(opt! :colorcolumn :80)

;; Enable true color (24-bit) support.
(opt! :termguicolors)

;;; Keymaps:

(macro map! [mode lhs rhs & opts]
  "Adds a new mapping. Accepts a concatenated list of modes instead of
  a table, i.e. :nx instead of [:n :x], and any number of options.
  Single-value options will automatically expand to true."
  (let [opts-list {}
        mode-list (fcollect [i 1 (length mode)]
                    (mode:sub i i))]
    (each [_ v (ipairs opts)]
      (if (table? v)
          (each [k v (pairs v)]
            (tset opts-list k v))
          (tset opts-list v true)))
    `(vim.keymap.set ,mode-list ,lhs ,rhs ,opts-list)))

(map! :n "<C-f>" "<cmd>silent !tmux neww tmux-sessionizer<cr>")

;;; Remap up/down for dealing with word wrap.
(map! :nx "j" "v:count == 0 ? 'gj' : 'j'" :expr :silent)
(map! :nx "k" "v:count == 0 ? 'gk' : 'k'" :expr :silent)

;;; Move visual selection up/down.
(map! :v "J" ":m '>+1<CR>gv=gv")
(map! :v "K" ":m '<-2<CR>gv=gv")

;;; Keep cursor at its current position when joining lines.
(map! :n "J" "mzJ`z")

;;; Keep cursor line centered while scrolling.
(map! :n "<C-d>" "<C-d>zz")
(map! :n "<C-u>" "<C-u>zz")
(map! :n "n" "nzzzv")
(map! :n "N" "Nzzzv")

;;; Paste without overwriting the unnamed (or default) register.
(map! :nx "<leader>p" "\"_dP")

;;; Yank into system clipboard.
(map! :nv "<leader>y" "\"+y")
(map! :n "<leader>Y" "\"+Y")

;;; Quickfix list navigation.
(map! :n "<C-j>" "<CMD>cnext<CR>zz")
(map! :n "<C-k>" "<CMD>cprev<CR>zz")
(map! :n "<leader>j" "<CMD>lnext<CR>zz")
(map! :n "<leader>k" "<CMD>lprev<CR>zz")

;;; Basic autocommands:

(macro autocmd! [event opt]
  "Creates an autocommand event handler."
  `(vim.api.nvim_create_autocmd ,event ,opt))

(macro augroup! [name event opt]
  "Create an autocommand event handler with a corresponding
  autocommand group, using the provided name."
  (local group (sym :group))
  (tset opt :group group)
  `(let [,group (vim.api.nvim_create_augroup ,name {:clear true})]
     (autocmd! ,event ,opt)))

(augroup! :YankHighlight
  :TextYankPost {:pattern "*"
                 :callback (fn []
                             (vim.highlight.on_yank))})

;; Filetype autocommands, instead of using after/ftplugin.

(autocmd!
  :FileType {:pattern "go"
             :callback (fn []
                         (set vim.opt.expandtab false))})

(autocmd!
  :FileType {:pattern "lua"
             :callback (fn []
                         (set vim.opt.shiftwidth 2)
                         (set vim.opt.expandtab true))})

;;; Bootstrap lazy.nvim:

(let [lazypath (.. (vim.fn.stdpath :data) "/lazy/lazy.nvim")]
  (when (not (vim.loop.fs_stat lazypath))
    (vim.fn.system ["git"
                    "clone"
                    "--filter=blob:none"
                    "https://github.com/folke/lazy.nvim.git"
                    "--branch=stable"
                    lazypath]))
  (vim.opt.rtp:prepend lazypath))

;;; Setup lazy.nvim:

(macro plug! [ref & opts]
  "A slightly nicer way of writing lazy.nvim plugin specs, since we
  can't mix regular and sequential tables."
  (let [t {}]
    (for [i 1 (length opts) 2]
      (tset t (. opts i) (. opts (+ i 1))))
    (doto t (tset 1 ref))))

(let [lazy (require :lazy)]
  (lazy.setup
    [
     (plug! :miikanissi/modus-themes.nvim
            :lazy false
            :priority 1000
            :opts {:variant :tinted
                   :on_highlights #(set $1.Whitespace {:fg $2.bg_dim})}
            :init (fn []
                    (vim.cmd.colorscheme :modus_operandi)))

     (plug! :stevearc/oil.nvim
            :lazy false
            :keys [["-" #(let [oil (require :oil)] (oil.open))]]
            :opts {:columns [:permissions :size :mtime :icon]})

     (plug! :nvim-treesitter/nvim-treesitter
            :build ":TSUpdate"
            :branch :main
            :lazy false
            :opts {:ensure_install :community}
            :init (fn []
                    ;; When creating the callback we have to capture
                    ;; the return value of pcall, as a truthy value
                    ;; will delete the autocommand.
                    (vim.api.nvim_create_autocmd
                      [:FileType]
                      {:callback #(if (pcall vim.treesitter.start) false)})))

     (plug! :ibhagwan/fzf-lua
            :keys [["<leader>sf" #(let [fzf (require :fzf-lua)] (fzf.files))]
                   ["<leader>sg" #(let [fzf (require :fzf-lua)] (fzf.live_grep))]
                   ["<leader>sh" #(let [fzf (require :fzf-lua)] (fzf.helptags))]
                   ["<leader>sr" #(let [fzf (require :fzf-lua)] (fzf.resume))]]
            :opts {:grep {:rg_glob true}
                   :winopts {:split "belowright new"
                             :preview {:hidden :hidden}}})

     (plug! :VonHeikemen/lsp-zero.nvim
            :branch "v3.x"
            :dependencies [:neovim/nvim-lspconfig
                           :williamboman/mason.nvim
                           :williamboman/mason-lspconfig.nvim]
            :config (fn []
                      (let [lsp-zero (require :lsp-zero)
                            mason (require :mason)
                            mason-lspconfig (require :mason-lspconfig)
                            lspconfig (require :lspconfig)]
                        (lsp-zero.on_attach #(lsp-zero.default_keymaps {:buffer $2}))
                        (mason.setup {})
                        (mason-lspconfig.setup {:ensure_installed [:clangd :gopls :lua_ls :fennel_ls]
                                                :handlers [lsp-zero.default_setup]})
                        (lspconfig.fennel_ls.setup {:settings {:fennel-ls {:extra-globals :vim}}}))))

     (plug! :stevearc/conform.nvim
            :keys [["<leader>f" #(let [conform (require :conform)]
                                   (conform.format))]]
            :opts {:formatters_by_ft {:lua [:stylua]
                                      :go [:goimports :gofumpt]
                                      :fennel [:fnlfmt]}})

     (plug! :echasnovski/mini.nvim
            :config (fn []
                      (let [mini-ai (require :mini.ai)
                            mini-surround (require :mini.surround)]
                        (mini-ai.setup)
                        (mini-surround.setup))))

     (plug! :tpope/vim-fugitive
            :dependencies [:tpope/vim-rhubarb]
            :lazy false
            :keys [["<leader>gs" "<cmd>:tab Git<cr>"]
                   ["<leader>gl" "<cmd>:tab Git log --graph --oneline --decorate<cr>"]]
            :config (fn []
                      (autocmd!
                        :FileType {:pattern [:fugitive :git]
                                   :callback (fn []
                                               (vim.schedule #(map! :n "q" "<c-w>q" :buffer)))})))

     (plug! :jinh0/eyeliner.nvim
            :opts {:highlight_on_key true :dim true})

     (plug! :laytan/cloak.nvim :lazy false)

     (plug! :lewis6991/gitsigns.nvim
            :event [:BufReadPost :BufNewFile :BufWritePre]
            :opts (fn []
                    (local opts {})
                    (fn on_attach [buffer]
                      (let [gs package.loaded.gitsigns]
                        (map! :n "]c" #(if vim.wo.diff
                                         (vim.cmd.normal {:args ["]c"] :bang true})
                                         (gs.nav_hunk :next)) {: buffer})
                        (map! :n "[c" #(if vim.wo.diff
                                         (vim.cmd.normal {:args ["[c"] :bang true})
                                         (gs.nav_hunk :prev)) {: buffer})
                        (map! :n "<leader>ghp" gs.preview_hunk_inline)
                        (map! :n "<leader>ghr" gs.reset_hunk)))
                    (tset opts :on_attach on_attach) opts))

     (plug! :ThePrimeagen/harpoon
            :branch :harpoon2
            :dependencies [:nvim-lua/plenary.nvim]
            :opts {:settings {:save_on_toggle true}}
            :keys (fn []
                    (let [keys [["<leader>H" #(-> (require :harpoon)
                                                  (: :list)
                                                  (: :add))]
                                ["<leader>h" #(let [harpoon (require :harpoon)]
                                                (harpoon.ui:toggle_quick_menu (harpoon:list)))]]]
                      (fcollect [i 1 5 1 &into keys]
                        [(.. "<leader>" i) #(-> (require :harpoon)
                                                (: :list)
                                                (: :select i))]))))

     (plug! :github/copilot.vim
            :keys [["<leader>cc" #(if (~= vim.g.copilot_enabled 0)
                                      (vim.cmd.Copilot [:disable])
                                      (vim.cmd.Copilot [:enable]))]]
            :init (fn []
                    (set vim.g.copilot_enabled 0))) ; disable copilot by default

     (plug! :mbbill/undotree
            :cmd "UndotreeToggle"
            :keys [["<F5>" "<cmd>UndotreeToggle<cr>"]]
            :init (fn []
                    (set vim.g.undotree_SetFocusWhenToggle 1)))

     (plug! :hrsh7th/nvim-cmp
            :event [:InsertEnter]
            :dependencies [:hrsh7th/cmp-nvim-lsp
                           :hrsh7th/cmp-nvim-lsp-signature-help
                           :hrsh7th/cmp-buffer
                           :hrsh7th/cmp-path]
            :opts (fn []
                    (let [cmp (require :cmp)]
                      {:sources (cmp.config.sources [{:name :nvim_lsp}
                                                     {:name :nvim_lsp_signature_help}
                                                     {:name :path}]
                                                    [{:name :buffer}])})))
     ]))
;;; init.fnl ends here

(let [lazypath (.. (vim.fn.stdpath :data) "/lazy/lazy.nvim")]
  (when (not (vim.loop.fs_stat lazypath))
    (vim.fn.system ["git"
                    "clone"
                    "--filter=blob:none"
                    "https://github.com/folke/lazy.nvim.git"
                    "--branch=stable"
                    lazypath]))
  (vim.opt.rtp:prepend lazypath))

;; Macros!

(macro map! [mode lhs rhs & opts]
  (let [opts (collect [_ v (ipairs opts)]
               (tostring v)
               true)]
    `(vim.keymap.set ,mode ,lhs ,rhs ,opts)))

(macro autocmd! [event opts]
  `(vim.api.nvim_create_autocmd ,event ,opts))

;; Options

(set vim.g.mapleader " ")
(set vim.g.maplocalleader "\\")

(set vim.o.colorcolumn :100)
(set vim.o.cursorline true)
(set vim.o.expandtab true)
(set vim.o.ignorecase true) ; Case-insensitive searching UNLESS \C or capital in search.
(set vim.o.inccommand "split") ; Show partial off-screen search results.
(set vim.o.list true)
(set vim.o.listchars "tab:» ,space:·,trail:-,nbsp:+")
(set vim.o.mouse :a)
(set vim.o.number true)
(set vim.o.relativenumber true)
(set vim.o.scrolloff 8) ; Show some additional lines of context around the cursor.
(set vim.o.shiftwidth 4) ; Number of spaces to use for each step of (auto)indent.
(set vim.o.signcolumn "yes")
(set vim.o.smartcase true)
(set vim.o.smartindent true)
(set vim.o.statuscolumn "%s%=%{v:relnum?v:relnum:v:lnum} ")
(set vim.o.tabstop 4) ; Number of spaces that a <Tab> counts for.
(set vim.o.termguicolors true) ; Enable true color (24-bit) support.
(set vim.o.undofile true)


;;; Keymaps

(vim.keymap.set :n "<C-f>" "<cmd>silent !tmux neww tmux-sessionizer<cr>")

;;; Remap up/down for dealing with word wrap
(vim.keymap.set [:n :x] "j" "v:count == 0 ? 'gj' : 'j'" {:expr true :silent true})
(vim.keymap.set [:n :x] "k" "v:count == 0 ? 'gk' : 'k'" {:expr true :silent true})

;;; Move visual selection up/down
(vim.keymap.set :v "J" ":m '>+1<CR>gv=gv")
(vim.keymap.set :v "K" ":m '<-2<CR>gv=gv")

;;; Keep cursor at its current position when joining lines
(vim.keymap.set :n "J" "mzJ`z")

;;; Keep cursor line centered while scrolling
(vim.keymap.set :n "<C-d>" "<C-d>zz")
(vim.keymap.set :n "<C-u>" "<C-u>zz")
(vim.keymap.set :n "n" "nzzzv")
(vim.keymap.set :n "N" "Nzzzv")

;;; Paste without overwriting the unnamed (or default) register
(vim.keymap.set [:n :x] "<leader>p" "\"_dP")

;;; Yank into system clipboard
(vim.keymap.set [:n :v] "<leader>y" "\"+y")
(vim.keymap.set :n "<leader>Y" "\"+Y")

;;; Quickfix list navigation
(vim.keymap.set :n "<C-j>" "<CMD>cnext<CR>zz")
(vim.keymap.set :n "<C-k>" "<CMD>cprev<CR>zz")
(vim.keymap.set :n "<leader>j" "<CMD>lnext<CR>zz")
(vim.keymap.set :n "<leader>k" "<CMD>lprev<CR>zz")

;;

(autocmd! :TextYankPost
          {:group (vim.api.nvim_create_augroup :YankHighlight {:clear true})
           :callback (fn []
                       (vim.highlight.on_yank))})


;; Filetype autocommands, instead of using after/ftplugin.

(autocmd! :FileType
          {:pattern "go"
           :callback (fn []
                       (set vim.opt.expandtab false))})

(autocmd! :FileType
          {:pattern "lua"
           :callback (fn []
                       (set vim.opt.shiftwidth 2)
                       (set vim.opt.expandtab true))})

;; Create the plugin spec table containing all active plugins which should be
;; loaded by lazy.nvim. Plugins are added automatically when configured with
;; the plug! macr.
(local plugins [])

(macro plug! [ref & opts]
  (let [t {}]
    (for [i 1 (length opts) 2]
      (tset t (. opts i) (. opts (+ i 1))))
    (doto t (tset 1 ref))
    `(table.insert plugins ,t)))

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
               ;; When creating the callback we have to capture the return
               ;; value of pcall as a truthy value will delete the autocommand.
               (autocmd! :FileType
                         {:callback (fn []
                                      (if (pcall vim.treesitter.start) false))})))

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
                   (mason-lspconfig.setup {:handlers [lsp-zero.default_setup]})
                   (lspconfig.fennel_ls.setup {:settings {:fennel-ls {:extra-globals :vim}}}))))

(plug! :stevearc/conform.nvim
       :keys [["<leader>f" #(let [conform (require :conform)]
                              (conform.format))]]
       :opts {:formatters_by_ft {:lua [:stylua]
                                 :go [:goimports :gofumpt]}})

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
                 (autocmd! :FileType
                           {:pattern [:fugitive :git]
                            :callback (fn []
                                        (vim.schedule #(vim.keymap.set :n "q" "<c-w>q" {:buffer true})))})))

(plug! :jinh0/eyeliner.nvim
       :opts {:highlight_on_key true :dim true})

(plug! :laytan/cloak.nvim :lazy false)

(plug! :lewis6991/gitsigns.nvim
       :event [:BufReadPost :BufNewFile :BufWritePre]
       :opts (fn []
               (local opts {})
               (fn on_attach [buffer]
                 (let [gs package.loaded.gitsigns]
                   (vim.keymap.set :n "]c" #(if vim.wo.diff
                                                (vim.cmd.normal {:args ["]c"] :bang true})
                                                (gs.nav_hunk :next)) {: buffer})
                   (vim.keymap.set :n "[c" #(if vim.wo.diff
                                                (vim.cmd.normal {:args ["[c"] :bang true})
                                                (gs.nav_hunk :prev)) {: buffer})
                   (vim.keymap.set :n "<leader>ghp" gs.preview_hunk_inline)
                   (vim.keymap.set :n "<leader>ghr" gs.reset_hunk)))
               (tset opts :on_attach on_attach) opts))

;; Library used by other plugins.
(plug! :nvim-lua/plenary.nvim :lazy true)

(plug! :ThePrimeagen/harpoon
       :branch :harpoon2
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

;;; Completion

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

(let [lazy (require :lazy)]
  (lazy.setup plugins))

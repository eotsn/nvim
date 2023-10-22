local function augroup(name, f)
  f(vim.api.nvim_create_augroup(name, { clear = true }))
end

-- highlight on yank
augroup("HighlightYank", function(g)
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = g,
    callback = function()
      vim.highlight.on_yank()
    end,
  })
end)

-- format current buffer using LSP
augroup("FormatCurrentBuffer", function(g)
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = g,
    pattern = { "*.go", "*.templ" },
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end)

-- highlight search matches only when in command mode
augroup("HighlightIncSearch", function(g)
  vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = g,
    callback = function()
      vim.o.hlsearch = true
    end,
  })
  vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = g,
    callback = function()
      vim.o.hlsearch = false
    end,
  })
end)

-- [[ Configure automatic commands ]]
-- See `:help autocmd`
local function augroup(name, f)
  f(vim.api.nvim_create_augroup(name, { clear = true }))
end

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
augroup('HighlightYank', function(g)
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = g,
    pattern = '*',
    callback = function()
      vim.highlight.on_yank()
    end,
  })
end)

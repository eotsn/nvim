return {
  "github/copilot.vim",
  config = function()
    -- Keep Copilot disabled by default
    vim.g.copilot_enabled = 0

    vim.keymap.set("n", "<leader>cc", function()
      if vim.g.copilot_enabled ~= 0 then
        vim.cmd.Copilot { "disable" }
      else
        vim.cmd.Copilot { "enable" }
      end
    end, { noremap = true, silent = true })
  end,
}

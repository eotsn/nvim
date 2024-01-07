local cfg_mods = { "autocmds", "keymaps", "options" }
for _, mod in ipairs(cfg_mods) do
  require("config." .. mod)
end

return {
  { "folke/lazy.nvim", version = "*" },
}

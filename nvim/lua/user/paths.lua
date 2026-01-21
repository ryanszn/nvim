-- lua/user/paths.lua
local home = vim.fn.expand("~")

return {
  notes = home .. "/Documents/Notes",
  keymaps = home .. "/Documents/Notes/CustomKeymaps.md",
  config = vim.fn.stdpath("config") .. "/init.lua"
}

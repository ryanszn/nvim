-- lua/user/config/persistence.lua
require("persistence").setup({
  dir = vim.fn.stdpath("state") .. "/sessions/",
  options = { "buffers", "curdir", "tabpages", "winsize" },
})

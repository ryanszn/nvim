local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Basic visual tweaks (we’ll do full layout in dashboard.lua)
dashboard.section.header.val = {
  "NEOVIM",
  "Welcome to your personal dashboard!",
}

dashboard.section.footer.val = "Press <Enter> to begin"

-- Load the layout
alpha.setup(dashboard.config)

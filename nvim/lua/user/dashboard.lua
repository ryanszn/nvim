local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
  " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
  " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
  " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
  " ♡         Welcome to Ryan's Neovim ₍^. .^₎⟆     ♡ ",
}

dashboard.section.buttons.val = {
  -- basics
  dashboard.button("e", "📄  New File", ":ene <BAR> startinsert <CR>"),
  dashboard.button("r", "♻️  Restore Session", ":lua require('persistence').load({ dir = vim.fn.getcwd() or vim.loop.os_homedir() })<CR>"),

  -- navigation / search
  dashboard.button("o", "🕘  Recent Files", ":Telescope oldfiles<CR>"),
  dashboard.button("g", "🔎  Live Grep", ":Telescope live_grep<CR>"),

  -- notes / docs
  dashboard.button("k", "🧠  View Keymaps", ":e C:/Users/ryang/Documents/Notes/CustomKeymaps.md<CR>"),
  dashboard.button("n", "🗒️  Browse Notes", ":Oil C:/Users/ryang/Documents/Notes<CR>"),

  -- config & maintenance
  dashboard.button("c", "⚙️  Edit Config", ":e $MYVIMRC<CR>"),
  dashboard.button("C", "📂  Config Folder", ":lua vim.cmd('Oil ' .. vim.fn.stdpath('config'))<CR>"),
  dashboard.button("u", "⬆️  Update Plugins", ":Lazy sync<CR>"),

  -- session
  dashboard.button("q", "❌  Quit", ":qa<CR>"),
}


-- Footer: CWD (top) + Date/Time (below)
local function footer_lines()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
  local datetime = os.date("%Y-%m-%d  %H:%M")
  return { cwd, datetime }
end

-- Center each line based on its own width (not the longest one)
local SHIFT = -5  -- nudge left/right if your terminal renders 1 cell off
local function center_lines(lines)
  local cols = vim.o.columns
  local out = {}
  for _, s in ipairs(lines) do
    local len = vim.fn.strdisplaywidth(s)
    local pad = math.max(0, math.floor((cols - len) / 2) + SHIFT)
    table.insert(out, string.rep(" ", pad) .. s)
  end
  return out
end

local footer_component = {
  type = "text",
  val = function() return center_lines(footer_lines()) end,
  opts = { hl = "Comment" },
}


-- Use a custom layout so the centered footer is used
dashboard.config.layout = {
  { type = "padding", val = 1 },
  dashboard.section.header,
  { type = "padding", val = 1 },
  dashboard.section.buttons,
  { type = "padding", val = 2 },
  footer_component,
}

alpha.setup(dashboard.config)

-- 🔒 Hide the cursor when Alpha is ready
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    vim.cmd("setlocal nocursorline nocursorcolumn")
    vim.cmd("highlight Cursor blend=100")
    vim.cmd("highlight iCursor blend=100")
  end,
})

-- ✅ Restore the cursor when leaving Alpha
vim.api.nvim_create_autocmd("BufUnload", {
  pattern = "*",
  callback = function()
    vim.cmd("highlight Cursor blend=0")
    vim.cmd("highlight iCursor blend=0")
  end,
})

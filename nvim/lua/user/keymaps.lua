-- Load portable paths
local paths = require("user.paths")

--== General Utilities ==--

-- Run current Python script
vim.keymap.set("n", "<leader>rp", ":w<CR>:!python %<CR>", {
  desc = "Run current Python script", noremap = true, silent = false
})

-- Open Neovim config
vim.keymap.set("n", "<leader>rc", ":e " .. paths.config .. "<CR>", {
  desc = "Open Neovim config", noremap = true, silent = false
})


--== ToggleTerm ==--

-- Toggle floating terminal
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", {
  desc = "Toggle floating terminal", noremap = true, silent = true
})

-- Escape terminal mode with Esc or Ctrl+C
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], {
  desc = "Exit terminal mode (Esc)", noremap = true, silent = true
})
vim.api.nvim_set_keymap('t', '<C-c>', [[<C-\><C-n>]], {
  desc = "Exit terminal mode (Ctrl+C)", noremap = true, silent = true
})


--== Oil.nvim File Explorer ==--

-- File browser in current working directory
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", {
  desc = "Open Oil file browser", noremap = true, silent = true
})

-- Open Oil directly in the notes root folder
vim.keymap.set("n", "<leader>nr", function()
  require("oil").open(paths.notes)
end, {
  desc = "Open Notes Root in Oil", noremap = true, silent = true
})

-- Create new file in Oil.nvim
vim.keymap.set("n", "<leader>onf", function()
  vim.ui.input({ prompt = "New file name:" }, function(input)
    if input and input ~= "" then
      local cwd = require("oil").get_current_dir()
      local path = cwd .. "/" .. input
      vim.fn.writefile({}, path)  -- create empty file
      require("oil").open(cwd)    -- refresh Oil
    end
  end)
end, {
  desc = "Create new file in Oil", noremap = true, silent = true
})

-- Create new folder in Oil.nvim
vim.keymap.set("n", "<leader>ond", function()
  vim.ui.input({ prompt = "New folder name:" }, function(input)
    if input and input ~= "" then
      local cwd = require("oil").get_current_dir()
      local path = cwd .. "/" .. input
      vim.fn.mkdir(path, "p")
      require("oil").open(cwd) -- Refresh view
    end
  end)
end, {
  desc = "Create new folder in Oil", noremap = true, silent = true
})

-- Buffer navigation
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close current buffer" })


--== Neorg Notes ==--

-- Open Neorg index file
vim.keymap.set("n", "<leader>ni", ":Neorg index<CR>", {
  desc = "Open Neorg index", noremap = true, silent = true
})

-- Create a new quick note in QuickNotes/
vim.keymap.set("n", "<leader>nq", function()
  vim.ui.input({ prompt = "Quick note filename:" }, function(input)
    if input then
      local path = paths.notes .. "/QuickNotes/" .. input .. ".norg"
      vim.cmd("e " .. path)
    end
  end)
end, {
  desc = "Create quick note", noremap = true, silent = true
})

-- Open today's daily note
vim.keymap.set("n", "<leader>nd", function()
  local date = os.date("%Y-%m-%d")
  local path = paths.notes .. "/Daily/" .. date .. ".norg"
  vim.cmd("e " .. path)
end, {
  desc = "Open today’s daily note", noremap = true, silent = true
})


--== Telescope: Notes Integration ==--

-- Find files inside notes directory
vim.keymap.set("n", "<leader>nf", function()
  require("telescope.builtin").find_files({
    prompt_title = "Find Notes",
    cwd = paths.notes,
    hidden = true
  })
end, {
  desc = "Find notes (Telescope)", noremap = true, silent = true
})

-- Live grep inside notes directory
vim.keymap.set("n", "<leader>ns", function()
  require("telescope.builtin").live_grep({
    prompt_title = "Search Notes",
    search_dirs = { paths.notes }
  })
end, {
  desc = "Search notes (Telescope)", noremap = true, silent = true
})


--== Keymap Tools ==--

-- Regenerate keymaps file
vim.keymap.set("n", "<leader>kg", function()
  require("user.keymap_generator").generate()
end, {
  desc = "Generate keymaps file", noremap = true, silent = true
})

-- Open the generated keymap file
vim.keymap.set("n", "<leader>ko", function()
  vim.cmd("e " .. paths.keymaps)
end, {
  desc = "Open Keymaps Markdown", noremap = true, silent = true
})

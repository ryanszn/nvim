-- keymap_generator.lua
-- Generates a human-readable list of keymaps for each mode.

local M = {}

M.generate = function()
  local output_path = "C:/Users/ryang/Documents/Notes/CustomKeymaps.md"
  local file = io.open(output_path, "w")
  if not file then
    vim.notify("❌ Failed to write CustomKeymaps.md", vim.log.levels.ERROR)
    return
  end

  file:write("# 🎮 Custom Neovim Keymaps\n\n")
  file:write("> This document lists all active keymaps in your Neovim config, grouped by mode and priority.\n\n")

  local mode_labels = {
    n = "Normal Mode",
    i = "Insert Mode",
    v = "Visual Mode",
    x = "Visual Block Mode",
    t = "Terminal Mode",
    c = "Command Mode",
  }

  for _, mode in ipairs({ "n", "i", "v", "x", "t", "c" }) do
    local maps = vim.api.nvim_get_keymap(mode)
    if #maps > 0 then
      file:write(string.format("## %s\n\n", mode_labels[mode] or mode))

      local custom_maps = {}
      local plugin_maps = {}

      for _, map in ipairs(maps) do
        if map.desc then
          table.insert(custom_maps, map)
        else
          table.insert(plugin_maps, map)
        end
      end

      local function write_table(title, maps)
        if #maps == 0 then return end
        file:write(string.format("### %s\n\n", title))
        file:write("| Key | Action | Description |\n")
        file:write("|-----|--------|-------------|\n")
        for _, map in ipairs(maps) do
          local lhs = map.lhs or ""
          local rhs = map.rhs or ""
          local desc = map.desc or ""
          rhs = rhs:gsub("|", "\\|")
          desc = desc:gsub("|", "\\|")
          file:write(string.format("| `%s` | `%s` | %s |\n", lhs, rhs, desc))
        end
        file:write("\n")
      end

      write_table("🔹 Custom Keymaps", custom_maps)
      write_table("⚪ Plugin/Other Keymaps", plugin_maps)

      file:write("---\n\n")
    end
  end

  file:close()
  vim.notify("✅ CustomKeymaps.md written to Notes folder", vim.log.levels.INFO)
end

return M

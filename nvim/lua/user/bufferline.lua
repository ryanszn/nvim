-- lua/user/bufferline.lua
local M = {}

function M.setup()
  local C = require("catppuccin.palettes").get_palette("macchiato")

  require("bufferline").setup({
    options = {
      mode = "buffers",
      numbers = "none",
      diagnostics = "nvim_lsp",

      -- no separators and no indicator glyph
      separator_style = { "", "" },
      indicator = { style = "none" },

      -- remove stray glyphs/icons
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_buffer_icons = false, -- hide devicons entirely (no diamonds)
      modified_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      diagnostics_indicator = function()
        return ""
      end,
    },

    highlights = {
      -- keep transparency
      fill = { bg = "NONE" },
      background = { bg = "NONE", fg = C.overlay1 },
      buffer_visible = { bg = "NONE", fg = C.subtext0 },

      -- make the ACTIVE buffer clearly visible (bold text)
      buffer_selected = { bg = "NONE", fg = C.text, bold = true, italic = false },

      -- make sure no blocks appear
      separator = { bg = "NONE" },
      separator_visible = { bg = "NONE" },
      separator_selected = { bg = "NONE" },

      -- also clear close/modified backgrounds just in case
      close_button = { bg = "NONE" },
      close_button_visible = { bg = "NONE" },
      close_button_selected = { bg = "NONE" },
      modified = { bg = "NONE" },
      modified_visible = { bg = "NONE" },
      modified_selected = { bg = "NONE" },
      tab = { bg = "NONE" },
      tab_selected = { bg = "NONE", bold = true },
    },
  })
end

return M

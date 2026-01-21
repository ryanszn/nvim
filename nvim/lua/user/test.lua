require("bufferline").setup({
  options = {
    mode = "buffers",
    numbers = "none",
    diagnostics = "nvim_lsp",
    separator_style = { "", "" }, -- no separators
    indicator = { style = "none" }, -- no diamonds
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = true,
  },
  highlights = {
    fill = { bg = "NONE" },
    background = { bg = "NONE" },
    buffer_selected = { bold = true, italic = false },
  },
})

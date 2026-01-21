-- lua/user/plugins.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },

  -- Colour Scheme for NVIM
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        integrations = {
          treesitter = true,
          telescope = true,
          bufferline = true,
        },
        -- keep floats/borders transparent too
        custom_highlights = function(_)
          return {
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE" },
            SignColumn = { bg = "NONE" },
            EndOfBuffer = { bg = "NONE" },
            VertSplit = { bg = "NONE" },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*", -- use latest stable version
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<c-\>]], -- Ctrl + \ to toggle
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float", -- "horizontal" | "vertical" | "tab" | "float"
        close_on_exit = true,
        shell = vim.o.shell,
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("user.bufferline").setup()
    end,
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "vim", "query", "markdown", "markdown_inline" },
        highlight = {
          enable = true,
          disable = { "lua" }, -- was "lua " (with a space) before
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "lukas-reineke/headlines.nvim",
    config = function()
      require("user.headlines")
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "markdown", "norg", "org" },
  },

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({})
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("state") .. "/sessions/",
      })
    end,
  },

  -- -------- Portable formatters (auto-install + format on save) --------
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua", -- Lua formatter
          "black", -- Python formatter (since you mentioned Python)
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        format_on_save = function(bufnr)
          if vim.api.nvim_buf_line_count(bufnr) > 5000 then
            return
          end
          return { lsp_fallback = true }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
        },
      })
      vim.api.nvim_create_user_command("Format", function()
        require("conform").format({ async = true })
      end, {})
    end,
  },
})

require("oil").setup()

--== Helpers ==--

-- Get current Oil directory
local function get_oil_dir()
  return require("oil").get_current_dir()
end

-- Get full path of the selected item in Oil
local function get_selected_item_path()
  local oil = require("oil")
  local entry = oil.get_cursor_entry()
  if entry then
    return get_oil_dir() .. "/" .. entry.name
  end
end

--== Oil Buffer Keymaps ==--

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    local opts = { buffer = true, noremap = true, silent = true }

    -- Create new file (without opening)
    vim.keymap.set("n", "<leader>cf", function()
      vim.ui.input({ prompt = "New file name:" }, function(input)
        if input and input ~= "" then
          local path = get_oil_dir() .. "/" .. input
          local fd = vim.loop.fs_open(path, "w", 438)
          if fd then
            vim.loop.fs_close(fd)
            -- Refresh Oil view after slight delay to ensure filesystem update
            vim.defer_fn(function()
              require("oil").open(get_oil_dir())
            end, 100)
          else
            vim.notify(" Failed to create file", vim.log.levels.ERROR)
          end
        end
      end)
    end, opts)


    -- Create new folder
    vim.keymap.set("n", "<leader>cd", function()
      vim.ui.input({ prompt = "New folder name:" }, function(input)
        if input and input ~= "" then
          local path = get_oil_dir() .. "/" .. input
          local success = vim.loop.fs_mkdir(path, 493)
          if success then
            require("oil").open(get_oil_dir())
          else
            vim.notify(" Failed to create folder (already exists?)", vim.log.levels.WARN)
          end
        end
      end)
    end, opts)

    -- Delete file
    vim.keymap.set("n", "<leader>df", function()
      local path = get_selected_item_path()
      if path and vim.fn.isdirectory(path) == 0 then
        vim.ui.select({ "Yes", "No" }, { prompt = "Delete file '" .. path .. "'?" }, function(choice)
          if choice == "Yes" then
            local ok = vim.loop.fs_unlink(path)
            if ok then
              require("oil").open(get_oil_dir())
            else
              vim.notify(" Failed to delete file", vim.log.levels.ERROR)
            end
          end
        end)
      else
        vim.notify(" Not a file or no item selected", vim.log.levels.WARN)
      end
    end, opts)

    -- Delete directory
    vim.keymap.set("n", "<leader>dd", function()
      local path = get_selected_item_path()
      if path and vim.fn.isdirectory(path) == 1 then
        vim.ui.select({ "Yes", "No" }, { prompt = "Delete folder '" .. path .. "'?" }, function(choice)
          if choice == "Yes" then
            local ok = vim.loop.fs_rmdir(path)
            if ok then
              require("oil").open(get_oil_dir())
            else
              vim.notify(" Folder not empty or cannot be removed", vim.log.levels.ERROR)
            end
          end
        end)
      else
        vim.notify(" Not a folder or no item selected", vim.log.levels.WARN)
      end
    end, opts)
  end,
})

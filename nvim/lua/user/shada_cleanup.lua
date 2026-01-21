-- Auto-delete old .shada.tmp.* files to prevent ShaDa errors
local shada_dir = vim.fn.stdpath("data") .. "/shada"
local handle = vim.loop.fs_scandir(shada_dir)

if handle then
  while true do
    local name = vim.loop.fs_scandir_next(handle)
    if not name then break end
    if name:match("^main%.shada%.tmp%..+$") then
      os.remove(shada_dir .. "/" .. name)
    end
  end
end

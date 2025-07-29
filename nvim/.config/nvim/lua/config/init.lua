-- lua/core/init.lua
local M = {}

function M.setup()
  -- 按需加载配置
  require("config.options")
  require("config.keymaps")
  require("config.autocmds")
end

return M

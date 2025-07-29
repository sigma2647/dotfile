-- lua/core/init.lua
local M = {}

function M.setup()
  -- 按需加载配置
  require("options")
  require("keymaps")
  require("autocmds")
end

return M

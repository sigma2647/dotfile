-- lua/core/init.lua
local M = {}

function M.setup()
  -- 按需加载配置
  require("core.options")
  require("core.keymaps")
  require("core.autocmd")
  
end

return M

-- lua/core/init.lua
local M = {}

function M.setup()
  -- 按顺序加载核心配置
  require("core.options")
  require("core.keymaps")
  require("core.autocmd")
  
end

return M

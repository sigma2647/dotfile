-- lua/config/init.lua
local M = {}

function M.setup()
  -- 终端配置
  require("modules.terminal").setup({
    height = 15,
    position = "botright",
    mapping = "<C-\\>",
    direction = "horizontal",
    hide_numbers = true,
    buffer_name = "Terminal"
  })

  -- 文件树配置
  require("modules.filetree").setup()

  -- 输入法切换配置
  require("modules.input").setup()
end

return M

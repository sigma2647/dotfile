-- lua/core/init.lua
local M = {}

function M.setup()

  require('modules.terminal').setup({
    height = 15,
    position = 'botright',
    mapping = '<C-\\>',
    direction = 'horizontal',
    hide_numbers = true,
    buffer_name = 'Terminal'
  })

  require('modules.filetree').setup()

end

return M

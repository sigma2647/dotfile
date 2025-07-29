if vim.g.vscode then
    require("config.vscode").setup()
else
    require("config").setup()
    require("modules").setup()
end


-- %s/旧词/新词/g

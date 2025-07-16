if vim.g.vscode then
    require("core.vscode").setup()
else
    require("core").setup()
    require("config").setup()
end


-- %s/旧词/新词/g

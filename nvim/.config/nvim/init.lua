if vim.g.vscode then
    require("core.vscode").setup()
else
    require("core").setup()
    require("config").setup()
end

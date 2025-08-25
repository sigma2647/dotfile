# 获取当前 PATH 值（用户级）
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")

# 检查是否已经存在，避免重复添加
if (-not $currentPath.Contains("$HOME\Downloads\bin")) {
    $newPath = $currentPath + ";$HOME\Downloads\bin"
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
    Write-Host "已添加到用户 PATH，请重启 PowerShell 或注销/登录以生效。"
} else {
    Write-Host "路径已存在，无需重复添加。"
}

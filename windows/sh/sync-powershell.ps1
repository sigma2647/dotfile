# 定义源目录和目标目录
$sourceFile = "$HOME\dotfile\powershell\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$targetDir = Split-Path $PROFILE -Parent

# 确保目标目录存在
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

# 复制配置文件
try {
    Copy-Item -Path $sourceFile -Destination $PROFILE -Force
    Write-Host "Successfully synced PowerShell profile from $sourceFile to $PROFILE"
    
    # 重新加载配置文件
    Write-Host "Reloading PowerShell profile..."
    . $PROFILE
    Write-Host "PowerShell profile reloaded successfully"
}
catch {
    Write-Error "Error occurred while syncing PowerShell profile: $_"
} 
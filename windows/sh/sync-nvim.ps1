# 定义源目录和目标目录
$sourceDir = "$HOME\dotfile\nvim\.config\nvim"
$targetDir = "$env:LOCALAPPDATA\nvim"

# 确保目标目录存在
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

# 复制所有文件和目录
try {
    # 使用 Get-ChildItem 获取所有内容，包括隐藏文件
    Get-ChildItem -Path $sourceDir -Recurse -Force | ForEach-Object {
        $targetPath = $_.FullName.Replace($sourceDir, $targetDir)
        
        if ($_.PSIsContainer) {
            # 如果是目录，确保目标目录存在
            if (-not (Test-Path $targetPath)) {
                New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
            }
        }
        else {
            # 如果是文件，复制文件
            Copy-Item -Path $_.FullName -Destination $targetPath -Force
        }
    }
    
    Write-Host "Successfully synced nvim configuration files from $sourceDir to $targetDir"
}
catch {
    Write-Error "Error occurred while syncing files: $_"
} 
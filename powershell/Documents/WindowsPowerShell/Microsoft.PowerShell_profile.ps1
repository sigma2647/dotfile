Set-PSReadLineOption -EditMode Emacs

# Set-Alias open explorer.exe
# Set-Alias open start
Set-Alias g lazygit
Set-Alias l y
Set-Alias v nvim
Set-Alias vim nvim
Set-Alias which where.exe
Set-Alias grep  findstr

function clear { cls }
function ll { dir $args }
function ifconfig { ipconfig $args}
function type { type $args}
function open { explorer $args}

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -BellStyle None


# function goto-projects { Set-Location -Path "D:\Projects" }

# Set-Alias -Name gp -Value goto-projects

function lfcd {
    $lastDir = & lf -print-last-dir $args
    if ($lastDir -ne $null) {
        Set-Location -Path $lastDir
    }
}

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

# Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

$env:POWERSHELL_UPDATECHECK = 'Off'
Set-Item -Path Env:POWERSHELL_UPDATECHECK -Value 'Off'

$env:EDITOR = "nvim"
$env:VISUAL = "nvim"

# $env:TERM = "xterm-256color"





function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}


function goto-note {
    Set-Location -Path "$HOME\note\sigma"
}
Set-Alias -Name oo -Value goto-note

function goto-dotfile {
    Set-Location -Path "$HOME\dotfile"
}
Set-Alias -Name dot -Value goto-dotfile



function Set-Proxy {
    param (
        [string]$HostIp = "127.0.0.1",
        [int]$Port = 7897 # Clash Verge
    )
    $env:http_proxy = "http://${HostIp}:$Port"
    $env:https_proxy = "http://${HostIp}:$Port"
    Write-Host "--[ Set Network Proxy! Value: HostIp = $HostIp , Port = $Port ]--"
}
function Remove-Proxy {
    Remove-Item Env:http_proxy -ErrorAction SilentlyContinue
    Remove-Item Env:https_proxy -ErrorAction SilentlyContinue
    Write-Host "--[ Remove Network Proxy! ]--"
}

function note {
    param(
        [Parameter(Position = 0)]
        [ValidateSet('add', 'open', 'list', 'search', 'delete')]
        [string]$Command,
        
        [Parameter(Position = 1, ValueFromRemainingArguments = $true)]
        [string[]]$Arguments
    )

    $noteDir = Join-Path $HOME "note/local"
    $date = Get-Date -Format "yyyy-MM-dd"
    $noteFile = Join-Path $noteDir "$date.md"

    # Ensure note directory exists
    if (-not (Test-Path $noteDir)) {
        try {
            New-Item -ItemType Directory -Path $noteDir -Force | Out-Null
        }
        catch {
            Write-Error "Error: Failed to create directory $noteDir"
            return
        }
    }

    switch ($Command) {
        'add' {
            if ($Arguments.Count -eq 0) {
                Write-Error "Error: No content provided for note."
                return
            }
            
            $content = $Arguments -join ' '
            $timestamp = Get-Date -Format "HH:mm:ss"
            $noteContent = "[$timestamp] $content"
            
            try {
                Add-Content -Path $noteFile -Value $noteContent
                Write-Host "Note added to $noteFile"
            }
            catch {
                Write-Error "Error: Failed to write to $noteFile"
            }
        }
        
        'open' {
            if (-not (Test-Path $noteFile)) {
                try {
                    New-Item -ItemType File -Path $noteFile -Force | Out-Null
                }
                catch {
                    Write-Error "Error: Failed to create $noteFile"
                    return
                }
            }
            
            # Use the configured editor (nvim in your case)
            $editor = $env:EDITOR
            if ($editor -match 'nvim|vim') {
                & $editor -c "cd $noteDir" -c "lcd $noteDir" $noteFile
            }
            else {
                Push-Location $noteDir
                & $editor $noteFile
                Pop-Location
            }
        }
        
        'list' {
            if (Test-Path $noteDir) {
                $files = Get-ChildItem -Path $noteDir -Filter "*.md"
                if ($files.Count -gt 0) {
                    Write-Host "Available notes in ${noteDir}:"
                    $files | Sort-Object LastWriteTime -Descending | ForEach-Object {
                        Write-Host ("{0} - {1} - {2:N2} KB" -f $_.LastWriteTime.ToString("yyyy-MM-dd HH:mm"), $_.Name, ($_.Length/1KB))
                    }
                }
                else {
                    Write-Host "No notes found in $noteDir"
                }
            }
            else {
                Write-Host "No notes found in $noteDir"
            }
        }
        
        'search' {
            if ($Arguments.Count -eq 0) {
                Write-Error "Error: No search term provided."
                return
            }
            
            $searchTerm = $Arguments[0]
            Write-Host "Searching for `"$searchTerm`" in notes:"
            
            $found = $false
            Get-ChildItem -Path $noteDir -Filter "*.md" | ForEach-Object {
                if (Select-String -Path $_.FullName -Pattern $searchTerm -Quiet) {
                    Write-Host $_.Name
                    $found = $true
                }
            }
            
            if (-not $found) {
                Write-Host "No matches found."
            }
            else {
                Write-Host "Found matches in above files."
            }
        }
        
        'delete' {
            $targetFile = $noteFile
            if ($Arguments.Count -gt 0 -and $Arguments[0] -match '^\d{4}-\d{2}-\d{2}$') {
                $targetFile = Join-Path $noteDir "$($Arguments[0]).md"
            }
            
            if (Test-Path $targetFile) {
                $confirm = Read-Host "Are you sure you want to delete $targetFile? (y/n)"
                if ($confirm -match '^[yY]') {
                    try {
                        Remove-Item $targetFile -Force
                        Write-Host "Note deleted: $targetFile"
                    }
                    catch {
                        Write-Error "Error: Failed to delete $targetFile"
                    }
                }
                else {
                    Write-Host "Deletion cancelled."
                }
            }
            else {
                Write-Error "Error: Note file $targetFile does not exist."
            }
        }
        
        default {
            Write-Host @"
Usage: 
  note add <content>   - Add a new note with timestamp
  note open            - Open today's note in editor
  note list            - List all available notes
  note search <term>   - Search notes for specific term
  note delete [date]   - Delete today's note or specified date (YYYY-MM-DD)
"@
        }
    }
}



function ts2date {
    param (
        [Parameter(Mandatory = $true)]
        [long]$Timestamp
    )

    # 判断时间戳的长度
    if ($Timestamp.ToString().Length -eq 10) {
        # Unix 时间戳（秒）
        $datetime = [DateTimeOffset]::FromUnixTimeSeconds($Timestamp).DateTime
    } elseif ($Timestamp.ToString().Length -eq 13) {
        # 毫秒级时间戳
        $datetime = [DateTimeOffset]::FromUnixTimeMilliseconds($Timestamp).DateTime
    } else {
        Write-Error "无法识别的时间戳长度，请输入10位（Unix时间戳）或13位（毫秒级时间戳）的时间戳。"
        return
    }

    return $datetime
}



function case {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Number
    )

    # 1. 根目录，按需修改
    $root = 'X:\Cases\2025'

    # 2. 去掉用户可能输入的前导 0（如 007 → 7）
    $Number = $Number.TrimStart('0')
    if ([string]::IsNullOrEmpty($Number)) { $Number = '0' }

    # 3. 构造通配符
    $pattern = "2025-$Number"

    # 4. 查找
    $matches = Get-ChildItem -Path $root -Directory -Filter $pattern

    switch ($matches.Count) {
        0 { Write-Warning "未找到目录：$root\$pattern" }
        1 { Set-Location $matches[0].FullName }
        default {
            Write-Host "找到多个匹配目录，请选择："
            $matches | Select-Object FullName | Out-Host
        }
    }
}


# region zoxide
if (Get-Command -Name zoxide -ErrorAction SilentlyContinue) {
    # 初始化 zoxide
    Invoke-Expression (& {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
        (zoxide init --hook $hook powershell) -join "`n"
    })

    # 把 cd 映射成 z（只在交互式会话里做，避免脚本里出问题）
    if ($Host.Name -match 'ConsoleHost|Visual Studio Code Host') {
        Set-Alias -Name cd -Value z -Option AllScope -Scope Global -Force
    }
} else {
    Write-Host '[zoxide] 未检测到 zoxide，请先安装并加入 PATH。' -ForegroundColor DarkYellow
}
# endregion
#


## enable UTF-8

$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

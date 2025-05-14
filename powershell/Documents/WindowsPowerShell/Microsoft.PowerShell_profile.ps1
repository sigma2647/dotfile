Set-PSReadLineOption -EditMode Emacs

Set-Alias open explorer.exe
# Set-Alias open start
Set-Alias g lazygit
Set-Alias l y
Set-Alias v nvim
Set-Alias vim nvim
Set-Alias which where.exe
Set-Alias grep  findstr


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



# Network Proxy Switcher
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




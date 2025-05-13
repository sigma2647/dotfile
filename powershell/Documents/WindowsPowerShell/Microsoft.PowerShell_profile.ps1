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




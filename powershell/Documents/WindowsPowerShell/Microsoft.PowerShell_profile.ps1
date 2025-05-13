Set-PSReadLineOption -EditMode Emacs

Set-Alias -Name open -Value explorer.exe

Set-Alias -Name g -Value lazygit

Set-Alias -Name l -Value y

Set-Alias -Name v -Value nvim
Set-Alias -Name vim -Value nvim


Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -BellStyle None

function goto-note { Set-Location -Path "$HOME\note\sigma" }
function goto-dotfile { Set-Location -Path "$HOME\dotfile" }
# function goto-projects { Set-Location -Path "D:\Projects" }

Set-Alias -Name oo -Value goto-note
Set-Alias -Name dot -Value goto-dotfile
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


function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}



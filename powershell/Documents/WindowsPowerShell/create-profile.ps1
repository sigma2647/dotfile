# Create empty $PROFILE file if it doesn't exist
# This script creates an empty PowerShell profile file at the location specified by $PROFILE

# Display current profile path
Write-Host "Current PowerShell profile path: $PROFILE" -ForegroundColor Green

# Check if profile file exists
if (Test-Path $PROFILE) {
    Write-Host "Profile file already exists, skipping creation" -ForegroundColor Yellow
    exit 0
}

# Create directory if it doesn't exist
$profileDir = Split-Path $PROFILE -Parent
if (!(Test-Path $profileDir)) {
    Write-Host "Creating profile directory: $profileDir" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# Create empty profile file
Write-Host "Creating empty profile file: $PROFILE" -ForegroundColor Green
New-Item -ItemType File -Path $PROFILE -Force | Out-Null
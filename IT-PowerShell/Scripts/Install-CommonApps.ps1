# Install-CommonApps.ps1
$apps = @(
    "Google.Chrome",
    "LibreOffice.LibreOffice",
    "Microsoft.PowerToys",
    "Adobe.Acrobat.Reader.64-bit"
)

foreach ($app in $apps) {
    Write-Host "Installing $app..." -ForegroundColor Cyan
    winget install --id $app --silent --accept-source-agreements --accept-package-agreements
}

Write-Host "✅ All applications installed successfully!" -ForegroundColor Green
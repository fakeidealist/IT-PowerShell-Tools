# Install-CommonApps.ps1
# Safety: Installs software using Winget. Requires internet.

$apps = @("Google.Chrome", "LibreOffice.LibreOffice", "Microsoft.PowerToys")

try {
    foreach ($app in $apps) {
        Write-Host "Installing $app..." -ForegroundColor Cyan
        winget install --id $app --silent --accept-source-agreements --accept-package-agreements
    }
    Write-Host "✅ All applications installed successfully!" -ForegroundColor Green
}
catch {
    Write-Host "❌ Error during installation: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Some applications may not have installed correctly." -ForegroundColor Yellow
}
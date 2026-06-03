# Start-WindowsUpdate.ps1
Write-Host "Checking for Windows Updates..." -ForegroundColor Cyan

Install-Module PSWindowsUpdate -Force -Scope CurrentUser -ErrorAction SilentlyContinue
Import-Module PSWindowsUpdate

$updates = Get-WUList

if ($updates.Count -gt 0) {
    Write-Host "$($updates.Count) updates found. Installing..." -ForegroundColor Yellow
    Install-WUUpdate -AcceptAll -AutoReboot:$false
    Write-Host "✅ Windows Updates installed successfully!" -ForegroundColor Green
} else {
    Write-Host "✅ System is up to date." -ForegroundColor Green
}
# Start-DiskCleanup.ps1
Write-Host "Running Disk Cleanup..." -ForegroundColor Yellow
cleanmgr /sagerun:1

Write-Host "Clearing temporary files..." -ForegroundColor Yellow
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "✅ Disk cleanup completed!" -ForegroundColor Green
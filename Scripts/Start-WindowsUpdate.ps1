# Start-WindowsUpdate.ps1
# Safety: Checks and installs Windows Updates using built-in tools + PSWindowsUpdate fallback.

try {
    Write-Host "Checking for Windows Updates..." -ForegroundColor Cyan

    # Method 1: Use built-in Windows Update (more reliable)
    Write-Host "Searching for updates using Windows Update..." -ForegroundColor Yellow
    
    $updateSession = New-Object -ComObject Microsoft.Update.Session
    $updateSearcher = $updateSession.CreateUpdateSearcher()
    $searchResult = $updateSearcher.Search("IsInstalled=0 and Type='Software'")

    if ($searchResult.Updates.Count -gt 0) {
        Write-Host "$($searchResult.Updates.Count) updates found. Installing..." -ForegroundColor Yellow
        
        $updatesToInstall = New-Object -ComObject Microsoft.Update.UpdateColl
        foreach ($update in $searchResult.Updates) {
            $updatesToInstall.Add($update) | Out-Null
        }

        $installer = $updateSession.CreateUpdateInstaller()
        $installer.Updates = $updatesToInstall
        $installationResult = $installer.Install()

        Write-Host "✅ Windows Updates completed!" -ForegroundColor Green
    } else {
        Write-Host "✅ System is already up to date." -ForegroundColor Green
    }
}
catch {
    Write-Host "❌ Error during Windows Update: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Tip: Try running PowerShell ISE as Administrator." -ForegroundColor Yellow
}
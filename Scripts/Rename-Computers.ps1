# Rename-Computers.ps1
# Safety: Renames the local computer. Requires restart. Use with caution.

try {
    $currentName = hostname
    $newName = Read-Host "Enter new computer name (current: $currentName)"

    if ([string]::IsNullOrWhiteSpace($newName)) {
        throw "Computer name cannot be empty."
    }

    if ($newName -eq $currentName) {
        Write-Host "✅ Computer name is already set to '$newName'. No changes needed." -ForegroundColor Yellow
        return
    }

    Write-Host "Renaming computer from '$currentName' to '$newName'..." -ForegroundColor Yellow

    Rename-Computer -NewName $newName -Force -Restart -ErrorAction Stop

    Write-Host "✅ Computer renamed successfully! Restarting..." -ForegroundColor Green
}
catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Failed to rename computer. Make sure you run PowerShell as Administrator." -ForegroundColor Yellow
}
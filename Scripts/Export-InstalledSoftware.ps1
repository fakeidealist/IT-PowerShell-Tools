# Export-InstalledSoftware.ps1
# Safety: Read-only script. Exports list of installed software.

$reportFolder = "C:\IT-PowerShell\Reports"

try {
    # Create Reports folder if it doesn't exist
    if (!(Test-Path $reportFolder)) {
        New-Item -Path $reportFolder -ItemType Directory -Force | Out-Null
    }

    $reportPath = "$reportFolder\Installed-Software-$(Get-Date -Format 'yyyy-MM-dd_HH-mm').csv"

    # Get installed software and export
    $software = Get-WmiObject -Class Win32_Product | 
                Select-Object Name, Version, Vendor, InstallDate

    $software | Export-Csv $reportPath -NoTypeInformation -ErrorAction Stop

    # Verify file was created
    if (Test-Path $reportPath) {
        Write-Host "✅ Installed software list exported successfully!" -ForegroundColor Green
        Write-Host "Location: $reportPath" -ForegroundColor Cyan
    } else {
        throw "Failed to create export file"
    }
}
catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Failed to export installed software list." -ForegroundColor Yellow
}
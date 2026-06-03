# Export-InstalledSoftware.ps1
$software = Get-WmiObject -Class Win32_Product | Select Name, Version, Vendor
$software | Export-Csv "$env:USERPROFILE\Desktop\Installed-Software.csv" -NoTypeInformation
Write-Host "✅ Software list exported to Desktop!" -ForegroundColor Green
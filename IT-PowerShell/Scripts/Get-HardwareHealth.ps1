# Get-HardwareHealth.ps1
Write-Host "=== Hardware Health Report ===" -ForegroundColor Cyan

# Check Disk Health
Get-PhysicalDisk | Select FriendlyName, OperationalStatus, HealthStatus, Size | Format-Table

# Check Temperature (if supported)
Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace root/wmi | 
    Select @{Name="Temperature(C)";Expression={($_.CurrentTemperature/10)-273.15}} | Format-Table

# Check for Driver Errors
Get-WmiObject Win32_PNPEntity | Where-Object {$_.ConfigManagerErrorCode -ne 0} | 
    Select Name, ConfigManagerErrorCode | Format-Table

Write-Host "Report completed!" -ForegroundColor Green
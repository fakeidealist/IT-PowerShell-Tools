# Get-SystemInventory.ps1
# Safety: Read-only script. No changes made to the system.

$reportFolder = "C:\IT-PowerShell\Reports"

try {
    # Create Reports folder if it doesn't exist
    if (!(Test-Path $reportFolder)) {
        New-Item -Path $reportFolder -ItemType Directory -Force | Out-Null
    }

    $reportPath = "$reportFolder\System-Inventory-$(Get-Date -Format 'yyyy-MM-dd_HH-mm').txt"

    $info = @"
========================================
System Inventory Report - $(Get-Date)
========================================
Hostname          : $(hostname)
Logged-in User    : $env:USERNAME
OS Version        : $((Get-CimInstance Win32_OperatingSystem).Caption)
RAM (GB)          : $((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB -as [int])
Free Space (C:)   : $((Get-PSDrive C).Free / 1GB -as [int]) GB
IP Address        : $((Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -like "*Ethernet*" -or $_.InterfaceAlias -like "*Wi-Fi*"}).IPAddress)
Last Boot Time    : $((Get-CimInstance Win32_OperatingSystem).LastBootUpTime)
========================================
"@

    $info | Out-File $reportPath -Encoding UTF8 -ErrorAction Stop

    # Verify file was created
    if (Test-Path $reportPath) {
        Write-Host "✅ System inventory report saved successfully!" -ForegroundColor Green
        Write-Host "Location: $reportPath" -ForegroundColor Cyan
    } else {
        throw "Failed to create report file"
    }
}
catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Failed to generate system inventory report." -ForegroundColor Yellow
}
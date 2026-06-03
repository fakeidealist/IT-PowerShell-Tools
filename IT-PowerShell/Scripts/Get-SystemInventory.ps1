# Get-SystemInventory.ps1
$reportPath = "$env:USERPROFILE\Desktop\System-Inventory-$(Get-Date -Format 'yyyy-MM-dd').txt"

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
$info | Out-File $reportPath
Write-Host "✅ System inventory saved to Desktop!" -ForegroundColor Green
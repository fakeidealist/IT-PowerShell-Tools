# PowerShell Automation for IT Support & Desktop Management

A collection of practical PowerShell scripts designed to automate common tasks for Desktop Support, Deskside Technicians, and IT Administrators.

## 🎯 Project Overview

This project demonstrates real-world PowerShell automation skills used in enterprise IT environments. The scripts help improve efficiency in system maintenance, software deployment, user management, and troubleshooting.

## 📋 Scripts Included

| Script | Description |
|--------|-----------|
| `New-ITUser.ps1` | Automated user creation and admin rights assignment |
| `Manage-LocalUser.ps1` | Create, modify, and manage local user accounts |
| `Install-CommonApps.ps1` | Silently installs essential applications using Winget |
| `Start-WindowsUpdate.ps1` | Checks and installs Windows Updates automatically |
| `Get-SystemInventory.ps1` | Generates complete system hardware and software report |
| `Export-InstalledSoftware.ps1` | Exports list of installed software to CSV |
| `Start-DiskCleanup.ps1` | Performs automated disk cleanup and temp file removal |
| `Get-HardwareHealth.ps1` | Checks disk health, temperature, and driver errors |
| `Get-RecentErrors.ps1` | Analyzes recent Critical & Error events in Event Logs |
| `Rename-Computers.ps1` | Bulk computer renaming tool |

## Folder Structure

C:\IT-PowerShell
├── Scripts/              # All .ps1 scripts
├── Reports/              # Generated reports & CSVs
└── Logs/                 # Error & event logs

## 🚀 Usage Examples

```powershell
# 1. Create a new IT user
.\New-ITUser.ps1

# 2. Install common applications
.\Install-CommonApps.ps1

# 3. Generate system inventory report
.\Get-SystemInventory.ps1

# 4. Run disk cleanup
.\Start-DiskCleanup.ps1

# 5. Check for Windows Updates
.\Start-WindowsUpdate.ps1

# 6. View recent system errors
.\Get-RecentErrors.ps1
```

## 🎯 Skills Demonstrated

PowerShell scripting & automation
Error handling and logging
System administration
Hardware & software inventory
Windows Update management
IT process automation

## :chart_with_upwards_trend: Future Enhancementst

Active Directory user automation
Bulk device management
Configuration drift detection
Automated reporting dashboard

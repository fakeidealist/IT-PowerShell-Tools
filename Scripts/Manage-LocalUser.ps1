# Manage-LocalUser.ps1
# Safety: Manages local user accounts. Use with caution.

param([string]$Action = "List")

$reportFolder = "C:\IT-PowerShell\Reports"

try {
    if ($Action -eq "Create") {
        $username = Read-Host "Enter new username"
        $password = Read-Host "Enter password" -AsSecureString
        $fullName = Read-Host "Enter full name (optional)" 

        New-LocalUser -Name $username -Password $password -FullName $fullName -Description "Created via PowerShell" -ErrorAction Stop
        Add-LocalGroupMember -Group "Administrators" -Member $username -ErrorAction Stop

        Write-Host "✅ User '$username' created and added to Administrators group successfully!" -ForegroundColor Green
    }
    else {
        # List users
        Write-Host "=== Local Users ===" -ForegroundColor Cyan
        Get-LocalUser | Select Name, Enabled, LastLogon | Format-Table
    }
}
catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Failed to manage local user." -ForegroundColor Yellow
}
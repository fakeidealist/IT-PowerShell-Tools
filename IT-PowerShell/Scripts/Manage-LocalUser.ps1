# Manage-LocalUser.ps1
param([string]$Action = "List")

if ($Action -eq "Create") {
    $username = Read-Host "Enter new username"
    $password = Read-Host "Enter password" -AsSecureString
    New-LocalUser -Name $username -Password $password -Description "IT Support User" -AccountNeverExpires
    Add-LocalGroupMember -Group "Administrators" -Member $username
    Write-Host "✅ User $username created and added to Administrators" -ForegroundColor Green
}
else {
    Get-LocalUser | Select Name, Enabled, LastLogon | Format-Table
}
# New-ITUser.ps1
# Safety: Creates a new local user and adds to Administrators group.

try {
    $firstname = Read-Host "Enter First Name"
    $lastname  = Read-Host "Enter Last Name"
    $username  = "$firstname.$lastname".ToLower()

    $password = Read-Host "Enter temporary password" -AsSecureString

    New-LocalUser -Name $username -Password $password -FullName "$firstname $lastname" `
                  -Description "Onboarded via PowerShell" -ErrorAction Stop
    
    Add-LocalGroupMember -Group "Administrators" -Member $username -ErrorAction Stop

    Write-Host "✅ User '$username' created successfully!" -ForegroundColor Green
    Write-Host "Temporary password has been set." -ForegroundColor Yellow
}
catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Failed to create new user." -ForegroundColor Yellow
}
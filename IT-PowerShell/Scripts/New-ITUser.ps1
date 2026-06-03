# New-ITUser.ps1
$firstname = Read-Host "Enter First Name"
$lastname  = Read-Host "Enter Last Name"
$username  = "$firstname.$lastname".ToLower()

$password = Read-Host "Enter temporary password" -AsSecureString

New-LocalUser -Name $username -Password $password -FullName "$firstname $lastname" -Description "Onboarded via PowerShell"
Add-LocalGroupMember -Group "Administrators" -Member $username

Write-Host "✅ User $username created successfully!" -ForegroundColor Green
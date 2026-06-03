# Rename-Computers.ps1
$computers = @(
    "PC-001", "PC-002", "PC-003"
)

foreach ($oldName in $computers) {
    $newName = Read-Host "Enter new name for $oldName"
    Rename-Computer -ComputerName $oldName -NewName $newName -DomainCredential (Get-Credential) -Force -Restart
    Write-Host "$oldName renamed to $newName and restarted." -ForegroundColor Green
}
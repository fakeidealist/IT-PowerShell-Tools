# Get-RecentErrors.ps1
$hours = 24

Write-Host "Recent Critical & Error Events (Last $hours hours):" -ForegroundColor Red

Get-WinEvent -FilterHashtable @{
    LogName = 'System','Application'
    Level   = 1,2  # Critical and Error
    StartTime = (Get-Date).AddHours(-$hours)
} -ErrorAction SilentlyContinue | 
Select TimeCreated, LevelDisplayName, LogName, Message | 
Select -First 20 | Format-List
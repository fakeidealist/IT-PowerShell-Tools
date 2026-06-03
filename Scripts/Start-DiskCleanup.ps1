# Get-RecentErrors.ps1
# Safety: Read-only script. Analyzes recent error logs.

$logFolder = "C:\IT-PowerShell\Logs"

try {
    if (!(Test-Path $logFolder)) {
        New-Item -Path $logFolder -ItemType Directory -Force | Out-Null
    }

    $reportPath = "$logFolder\Recent-Errors-$(Get-Date -Format 'yyyy-MM-dd_HH-mm').txt"

    $hours = 24

    $errors = Get-WinEvent -FilterHashtable @{
        LogName = 'System','Application'
        Level   = 1,2  # Critical (1) and Error (2)
        StartTime = (Get-Date).AddHours(-$hours)
    } -ErrorAction SilentlyContinue | 
    Select-Object TimeCreated, LevelDisplayName, LogName, Message | 
    Select-Object -First 30

    if ($errors.Count -gt 0) {
        "Recent Critical & Error Events (Last $hours hours) - $(Get-Date)" | Out-File $reportPath
        "=======================================================================" | Out-File $reportPath -Append
        $errors | Out-File $reportPath -Append
    } else {
        "No critical or error events found in the last $hours hours." | Out-File $reportPath
    }

    Write-Host "✅ Recent error log exported successfully!" -ForegroundColor Green
    Write-Host "Location: $reportPath" -ForegroundColor Cyan
}
catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Failed to export recent error logs." -ForegroundColor Yellow
}
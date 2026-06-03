# Get-HardwareHealth.ps1
# Safety: Read-only script. Collects hardware information.

$reportFolder = "C:\IT-PowerShell\Reports"

try {
    if (!(Test-Path $reportFolder)) {
        New-Item -Path $reportFolder -ItemType Directory -Force | Out-Null
    }

    $reportPath = "$reportFolder\Hardware-Health-$(Get-Date -Format 'yyyy-MM-dd_HH-mm').csv"

    Write-Host "Collecting hardware information..." -ForegroundColor Cyan

    # Collect various hardware data
    $hardwareReport = @()

    # CPU Information
    $cpu = Get-CimInstance Win32_Processor
    $hardwareReport += [PSCustomObject]@{
        Component     = "CPU"
        Name          = $cpu.Name
        Cores         = $cpu.NumberOfCores
        Threads       = $cpu.NumberOfLogicalProcessors
        Status        = "OK"
    }

    # RAM Information
    $ram = Get-CimInstance Win32_ComputerSystem
    $hardwareReport += [PSCustomObject]@{
        Component     = "RAM"
        Name          = "$([math]::round($ram.TotalPhysicalMemory/1GB)) GB"
        Cores         = ""
        Threads       = ""
        Status        = "OK"
    }

    # Disk Information
    Get-PhysicalDisk | ForEach-Object {
        $hardwareReport += [PSCustomObject]@{
            Component     = "Disk"
            Name          = $_.FriendlyName
            Cores         = "$([math]::round($_.Size/1GB)) GB"
            Threads       = $_.HealthStatus
            Status        = $_.OperationalStatus
        }
    }

    # Graphics Card
    $gpu = Get-CimInstance Win32_VideoController | Where-Object {$_.Name -notlike "*Microsoft*"}
    foreach ($card in $gpu) {
        $hardwareReport += [PSCustomObject]@{
            Component     = "GPU"
            Name          = $card.Name
            Cores         = ""
            Threads       = ""
            Status        = $card.Status
        }
    }

    # Network Adapters
    Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | ForEach-Object {
        $hardwareReport += [PSCustomObject]@{
            Component     = "Network Adapter"
            Name          = $_.Name
            Cores         = $_.LinkSpeed
            Threads       = ""
            Status        = $_.Status
        }
    }

    # Export to CSV
    $hardwareReport | Export-Csv $reportPath -NoTypeInformation

    Write-Host "✅ Hardware health report generated successfully!" -ForegroundColor Green
    Write-Host "Location: $reportPath" -ForegroundColor Cyan
}
catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Failed to generate hardware health report." -ForegroundColor Yellow
}
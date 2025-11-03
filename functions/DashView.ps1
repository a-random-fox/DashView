<#
.SYNOPSIS
  Displays an overview of key components/system inforamtion.

.DESCRIPTION
  Provides the user with information regarding the system, network, and DNS.

.EXAMPLE
  Show-DashView
  Displays your system summary with animated output.

.NOTES
  Author: Ryan Schubert
  Module: DashView
#>

function Show-DashView {
    Write-DashType "System Overview:" 50

    $sysinfo = Get-ComputerInfo | Select-Object OSLocalDateTime, CsManufacturer, CsModel, CsProcessors, BiosManufacturer, BiosName, OsName, CsBootupState, CsDomain, CsDomainRole, OSLastBootUpTime
    $sysinfo | Format-List

    Get-Volume | Where-Object DriveLetter | ForEach-Object {
        Write-Host "Drive: $($_.DriveLetter)" -ForegroundColor Green
        Write-Host "$([math]::Round($_.SizeRemaining / 1GB,2))GB free / $([math]::Round($_.Size / 1GB,2))GB total"
    }

    Get-Runspace
    Get-NetAdapter -IncludeHidden | Where-Object { $_.Status -notlike "Not Present" } | Sort-Object Name | Format-Table -AutoSize
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 | Format-Table -AutoSize
}
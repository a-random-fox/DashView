<#
.SYNOPSIS
 Runs a comprehenzie update.

.DESCRIPTION
  Updates Windows, installed/compatible applications, and loaded modules.

.EXAMPLE
 Install-DashUpdates

.NOTES
  Author: Ryan Schubert
  Module: DashView
#>


function Install-DashUpdate {
    $updates = winget upgrade

    if ($updates -match "No installed package found matching input criteria.") {
        Write-DashType "App packages showing up-to-date." 50
    } else {
        $updates
        try {
            winget upgrade --all --silent --accept-package-agreements --accept-source-agreements --uninstall-previous --force | Out-Null
            Write-DashType "Application(s) updated via Winget." 50
        } catch {
            Write-DashType "Failed to update application(s) via Winget." 50
        }
    }

    Install-Module -Name PSWindowsUpdate -Force | Out-Null
    Import-Module PSWindowsUpdate -Force | Out-Null

    $wupdates = Get-WindowsUpdate

    if ($null -eq $wupdates) {
        Write-DashType "Windows showing up-to-date." 50
    } else {
        try {
            Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot | Out-Null
            Write-DashType "Windows updated." 50
        } catch {
            Write-DashType "Failed to update Windows." 50
        }
    }

    Install-Script -Name Check-ModuleUpdate -Force | Out-Null

    $modupdate = Check-ModuleUpdate | Where-Object { $_.Update -eq "True" }

    if ($null -eq $modupdate -or $modupdate.Count -eq 0) {
        Write-DashType "Modules showing up-to-date." 50
    } else {
        foreach ($module in $modupdate) {
            try {
                Update-Module -Name $module.Name -Force -ErrorAction Stop
       	        Write-DashType "Updated module: $($module.Name)" 50
       	    } catch {
                Write-DashType "Failed to update module: $($module.Name)" 50
            }
    	}
    }
}
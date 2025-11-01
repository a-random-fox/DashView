<#
.SYNOPSIS
  Executes a comprehensive repair and update to your console.

.DESCRIPTION
  Unsures your applications and PowerShell modules are up-to-date, updates them if they are not, checks for and if necessary downloads and installs Windows updates (if necessary). Runs a comprehensize repair that flushes your DNS cache, renews your IP configuration, resets the Winsock catalogue to a clean state, and checks and repairs (if necessary) your mounted drives, system files, and Windows Image.  
I
.EXAMPLE
  Start-DashRepair

.NOTES
  Author: Ryan Schubert
  Module: DashView
#>

function Start-DashRepair {
    $updates = winget upgrade

    if ($updates -match "No installed package found matching input criteria.") {
        Write-DashType "App packages showing up-to-date." 50
    } else {
        $updates
        try {
            winget upgrade --all --silent --accept-package-agreements --accept-source-agreements --uninstall-previous --force
            Write-DashType "Application(s) updated via Winget." 50
        } catch {
            Write-DashType "Failed to update application(s) via Winget." 50
        }
    }

    Write-Host " "

    $wupdates = Get-WindowsUpdate

    if ($null -eq $wupdates) {
        Write-DashType "Windows showing up-to-date." 50
    } else {
        try {
            Download-WindowsUpdate -AcceptAll
            Install-WindowsUpdate -AcceptAll
            Write-DashType "Windows updated." 50
        } catch {
            Write-DashType "Failed to update Windows." 50
        }
    }

    Write-Host " "

    ipconfig /release | Out-Null
    Write-DashType "Released IP configuration." 50

    Write-Host " "

    ipconfig /flushdns | Out-Null
    Write-DashType "Flushed DNS cache." 50

    Write-Host " "

    ipconfig /renew | Out-Null
    Write-DashType "Renewed IP configuration." 50

    Write-Host " "

    netsh winsock reset | Out-Null
    Write-DashType "Winsock Catalog reset to a clean state." 50

    Write-Host " "

    Get-Volume | Where-Object DriveLetter | ForEach-Object {
        $drive = $_.DriveLetter
        try {
            $scanResult = Repair-Volume -DriveLetter $drive -Scan
            if ($scanResult -match "NoErrorsFound") {
                Write-DashType "No errors detected on drive $drive." 50
            } else {
	    	try { 
                    Repair-Volume -DriveLetter $drive -SpotFix | Out-Null
                    Write-DashType "Drive $drive repaired successfully." 50
	        } catch {
                    Write-DashType "Failed to repair $drive Drive." 50
                }
            }
        } catch {
	    Write-DashType "Unable to scan $drive Drive." 50
        }
    }
   
    Write-Host " "

    sfc /scannow

    dism /online /cleanup-image /restorehealth
}

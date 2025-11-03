<#
.SYNOPSIS
  Executes a comprehensive repair and update to your console.

.DESCRIPTION
  Ensures your applications and PowerShell modules are up-to-date, updates them if necessary, checks for Windows updates,
  and performs a comprehensive repair that flushes your DNS cache, renews your IP configuration, resets the Winsock
  catalog, and repairs drives, system files, and Windows images.

.EXAMPLE
  Start-DashRepair

.NOTES
  Author: Ryan Schubert
  Module: DashView
#>

function Start-DashRepair {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param()

    if ($PSCmdlet.ShouldProcess("System", "Perform repair and update")) {

        try {
            # --- App Updates ---
            $updates = winget upgrade
            if ($updates -match "No installed package found matching input criteria.") {
                Write-DashType "App packages are up-to-date." 50
            } else {
                $updates
                try {
                    winget upgrade --all --silent --accept-package-agreements --accept-source-agreements --uninstall-previous --force
                    Write-DashType "Application(s) updated via Winget." 50
                } catch {
                    Write-DashType "Failed to update application(s) via Winget." 50
                }
            }

            Write-Verbose "Checking Windows updates..."
            $wupdates = Get-WindowsUpdate
            if ($null -eq $wupdates) {
                Write-DashType "Windows is up-to-date." 50
            } else {
                try {
                    Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot
                    Write-DashType "Windows updated successfully." 50
                } catch {
                    Write-DashType "Failed to update Windows." 50
                }
            }

            # --- Network Repairs ---
            Write-Verbose "Performing network repairs..."
            ipconfig /release | Out-Null
            Write-DashType "Released IP configuration." 50

            ipconfig /flushdns | Out-Null
            Write-DashType "Flushed DNS cache." 50

            ipconfig /renew | Out-Null
            Write-DashType "Renewed IP configuration." 50

            netsh winsock reset | Out-Null
            Write-DashType "Winsock Catalog reset to a clean state." 50

            # --- Drive Checks ---
            Write-Verbose "Scanning and repairing drives..."
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
                            Write-DashType "Failed to repair drive $drive." 50
                        }
                    }
                } catch {
                    Write-DashType "Unable to scan drive $drive." 50
                }
            }

            # --- System File and Image Repairs ---
            Write-Verbose "Running SFC and DISM repairs..."
            sfc /scannow | Out-Null
            dism /online /cleanup-image /restorehealth | Out-Null

            Write-DashType "System integrity repairs completed." 50
        } catch {
            Write-DashType "An error occurred during the repair process: $_" 50
        }
    }
}

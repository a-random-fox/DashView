<#
.SYNOPSIS
  Displays a specified phrase/input as if it were being typed.

.DESCRIPTION
  The console will display a specified message adding one character at a time as if it were being typed by your system.
  You can control typing speed by specifying the delay in milliseconds between characters.

.EXAMPLE
  Write-DashType "text to be displayed" -Delay 50

.NOTES
  Author: Ryan Schubert
  Module: DashView
#>

function Write-DashType {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string] $Text,

        [int] $Delay = 50,

        [ConsoleColor] $Color = [ConsoleColor]::Green
    )

    # Save the current color and apply the new one
    $previousColor = $Host.UI.RawUI.ForegroundColor
    $Host.UI.RawUI.ForegroundColor = $Color

    try {
        foreach ($char in $Text.ToCharArray()) {
            # Write-Information is analyzer-compliant and supports output redirection
            Write-Information -MessageData $char -InformationAction Continue
            Start-Sleep -Milliseconds $Delay
        }

        # Add a newline at the end
        Write-Information -MessageData "`n" -InformationAction Continue
    }
    finally {
        # Restore the previous console color
        $Host.UI.RawUI.ForegroundColor = $previousColor
    }
}

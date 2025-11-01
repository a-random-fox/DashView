<#
.SYNOPSIS
  Displays a specified phrase/input as if it were being typed.

.DESCRIPTION
  The console will display a specified message adding one character at a time as if it were being typed by your system. You set the system's typing speed by specifying the milliseconds at the end of the command. 50 is the suggested value.

.EXAMPLE
  Write-DashType "<input>" ## <millisecond delay between characters>

    How your command should look:
  	Write-DashType "text to be displayed" 50

.NOTES
  Author: Ryan Schubert
  Module: DashView
#>


function Write-DashType {
    param (
        [string]$text,
        [int]$delay = 50,
        [string]$color = "Green"
    )
    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline $char -ForegroundColor $color
        Start-Sleep -Milliseconds $delay
    }
    Write-Host ""
}

<#
.SYNOPSIS
  Changes your console font to Terminus.

.DESCRIPTION
  Downloads a TTF for the font "Terminus" from the module directly (does NOT pull from a third-party/the internet), installs the font so it then usable, and sets Terminus as your console font.

.EXAMPLE
  Install-DashFont

.NOTES
  Author: Ryan Schubert
  Module: DashView
#>

function Install-DashFont {
    param(
        [string]$fontFile = "$PSScriptRoot\..\assets\TerminusTTFWindows-4.49.3.ttf",
        [string]$consoleFontName = "Terminus (TTF) for Windows"
    )

    $destination = "$env:windir\Fonts\$([System.IO.Path]::GetFileName($fontFile))"
    if (-not (Test-Path $destination)) {
        Copy-Item -Path $fontFile -Destination $destination -Force
        $shellApp = New-Object -ComObject Shell.Application
        $shellApp.Namespace(0x14).ParseName($destination).InvokeVerb("Install")
    }

    Set-ItemProperty -Path "HKCU:\Console" -Name FaceName -Value $consoleFontName
}

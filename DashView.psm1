# Dashview.psm1
. $PSScriptRoot/functions/DashType.ps1
. $PSScriptRoot/functions/DashFont.ps1
. $PSScriptRoot/functions/DashView.ps1
. $PSScriptRoot/functions/DashRepair.ps1
. $PSScriptRoot/functions/DashUpdates.ps1

Export-ModuleMember -Function @(
    'Show-DashView',
    'Write-DashType',
    'Install-DashFont',
    'Start-DashRepair',
    'Install-DashUpdates'
)

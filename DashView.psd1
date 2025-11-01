@{
    RootModule = 'DashView.psm1'
    ModuleVersion = '1.0.0'
    GUID = 'caba7690-5bd8-44c9-9c04-d3512325bd0b'
    Author = 'Ryan Schubert'
    Description = 'DashView: A PowerShell dashboard that displays a system summary with animated typing and font customization, plus tools for a specialized system+network repair and a cumulative Windows+application+module update.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @(
        'Write-DashType',
        'Install-DashFont',
        'Show-DashView',
        'Start-DashRepair',
        'Install-DashUpdates'
    )
    FileList = @(
        'DashView.psm1',
        'functions/DashType.ps1',
        'functions/DashFont.ps1',
        'functions/DashView.ps1',
        'functions/DashRepair.ps1',
        'functions/DashUpdates.ps1',
        'assets/TerminusTTFWindows-4.49.3.ttf'
    )
    PrivateData = @{}
}

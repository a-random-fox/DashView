@{
    RootModule        = 'DashView.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'caba7690-5bd8-44c9-9c04-d3512325bd0b'
    Author            = 'Ryan Schubert'
    CompanyName       = 'a-random-fox'
    Description       = 'DashView: A PowerShell dashboard that displays a system summary with animated typing and font customization, plus tools for a specialized system+network repair and a cumulative Windows+application+module update.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @('DashFont','DashRepair','DashType','DashUpdates','DashView')
    CmdletsToExport   = @()
    AliasesToExport   = @()
    PrivateData = @{
        PSData = @{
            Tags        = @('dashboard','system','updater','repair','font','typing','powershell','windows')
            ProjectUri  = 'https://github.com/a-random-fox/DashView'
            LicenseUri  = 'https://github.com/a-random-fox/DashView/blob/main/LICENSE'
            IconUri     = 'https://raw.githubusercontent.com/a-random-fox/DashView/main/assets/icon.png'
            ReleaseNotes = 'Initial gallery release.'
        }
    }
}

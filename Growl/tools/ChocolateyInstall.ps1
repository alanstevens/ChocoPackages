if ([Environment]::OSVersion.Version -gt '6.2')
{
    $feature = @{FeatureName = 'NetFx3'; Online = $true}
    $fxInstalled = Get-WindowsOptionalFeature @feature |
        Select -ExpandProperty State

    if ($fxInstalled -ne 'Enabled')
    {
        Write-Host 'Enabling .NET Framework 2.0 runtime...'
        Enable-WindowsOptionalFeature @feature
    }
}

$params = @{
    packageName = "growl";
    fileType = 'exe';
    silentArgs = '/c:"msiexec -i Growl_v2.0.msi /qn"';
    url = 'https://github.com/briandunnington/growl-for-windows/releases/download/final/GrowlInstaller.exe';
}
Install-ChocolateyPackage @params

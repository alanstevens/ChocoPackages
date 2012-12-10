$packageName = 'Growl'

try
{
    $params = @{
        packageName = $package;
        fileType = 'exe';
        silentArgs = '/c:"msiexec -i Growl_v2.0.msi /qn"'
        url = 'http://www.growlforwindows.com/gfw/d.ashx?f=GrowlInstaller.exe';
    }

    Install-ChocolateyPackage @params

    Write-ChocolateySuccess $packageName
}
catch
{
    Write-ChocolateyFailure $package "$($_.Exception.Message)"
    throw
}
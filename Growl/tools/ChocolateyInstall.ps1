$params = @{
    packageName = "growl";
    fileType = 'exe';
    silentArgs = '/c:"msiexec -i Growl_v2.0.msi /qn"';
    url = 'https://github.com/briandunnington/growl-for-windows/releases/download/final/GrowlInstaller.exe';
    checksum = '663598d376d15eaea5d82d21abcaed36039d958eced0e085b7b9937f3e10b8da';
    checksumType = 'sha256';
}
Install-ChocolateyPackage @params

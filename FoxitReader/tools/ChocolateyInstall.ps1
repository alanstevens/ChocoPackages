$packageName = 'foxitreader'
$installerType = 'EXE'
$url = 'http://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/win/7.x/7.0/en_us/FoxitReader706.1126_enu_Setup.exe'
$silentArgs = '/verysilent'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
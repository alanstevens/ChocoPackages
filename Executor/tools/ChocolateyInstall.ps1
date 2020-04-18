$packageArgs = @{
    url = 'http://www.1space.dk/executor/ExecutorSetup.exe'
    fileType = 'exe'
    softwareName = 'Executor'
    packageName = 'executor'
    silentArgs = '/verysilent'
    checksum      = '4F9666D647019A488E7959831505EA0C05083A60E0D33F191C25BC872E419BDD'
    checksumType  = 'sha256'
    checksum64    = '4F9666D647019A488E7959831505EA0C05083A60E0D33F191C25BC872E419BDD'
    checksumType64= 'sha256'
}
Install-ChocolateyPackage @packageArgs

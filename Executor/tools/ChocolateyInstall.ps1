$packageArgs = @{
    url = 'http://www.1space.dk/executor/ExecutorSetup.exe'
    fileType = 'exe'
    softwareName = 'Executor'
    packageName = 'executor'
    silentArgs = '/verysilent'
    checksum      = '10D170EEBE36D0E43F2A2BDE0F7E3712BB82AC8141D60126BDEBF67A3F191B79'
    checksumType  = 'sha256'
    checksum64    = '10D170EEBE36D0E43F2A2BDE0F7E3712BB82AC8141D60126BDEBF67A3F191B79'
    checksumType64= 'sha256'
}
Install-ChocolateyPackage @packageArgs

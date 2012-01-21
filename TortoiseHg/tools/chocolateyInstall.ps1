Function Get-ExplorerProcessCount
{
    $process = Get-Process explorer -ErrorAction SilentlyContinue
    $processCount = 0
    if($process -ne $null)
    {
        $processCount = $process.count
    }
    return $processCount
}

$initialProcessCount = Get-ExplorerProcessCount

Install-ChocolateyPackage 'TortoiseHg' 'msi' '/QN /norestart REBOOT=ReallySuppress' 'http://bitbucket.org/tortoisehg/thg/downloads/tortoisehg-2.2.2-hg-2.0.2-x86.msi' 'http://bitbucket.org/tortoisehg/thg/downloads/tortoisehg-2.2.2-hg-2.0.2-x64.msi'

$finalProcessCount = Get-ExplorerProcessCount

if($initialProcessCount -ne $finalProcessCount)
{
    Start-Process explorer.exe
}

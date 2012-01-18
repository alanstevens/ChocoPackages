$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$wgetPath = Join-Path $scriptPath 'wget.exe'
Get-ChocolateyWebFile 'Wget' "$wgetPath" 'http://users.ugent.be/~bpuype/wget/wget.exe'

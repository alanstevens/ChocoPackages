$id = "ansicon"
$key = "HKCU:\Software\Microsoft\Command Processor"
$url = "https://github.com/adoxa/ansicon/releases/download/v1.66/ansi166.zip"

$is64bit = Get-ProcessorBits 64
$subfolder = @{$true="x64";$false="x86"}

$tools = Split-Path $MyInvocation.MyCommand.Definition
$content = Join-Path (Split-Path $tools) "content"
$ansicon = Join-Path $content (Join-Path $subfolder[$is64bit] $id)
$ignore = Join-Path $content (Join-Path $subfolder[-not $is64bit] "$id.exe.ignore")

Install-ChocolateyZipPackage $id $url $content

New-Item $ignore -Type File -Force | Out-Null

# ANSICON -i produces a Command Processor AutoRun property with these attributes
#
#   * at the beginning of the property
#   * surrounded by parenthesis
#   * separated by a single & (when there are existing commands)
#   * without the file extension
#
# Example without existing commands:
# 
#   (if %ANSICON_VER%==^%ANSICON_VER^% "path\to\ansicon" -p)
#
# Example with existing commands:
# 
#   (if %ANSICON_VER%==^%ANSICON_VER^% "path\to\ansicon" -p)&<other-commands>
#
$statement = "(if %ANSICON_VER%==^%ANSICON_VER^% `"$ansicon`" -p)"
$pattern = '(?<ansicon>\(if %ANSICON_VER%==\^%ANSICON_VER\^% ".*" -p\))'

$autorun = (Get-ItemProperty -Path $key).AutoRun

$autorun -match $pattern
$match = $matches["ansicon"]

Write-Debug "[ANSICON] Adding ANSICON to the Command Processor AutoRun registry: `"$autorun`""

if(-not $autorun) {
  $autorun = $statement
}
elseif($match) {
  Write-Debug "[ANSICON] Replacing existing ANSICON command: `"$match`""
  $autorun = $autorun -replace [regex]::Escape($match), $statement
}
else {
  $autorun = $statement + "&" + $autorun
}

Write-Debug "[ANSICON] New AutoRun value: `"$autorun`""

Set-ItemProperty -Path $key -Name "AutoRun" -Value $autorun -Type String

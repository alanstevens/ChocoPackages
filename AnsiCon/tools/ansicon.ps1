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
$pattern = '(?<ansicon>\(if %ANSICON_VER%==\^%ANSICON_VER\^% ".*" -p\))'
$pattern_greedy = '(?<ansicon>\(if %ANSICON_VER%==\^%ANSICON_VER\^% ".*" -p\)&*)'

function Remove-AnsiconProperty($key) {
  $autorun = (Get-ItemProperty -Path $key).AutoRun

  Write-Debug "[ANSICON] Registry key: $key"
  Write-Debug "[ANSICON] AutoRun property: $autorun"

  if(-not $autorun) {
    return
  }

  if(-not($autorun -match $pattern_greedy)) {
    return
  }

  $match = $matches["ansicon"]
  $autorun = $autorun -replace [regex]::Escape($match), ""

  Write-Debug "[ANSICON] AutoRun property: $autorun"

  Set-ItemProperty -Path $key -Name "AutoRun" -Value $autorun -Type String
}

function Set-AnsiconProperty($key, $ansicon) {
  $statement = "(if %ANSICON_VER%==^%ANSICON_VER^% `"$ansicon`" -p)"

  $autorun = (Get-ItemProperty -Path $key).AutoRun

  Write-Debug "[ANSICON] Ansicon path: $ansicon"
  Write-Debug "[ANSICON] Registry key: $key"
  Write-Debug "[ANSICON] AutoRun property: $autorun"

  if(-not $autorun) {
    $autorun = $statement
  }
  elseif($autorun -match $pattern) {
    $match = $matches["ansicon"]
    $autorun = $autorun -replace [regex]::Escape($match), $statement
  }
  else {
    $autorun = $statement + '&' + $autorun
  }

  Write-Debug "[ANSICON] AutoRun property: $autorun"

  Set-ItemProperty -Path $key -Name "AutoRun" -Value $autorun -Type "String"
}

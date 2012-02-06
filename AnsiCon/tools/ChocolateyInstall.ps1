
$packageName = 'ansicon'
$url = 'https://github.com/downloads/adoxa/ansicon/ansi150.zip'
$chocTempDir = Join-Path $env:TEMP "chocolatey"
$unzipLocation = Join-Path $chocTempDir "$packageName"
$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
$sourceDir = Join-Path $unzipLocation 'x86'
if($is64bit){$sourceDir = Join-Path $unzipLocation 'x64'}
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$targetDir = $(join-path $toolsDir $packageName)

if(!(test-path $targetDir)){
  Install-ChocolateyZipPackage $packageName $url $unzipLocation
  # If ansicon is in use in the current console, this will fail :-(
  move-item $sourceDir $targetDir -force
}

$ansicon = 'ansicon.exe'
$targetFile = "(if %ANSICON_VER%==^%ANSICON_VER^% `"$(join-path $targetDir $ansicon)`" -p)"

$registryKey = 'HKCU:\Software\Microsoft\Command Processor'
$keyProperty = 'AutoRun'
$currentValue = (Get-ItemProperty $registryKey).$keyProperty
$newValue = ''

write-host 'Adding ansicon to the command processor autorun registry key'

#check for empty value
if($currentValue){
  #check for multiple values
  if($currentValue.Contains('&&')){
    #split on '&&'
    $currentValues = $currentValue.Split('&&')

    #check each value for $aliasFile
    ForEach ($value in $currentValues){
      if(!$value.ToLower().Contains($ansicon.ToLower()) -and ![string]::IsNullOrEmpty($value)){
        $newValue += "$value`&`&"
      }
    }
    $newValue += $targetFile
  }
  else{
    if($currentValue.ToLower().Contains($ansicon.ToLower())){
      $newValue = $targetFile
    }else{
      $newValue = "$currentValue`&`&$targetFile"
    }
  }
}else{
  $newValue = $targetFile
}

Set-ItemProperty -Path $registryKey -Name $keyProperty -Value $newValue -Type string

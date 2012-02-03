
function Remove-PropertyValueLike{
param([string] $currentValue, [string] $likeValue)
}

$packageName = 'CmdAliases'

$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentDir = $($toolsDir | Split-Path | Join-Path -ChildPath "content")
$aliasFile = 'aliases.bat'
$sourceFile = "$(join-path $contentDir $aliasFile)"
$targetFile = "$(join-path $env:userprofile $aliasFile)"

copy-item $sourceFile $targetFile

$registryKey = 'HKCU:\Software\Microsoft\Command Processor'
$keyProperty = 'AutoRun'
$currentValue = (Get-ItemProperty $registryKey).$keyProperty
$ansiconValue = "$(join-path $targetDir 'ansicon.exe') -p"
$newValue = ''
#check for empty value
if($currentValue){
#check for '&&'
  if($currentValue.Contains('&&'){
#split on '&&'
    $currentValues = currentValue.Split('&&')

  For Each $value in $currentValues
      if($currentValue.ToLower().Contains($aliasFile.ToLower()){
          blnFound = True
      End If
  Next
  }
  else{
    if($currentValue.ToLower().Contains($aliasFile.ToLower()){
    }else{
      $newValue = "$currentValue&&$ansiconValue"
    }
  }
#check each value for $aliasFile
#join values with '&&'
}

Set-Item -Path $registryKey -Name $keyProperty -Value $newValue -Type string

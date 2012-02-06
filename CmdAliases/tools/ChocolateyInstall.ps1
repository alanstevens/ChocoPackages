
$packageName = 'CmdAliases'

$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentDir = $($toolsDir | Split-Path | Join-Path -ChildPath "content")
$aliasFile = 'aliases.bat'
$sourceFile = "$(join-path $contentDir $aliasFile)"
$targetFile = "$(join-path $env:userprofile $aliasFile)"

#if file exists, create backup with timestamp in name
if(Test-Path $targetFile){
  $date = (Get-Date).toString('dd-MM-yyyy_hh_mm_ss')
  $baseName = [system.io.path]::GetFilenameWithoutExtension($targetFile)
  $extension = [System.IO.Path]::GetExtension($targetFile)
  $backupFile = $(join-path $env:userprofile "$baseName`_$date$extension")
  write-host "Backing up $targetFile as $backupFile."
  move-item $targetFile $backupFile -force }

copy-item $sourceFile $targetFile

$registryKey = 'HKCU:\Software\Microsoft\Command Processor'
$keyProperty = 'AutoRun'
$currentValue = (Get-ItemProperty $registryKey).$keyProperty
$newValue = ''

#check for empty value
if($currentValue){
  #check for multiple values
  if($currentValue.Contains('&&')){
    #split on '&&'
    $currentValues = $currentValue.Split('&&')

    #check each value for $aliasFile
    ForEach ($value in $currentValues){
      if(!$value.ToLower().Contains($aliasFile.ToLower()) -and ![string]::IsNullOrEmpty($value)){
        $newValue += "$value`&`&"
      }
    }
    $newValue += $targetFile
  }
  else{
    if($currentValue.ToLower().Contains($aliasFile.ToLower())){
      $newValue = $targetFile
    }else{
      $newValue = "$currentValue`&`&$targetFile"
    }
  }
}else{
  $newValue = $targetFile
}

Set-ItemProperty -Path $registryKey -Name $keyProperty -Value $newValue -Type string

write-host "** Review and edit $targetFile to customize the macros. **"

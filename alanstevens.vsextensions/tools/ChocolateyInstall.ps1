$packageName = 'alanstevens.vsextensions'

function Get-Batchfile ($file) {
  $cmd = "`"$file`" & set"
    cmd /c $cmd | Foreach-Object {
      $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}

function VsVars32($version = "10.0")
{
  $key = "HKCU:Software\Microsoft\VisualStudio\10.0_Config\Setup\VS"
    $VsKey = get-ItemProperty $key
    $VsInstallPath = [System.IO.Path]::GetDirectoryName($VsKey.VS7CommonBinDir)
    $BatchFile = [System.IO.Path]::Combine($VsInstallPath, "vsvars32.bat")
    Get-Batchfile "$BatchFile"
}

function curlex($url, $filename) {
  $path = [io.path]::gettemppath() + "\" + $filename

    if( test-path $path ) { rm -force $path }

  (new-object net.webclient).DownloadFile($url, $path)

    return new-object io.fileinfo $path
}

function installsilently($url, $name) {
  vsixinstaller /q (curlex $url $name).FullName
}

try {

  vsvars32

    installsilently http://visualstudiogallery.msdn.microsoft.com/b31916b0-c026-4c27-9d6b-ba831093f6b2/file/62080/1/Gister.vsix gister.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/27077b70-9dad-4c64-adcf-c7cf6bc9970c/file/37502/19/NuGet.Tools.vsix nuget.tools.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/d0d33361-18e2-46c0-8ff2-4adea1e34fef/file/29666/12/ProPowerTools.vsix ProPowerTools.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/e5f41ad9-4edc-4912-bca3-91147db95b99/file/7088/6/PowerCommands.vsix PowerCommands.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/d491911d-97f3-4cf6-87b0-6a2882120acf/file/25426/68/DPStudio.VSCommands.vsix DPStudio.VSCommands.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/59ca71b3-a4a3-46ca-8fe1-0e90e3f79329/file/6390/26/VsVim.vsix VsVim.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/2b96d16a-c986-4501-8f97-8008f9db141a/file/53962/24/Mindscape.WebWorkbench.Integration.10.vsix Mindscape.WebWorkbench.Integration.10.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/6ed4c78f-a23e-49ad-b5fd-369af0c2107f/file/50769/31/WebEssentials.vsix WebEssentials.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/fa85b17d-3df2-49b1-bee6-71527ffef441/file/49766/1/PerfWatsonExtension-Signed.vsix PerfWatson.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/7c8341f1-ebac-40c8-92c2-476db8d523ce/file/15808/9/SpellChecker.vsix SpellChecker.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/20cd93a2-c435-4d00-a797-499f16402378/file/13848/1/ThemeManagerPackage.vsix ThemeManagerPackage.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/a15c3ce9-f58f-42b7-8668-53f6cdc2cd83/file/52418/2/Web%20Standards%20Update.msi Web%20Standards%20Update.msi

    Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
    throw
}

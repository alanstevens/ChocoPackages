$packageName = 'alanstevens.vs2012extensions'

function Get-Batchfile ($file) {
  $cmd = "`"$file`" & set"
    cmd /c $cmd | Foreach-Object {
      $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}

function VsVars32()
{
    $BatchFile = join-path $env:VS110COMNTOOLS "vsvars32.bat"
    Get-Batchfile `"$BatchFile`"
}

function curlex($url, $filename) {
  $path = join-path $env:temp $filename

    if( test-path $path ) { rm -force $path }

  (new-object net.webclient).DownloadFile($url, $path)

    return new-object io.fileinfo $path
}

function installsilently($url, $name) {
  echo "Installing $name"

  $extension = (curlex $url $name).FullName

  $result = Start-Process -FilePath "VSIXInstaller.exe" -ArgumentList "/q $extension" -Wait -PassThru;
}

try {

  vsvars32

    installsilently http://visualstudiogallery.msdn.microsoft.com/b31916b0-c026-4c27-9d6b-ba831093f6b2/file/62080/1/Gister.vsix Gister.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/c8bccfe2-650c-4b42-bc5c-845e21f96328/file/75539/6/EditorConfigPlugin-0.2.5.vsix EditorConfig.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/27077b70-9dad-4c64-adcf-c7cf6bc9970c/file/37502/19/NuGet.Tools.vsix NuGet.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/e5f41ad9-4edc-4912-bca3-91147db95b99/file/7088/6/PowerCommands.vsix PowerCommands.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/59ca71b3-a4a3-46ca-8fe1-0e90e3f79329/file/6390/26/VsVim.vsix VsVim.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/07d54d12-7133-4e15-becb-6f451ea3bea6/file/79465/11/WebEssentials2012.vsix WebEssentials.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/366ad100-0003-4c9a-81a8-337d4e7ace05/file/82992/3/ColorThemeEditor.vsix ColorThemeEditor.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/63a7e40d-4d71-4fbb-a23b-d262124b8f4c/file/29105/40/GitSccProvider.vsix GitSccProvider.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/72a60b14-1581-4b9b-89f2-846072eff19d/file/51005/2/EFPowerTools.vsix EfPowerTools.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/a83505c6-77b3-44a6-b53b-73d77cba84c8/file/74740/18/SquaredInfinity.VSCommands.VS11.vsix VsCommands.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/7c8341f1-ebac-40c8-92c2-476db8d523ce/file/15808/10/SpellChecker.vsix SpellChecker.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/7dbae8b3-5812-490e-913e-7bfe17f47f1d/file/29587/13/donmar.devColor.vsix DevColor.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/23d11b45-c2ed-4398-9cb5-48ea67878470/file/77232/3/Twitter%20Bootstrap%20MVC.vsix TwitterBootstrapMvc.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/f2ec6478-7fa2-4782-9fc0-e6d9ef8bb3a9/file/79408/4/MvcTwitterBootstrap.vsix MvcTwitterBootstrap.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/1460ab21-75be-49d0-900f-dfd538321424/file/54475/10/ConsoleLauncher.vsix ConsoleLauncher
    installsilently http://visualstudiogallery.msdn.microsoft.com/2b96d16a-c986-4501-8f97-8008f9db141a/file/53962/24/Mindscape.WebWorkbench.Integration.10.vsix WebWorkbench.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/6e54271c-2c4e-4911-a1b4-a65a588ae138/file/85910/4/TfsGoOffline.vsix Tfs-GoOffline

    Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
    throw
}

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
$programFiles = $env:ProgramFiles
if ($is64bit) {$programFiles = $env:ProgramW6432;}
$irfanViewPath = "$(join-path $programFiles 'IrfanView')"

$packageName = 'IrfanView'
$fileType = 'exe'

# folder:     destination folder; if not indicated: old IrfanView folder is used, if not found, the "Program Files" folder is used
# desktop:  create desktop shortcut; 0 = no, 1 = yes (default: 0)
# thumbs:   create desktop shortcut for thumbnails; 0 = no, 1 = yes (default: 0)
# group:     create group in Start Menu; 0 = no, 1 = yes (default: 0)
# allusers:  desktop/group links are for all users; 0 = current user, 1 = all users
# assoc:     if used, set file associations; 0 = none, 1 = images only, 2 = select all (default: 0)
# assocallusers:  if used, set associations for all users (Windows XP only)
# ini:      if used, set custom INI file folder (system environment variables are allowed)

$silentArgs = "/silent /folder=`"$irfanViewPath`" /desktop=0 /thunbs=0 /group=1 /allusers=0 /assoc=1"

$url = 'http://software-files-a.cnet.com/s/software/12/48/66/01/iview433_setup.exe'

write-host $silentArgs

Install-ChocolateyPackage $packageName $fileType $silentArgs $url

$packageName = 'IrfanViewPlugins'
$silentArgs = "/silent"
$url = 'http://lfiles3.brothersoft.com/photograph_graphics/image_viewers/irfanview_plugins_432_setup.exe'
Install-ChocolateyPackage $packageName $fileType $silentArgs $url

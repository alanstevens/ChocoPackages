function Get-UninstallString {
	$processor = Get-WmiObject Win32_Processor 
	$is64bit = $processor.AddressWidth -eq 64 

	# for 32-bit systems
	$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Foxit Reader_is1'
	if ($is64bit) {
		$regPath = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Foxit Reader_is1'
	}

	$key = Get-Item -Path $regPath -ErrorAction Stop
	$uninstallString = $key.GetValue('UninstallString')

	if ($uninstallString) {
		return $uninstallString
	}
	else {
		throw [System.IO.FileNotFoundException] "Uninstall string not found in `"$regPath`"."
	}
}

$packageName = 'Foxit Reader'

try {
	$uninstallArgs = '/verysilent'
	$validExitCodes = @(0)
	Start-ChocolateyProcessAsAdmin $uninstallArgs $(Get-UninstallString) -validExitCodes $validExitCodes
	
	Write-ChocolateySuccess $packageName
}
catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
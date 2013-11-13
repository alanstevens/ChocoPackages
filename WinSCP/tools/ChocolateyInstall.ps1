$packageName = 'winscp'
$url = 'http://prdownloads.sourceforge.net/winscp/winscp517setup.exe'
$language = (Get-Culture).TwoLetterISOLanguageName

if ($language -eq $null) {
	$language = 'en' # Fallback language if others fail
}

$args = "/VERYSILENT /LANG=$language"

Install-ChocolateyPackage $packageName 'exe' $args $url 

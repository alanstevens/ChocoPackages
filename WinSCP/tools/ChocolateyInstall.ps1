$packageName = 'winscp'
$url = 'http://cdn.winscp.net/files/winscp556setup.exe?secure=eKnEtqicT22iPiW2_FqgVQ==,1423587399'
$language = (Get-Culture).TwoLetterISOLanguageName

if ($language -eq $null) {
	$language = 'en' # Fallback language if others fail
}

$args = "/VERYSILENT /LANG=$language"

Install-ChocolateyPackage $packageName 'exe' $args $url 

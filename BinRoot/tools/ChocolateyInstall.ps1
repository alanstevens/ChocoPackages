$packageName = 'BinRoot'

### Set the environment variable for the bin root to a default value if not already set ###
if($env:chocolatey_bin_root -eq $null){[Environment]::SetEnvironmentVariable("chocolatey_bin_root", "\bin", "User")}

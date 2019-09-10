#cmd> mvn -version

#create folder if not exists
function CreateFolder ([string]$Path) {
  New-Item -Path $Path -type directory -Force
}

$version = '3.6.2'
$name = "apache-maven-$version"
$tools = Split-Path $MyInvocation.MyCommand.Definition
$package = Split-Path $tools
$m2_home = Join-Path $package $name
$m2_bin = Join-Path $m2_home 'bin'
$mvn_cmd = Join-Path $m2_bin 'mvn.cmd'
$mvn_debug_cmd = Join-Path $m2_bin 'mvnDebug.cmd'
$m2_repo = Join-Path $env:USERPROFILE '.m2'
$pathToAdd = Join-Path '%M2_HOME%' 'bin'

$url = "https://archive.apache.org/dist/maven/maven-3/$version/binaries/$name-bin.zip"

# Delete leftovers from previous versions
Remove-Item "$(Join-Path $package 'apache-maven-*')" -Force -Recurse

Install-ChocolateyZipPackage `
    -PackageName 'Maven' `
    -Url $url `
    -Checksum 'd941423d115cd021514bfd06c453658b1b3e39e6240969caf4315ab7119a77299713f14b620fb2571a264f8dff2473d8af3cb47b05acf0036fc2553199a5c1ee' `
    -ChecksumType 'sha512' `
    -UnzipLocation $package

CreateFolder($m2_repo)

[Environment]::SetEnvironmentVariable('M2_HOME', $m2_home, 'Machine')
Install-ChocolateyPath -PathToInstall $pathToAdd -PathType 'Machine'

# TODO: Clean-up code for versions <= 3.6.1. Remove from next release
Uninstall-BinFile -Name 'mvn' -Path $mvn_cmd
Uninstall-BinFile -Name 'mvnDebug' -Path $mvn_debug_cmd
[Environment]::SetEnvironmentVariable('M2_HOME', $null, 'User')
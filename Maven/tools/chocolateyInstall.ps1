#cmd> mvn -version

#create folder if not exists
function CreateFolder ([string]$Path) {
  New-Item -Path $Path -type directory -Force
}

$version = '3.6.1'
$name = "apache-maven-$version"
$tools = Split-Path $MyInvocation.MyCommand.Definition
$package = Split-Path $tools
$m2_home = Join-Path $package $name
$mvn_cmd = Join-Path $m2_home 'bin/mvn.cmd'
$mvn_debug_cmd = Join-Path $m2_home 'bin/mvnDebug.cmd'
$m2_repo = Join-Path $env:USERPROFILE '.m2'

$url = "https://archive.apache.org/dist/maven/maven-3/$version/binaries/$name-bin.zip"

# Delete leftovers from previous versions
Remove-Item "$package\apache-maven-*" -Force -Recurse

Install-ChocolateyZipPackage `
    -PackageName 'Maven' `
    -Url $url `
    -Checksum '51169366d7269ed316bad013d9cbfebe3a4ef1fda393ac4982d6dbc9af2d5cc359ee12838b8041cb998f236486e988b9c05372f4fdb29a96c1139f63c991e90e' `
    -ChecksumType 'sha512' `
    -UnzipLocation $package

CreateFolder($m2_repo)

[Environment]::SetEnvironmentVariable('M2_HOME', $m2_home, "Machine")
Install-ChocolateyPath -PathToInstall "%M2_HOME%\bin" -PathType 'Machine'

# TODO: Clean-up code for versions <= 3.6.1. Remove from next release
Uninstall-BinFile -Name 'mvn' -Path $mvn_cmd
Uninstall-BinFile -Name 'mvnDebug' -Path $mvn_debug_cmd
[Environment]::SetEnvironmentVariable('M2_HOME', $null, "User")
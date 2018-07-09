#cmd> mvn -version

#create folder if not exists
function CreateFolder ([string]$Path) {
  New-Item -Path $Path -type directory -Force
}

$version = '3.5.4'
$name = "apache-maven-$version"
$tools = Split-Path $MyInvocation.MyCommand.Definition
$package = Split-Path $tools
$m2_home = Join-Path $package $name
$mvn_cmd = Join-Path $m2_home 'bin/mvn.cmd'
$mvn_debug_cmd = Join-Path $m2_home 'bin/mvnDebug.cmd'
$m2_repo = Join-Path $env:USERPROFILE '.m2'

$url = "https://archive.apache.org/dist/maven/maven-3/$version/binaries/$name-bin.zip"


[Environment]::SetEnvironmentVariable('M2_HOME', $m2_home, "User")

Install-ChocolateyZipPackage `
    -PackageName 'Maven' `
    -Url $url `
    -Checksum '8a0d9cc9d4da3fac195de8e1e99fe07158d54192' `
    -ChecksumType 'sha1' `
    -UnzipLocation $package

CreateFolder($m2_repo)

Install-BinFile -Name 'mvn' -Path $mvn_cmd
Install-BinFile -Name 'mvnDebug' -Path $mvn_debug_cmd

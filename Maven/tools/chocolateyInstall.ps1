#cmd> mvn -version

#create folder if not exists
function CreateFolder ([string]$Path) {
  New-Item -Path $Path -type directory -Force
}

$version = '3.6.0'
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
    -Checksum '7d14ab2b713880538974aa361b987231473fbbed20e83586d542c691ace1139026f232bd46fdcce5e8887f528ab1c3fbfc1b2adec90518b6941235952d3868e9' `
    -ChecksumType 'sha512' `
    -UnzipLocation $package

CreateFolder($m2_repo)

Install-BinFile -Name 'mvn' -Path $mvn_cmd
Install-BinFile -Name 'mvnDebug' -Path $mvn_debug_cmd

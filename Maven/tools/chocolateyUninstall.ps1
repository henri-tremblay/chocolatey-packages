$version = '3.5.0'
$name = "apache-maven-$version"
$tools = Split-Path $MyInvocation.MyCommand.Definition
$package = Split-Path $tools
$m2_home = Join-Path $package $name
$m2_bin = Join-Path $m2_home 'bin'
$mvn_cmd = Join-Path $m2_home 'bin/mvn.cmd'
$m2_repo = Join-Path $env:USERPROFILE '.m2'

[Environment]::SetEnvironmentVariable('M2_HOME', $null, "User")
[Environment]::SetEnvironmentVariable('MAVEN_OPTS', $null, "User")
[Environment]::SetEnvironmentVariable('M2', $null, "User")
[Environment]::SetEnvironmentVariable('M2_REPO', $null, "User")

Uninstall-BinFile -Name 'mvn' -Path $mvn_cmd

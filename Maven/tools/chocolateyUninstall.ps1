$version = '3.5.2'
$name = "apache-maven-$version"
$tools = Split-Path $MyInvocation.MyCommand.Definition
$package = Split-Path $tools
$m2_home = Join-Path $package $name
$mvn_cmd = Join-Path $m2_home 'bin/mvn.cmd'
$mvn_debug_cmd = Join-Path $m2_home 'bin/mvnDebug.cmd'

[Environment]::SetEnvironmentVariable('M2_HOME', $null, "User")


Uninstall-BinFile -Name 'mvn' -Path $mvn_cmd
Uninstall-BinFile -Name 'mvnDebug' -Path $mvn_debug_cmd

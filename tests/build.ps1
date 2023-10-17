cd $HOME\Sandbox\CRWD-HBFW
Copy-Item -Force -Recurse .\crwd-hbfw $HOME\Documents\WindowsPowerShell\Modules\.
Publish-Module -Name crwd-hbfw -Repository LocalModules -Force -Verbose
Install-Module crwd-hbfw -Repository LocalModules -Verbose -Force -AllowClobber -Scope AllUsers
Import-Module -Name crwd-hbfw
Get-CrwdHbfw
Remove-Module -Name crwd-hbfw
Uninstall-Module -Name crwd-hbfw -AllVersions
Remove-Item -Force -Recurse $HOME\Documents\WindowsPowerShell\Modules\crwd-hbfw*
Remove-Item -Force -Recurse $HOME\Documents\WindowsPowerShell\Repo\crwd-hbfw*
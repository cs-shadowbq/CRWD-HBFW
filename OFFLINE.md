# Offline Installation

When CrowdStrike Falcon is installed on a machine where a computer no longer has internet access it can be difficult to understand the current applied firewall rules. 

You also cannot use the `Install-Module` cmdlet to install modules from the [PowerShell Gallery](https://www.powershellgallery.com/). 

## Download module(s)

1. Navigate to the [PowerShell Gallery](https://www.powershellgallery.com/)
2. Search for the module and dependency modules.
3. Select the **Manual Download** tab
4. Click the **Download the raw nupkg file**
5. After the file finishes downloading, copy it to the desired target windows machine.

## Option 1 - Install a the module via LocalRepository

1. Create a local repository

```powershell
New-Item -ItemType Directory C:\LocalRepository
$LocalRepository = @{
    Name = 'LocalRepository'
    SourceLocation = 'C:\LocalRepository'
    PublishLocation = 'C:\LocalRepository'
    InstallationPolicy = 'Trusted'
}
Register-PSRepository @LocalRepository
```

2. Copy the nugpk files to the desired directory.

```powershell
Copy-Item -Path .\NTObjectManager.2.0.0.nupkg -Destination C:\LocalRepository
Copy-Item -Path .\crwd-hbfw.1.0.2.nupkg -Destination C:\LocalRepository
PS C:\LocalRepository> Get-Childitem

    Directory: C:\LocalRepository

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          10/18/2023 11:18 AM           8418 crwd-hbfw.1.0.2.nupkg
-a---          10/18/2023 10:59 AM        5554458 ntobjectmanager.2.0.0.nupkg
```

3. Install the module

```powershell
Install-Module -Name NTObjectManager -Repository LocalRepository
Install-Module -Name crwd-hbfw -Repository LocalRepository
```

4. Validation of Installation

```powershell
PS C:\LocalRepository> Get-InstalledModule

Version              Name                                Repository           Description
-------              ----                                ----------           -----------
2.0.0                NtObjectManager                     LocalRepository      This module adds a provider and cmdlets
(...)
```

## Option 2 - Install a module via Expansion

### Install the module dependencies

* xxxx NTObjectManager 2.0.0 (TODO) - Add instructions for installing dependencies with dlls, types,formats, and functions.

### Install the module

1. Rename the module replacing the `.nupkg` extension with a `.zip`

   ```powershell
    Move-Item -Path .\crwd-hbfw.1.0.2.nupkg -Destination .\crwd-hbfw.1.0.2.zip
    ```

1. Extract the ZIP file. The resulting folder will have a name formatted like _<Module Name>.<Module Version>_

    ```powershell
    Expand-Archive -Path .\crwd-hbfw.1.0.2.zip
    ```
  
1. Determine [where to install the module](https://docs.microsoft.com/powershell/scripting/developer/module/installing-a-powershell-module?view=powershell-5.1#where-to-install-modules). For this example the module will be installed in `$env:ProgramFiles`

    ```powershell
    $env:PSModulePath.Split(';')
    ```

1. Create a new folder in `$Env:ProgramFiles\WindowsPowerShell\Modules` with the name **Module Name**

    If you are using Powershell `5.x`

    ```powershell
    New-Item -Path $env:ProgramFiles\WindowsPowerShell\Modules\crwd-hbfw -ItemType Directory
    ```

    If you are using Powershell `7.x`

    ```powershell
    New-Item -Path $env:ProgramFiles\PowerShell\Modules\crwd-hbfw -ItemType Directory
    ```

1. Rename the module folder to be only the module version.

    ```powershell
    Move-Item -Path .\crwd-hbfw.1.0.2 -Destination .\1.0.2
    ```

1. Move the module version folder into the module name folder.

    ```powershell
    Move-Item -Path .\1.0.2 -Destination $env:ProgramFiles\WindowsPowerShell\Modules\crwd-hbfw
    ```
# Steps to Create, and Publish a PowerShell module to PSGallery

These steps will register your local folder as a PSRepository and Package your PowerShell module so that `Install-Module` will find the package and install it. Be sure to replace `<user>` with your actual username directory.

* At the PowerShell prompt enter get the first line returned from the following command:

```powershell
$env:PSModulePath
```

The `$env:PSModulePath` variable holds the locations where PowerShell looks for the installed modules. 

```powershell
$env:PSModulePath.Split(";")
C:\Users\xxxxx\Documents\WindowsPowerShell\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\Windows\system32\WindowsPowerShell\v1.0\Modules
```

* Examine your registered PowerShell Repositories

```powershell
Get-PSRepository                                                                               
Name                      InstallationPolicy   SourceLocation
----                      ------------------   --------------
PSGallery                 Untrusted            https://www.powershellgallery.com/api/v2
```

* Create a New Directory to make a Repo for Local Modules

```powershell
mkdir $HOME\Documents\WindowsPowerShell\Repo
```

* Add your local module folder as a PowerShell Gallery:

```powershell
Register-PSRepository -Name LocalModules -SourceLocation $HOME\Documents\WindowsPowerShell\Repo
Set-PSRepository -Name 'LocalModules' -InstallationPolicy Trusted
Get-PSRepository # see the result of what you registered
```

```powershell
Get-PSRepository

Name                      InstallationPolicy   SourceLocation
----                      ------------------   --------------
PSGallery                 Untrusted            https://www.powershellgallery.com/api/v2
LocalModules              Trusted              C:\Users\xxxxx\Documents\WindowsPowerShell\Repo
```

## These steps will create a module directory and manifest file:

### Option 1:

* Create the directory

```powershell
cd $HOME\Documents\WindowsPowerShell\Modules
mkdir <module name>
```

The directory name must match the module name (not including the extension “.psm1”).

* Copy the PSM1 file to the <module name> directory

* Create the manifest (.psd1) file, 
  
Example:

```powershell
New-ModuleManifest -Path .\ManageVMs.psd1
```

* Edit the manifest psd1 file, uncomment and provide values for the following required properties:

```powershell
RootModule = '<module name>.psm1' # This points to local PSM1 module
Description = 'Your module description should be succinct'
FunctionsToExport = '*' # This will export all functions as commandlets
```

If you create new releases you should come back to this file to update the version property.

### Option 2:

With a precreated directory in your developmental sandbox, copy the module to a location that is in the search path

```powershell
Copy-Item -Force -Recurse "$HOME\sandbox\<module name>" "$HOME\Documents\WindowsPowerShell\Modules\."
```

## These steps will create the actual module (NuGet package)

Install `Nu-Get` and package the the Module Locally

```powershell
Publish-Module -Name <module name> -Repository LocalModules -Force -Verbose
```

Output
```powershell
VERBOSE: Installing NuGet.exe.
VERBOSE: GET https://go.microsoft.com/fwlink/?LinkID=690216&clcid=0x409 with 0-byte payload
VERBOSE: received 1686528-byte response of content type application/octet-stream
VERBOSE: Repository details, Name = 'LocalModules', Location = 'C:\Users\xxxx\Documents\WindowsPowerShell\Repo'; IsTrusted = 'True'; IsRegistered = 'True'.
VERBOSE: Repository details, Name = 'LocalModules', Location = 'C:\Users\xxxx\Documents\WindowsPowerShell\Repo'; IsTrusted = 'True'; IsRegistered = 'True'.
VERBOSE: Publish Location:'C:\Users\xxx\Documents\WindowsPowerShell\Repo'.
VERBOSE: Module 'crwd-hbfw' was found in 'C:\Users\xxxx\Documents\WindowsPowerShell\Modules\crwd-hbfw'.
VERBOSE: Loading module from path 'C:\Users\xxxx\AppData\Local\Temp\734021217\crwd-hbfw\crwd-hbfw.psm1'.
VERBOSE: Repository details, Name = 'LocalModules', Location = 'C:\Users\xxxx\Documents\WindowsPowerShell\Repo'; IsTrusted = 'True'; IsRegistered ='True'.
VERBOSE: Using the provider 'PowerShellGet' for searching packages.
VERBOSE: Using the specified source names : 'LocalModules'.
VERBOSE: Getting the provider object for the PackageManagement Provider 'NuGet'.
VERBOSE: The specified Location is 'C:\Users\xxxx\Documents\WindowsPowerShell\Repo' and PackageManagementProvider is 'NuGet'.
VERBOSE: Total package yield:'0' for the specified package 'crwd-hbfw'.
VERBOSE: Repository details, Name = 'LocalModules', Location = 'C:\Users\xxxx\Documents\WindowsPowerShell\Repo'; IsTrusted = 'True'; IsRegistered ='True'.
VERBOSE: Using the provider 'PowerShellGet' for searching packages.
VERBOSE: Using the specified source names : 'LocalModules'.
VERBOSE: Getting the provider object for the PackageManagement Provider 'NuGet'.
VERBOSE: The specified Location is 'C:\Users\xxxx\Documents\WindowsPowerShell\Repo' and PackageManagementProvider is 'NuGet'.
VERBOSE: Total package yield:'0' for the specified package 'crwd-hbfw'.
VERBOSE: Successfully published module 'crwd-hbfw' to the module publish location 'C:\Users\xxxx\Documents\WindowsPowerShell\Repo'. Please allow few minutes for 'crwd-hbfw' to show up in the search results.
 ```

This command creates a new file in your Repo directory using the format:

`$HOME\Documents\WindowsPowerShell\Repo\<module name>.<version>.nupkg`

Example: 

```powershell
crwd-hbfw.1.0.1.nupkg
```

You have created your first module and are ready to install it with the following commands.

```powershell
Install-Module -Name <module name> -Repository LocalModules -Verbose -Force -AllowClobber -Scope AllUsers

VERBOSE: Repository details, Name = 'LocalModules', Location = 'C:\Users\xxxx\Documents\WindowsPowerShell\Repo'; IsTrusted = 'True'; IsRegistered ='True'.
VERBOSE: Using the provider 'PowerShellGet' for searching packages.
VERBOSE: Using the specified source names : 'LocalModules'.
VERBOSE: Getting the provider object for the PackageManagement Provider 'NuGet'.
VERBOSE: The specified Location is 'C:\Users\xxxx\Documents\WindowsPowerShell\Repo' and PackageManagementProvider is 'NuGet'.
VERBOSE: Total package yield:'1' for the specified package 'crwd-hbfw'.
VERBOSE: Performing the operation "Install-Module" on target "Version '1.0.1' of module 'crwd-hbfw'".
VERBOSE: The installation scope is specified to be 'AllUsers'.
VERBOSE: The specified module will be installed in 'C:\Program Files\WindowsPowerShell\Modules'.
VERBOSE: The specified Location is 'NuGet' and PackageManagementProvider is 'NuGet'.
VERBOSE: Downloading module 'crwd-hbfw' with version '1.0.1' from the repository 'C:\Users\xxxx\Documents\WindowsPowerShell\Repo'.
VERBOSE: InstallPackageLocal - name='crwd-hbfw', version='1.0.1',destination='C:\Users\xxxx\AppData\Local\Temp\462359926'
VERBOSE: Catalog file 'crwd-hbfw.cat' is not found in the contents of the module 'crwd-hbfw' being installed.
VERBOSE: For publisher validation, current module 'crwd-hbfw' with version '1.0.1' with publisher name ''. Is this module signed by Microsoft: 'False'.
VERBOSE: For publisher validation, using the previously-installed module 'crwd-hbfw' with version '1.0.1' under 'C:\Users\xxxx\Documents\WindowsPowerShell\Modules\crwd-hbfw' with publisher name ''. Is this module signed by Microsoft: 'False'.
VERBOSE: Module 'crwd-hbfw' was installed successfully to path 'C:\Program Files\WindowsPowerShell\Modules\crwd-hbfw\1.0.1'.
```
List Loaded Modules

```powershell
PS > Get-Module

ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Computer, Add-Content, Checkpoint-Computer, Clear-Content...}
Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Add-Member, Add-Type, Clear-Variable, Compare-Object...}
Binary     1.0.0.1    PackageManagement                   {Find-Package, Find-PackageProvider, Get-Package, Get-PackageProvider...}
Script     1.0.0.1    PowerShellGet                       {Find-Command, Find-DscResource, Find-Module, Find-RoleCapability...}
Script     2.0.0      PSReadline                          {Get-PSReadLineKeyHandler, Get-PSReadLineOption, Remove-PSReadLineKeyHandler, Set-PSReadLin...
```

*Note: If your new module doesn't import automatically, your may need to run `Import-Module`*

```powershell
Import-Module -Name <module name>
```

```powershell
PS > Get-Module

ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Script     1.0.1      crwd-hbfw                           {Format-CrwdHbfw, Get-CrwdHbfw}
(...)
```

## PowerShell Gallery (PSGallery)

Now that you have gone through the process of creating a PowerShell module that you can import. If you wish to share this with the world so that others may reuse what you have created, you can publish to the PSGallery. The PSGallery is the default PowerShell location that users find new modules, download them and receive updates.

To do this you will need to sign up for a free account and get your `-NuGetApiKey`

* Navigate to https://www.powershellgallery.com/ and sign-in.
* In the upper right click on your sign-in name dropdown and choose ‘API Keys’.
* Click ‘Create’, fill in the form and save your key someplace safe so you remember it.

Now that you have an apikey you may publish to the PSGallery just like you published to your LocalModules repository. 

Example:

```powershell
Publish-Module -Name ManageRoles -NuGetApiKey 'ab12cde3fgh45ijk67lmnopq8rs9tuvwxyzabcdefghij0' -requiredversion 1.1.0 -verbose
```

## If Types and Formats Are not yet available

### Format & Type

```powershell
PS > Update-FormatData -PrependPath '.\crwd.format.ps1xml'
PS > Update-TypeData -PrependPath '.\crwd.types.ps1xml'
```

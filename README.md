# MyPowerShell

Adding useful Powershell cmdlets to help with repetitive tasks. Held here for remote access and download from any pc I can work on.

## Setup
Clone this git repo to `C:\Users\<username>\Documents\MyPowerShell`

Create a profile in local directory at `C:\Users\<username>\Documents\PowerShell`

use this powershell cmd
```
if (!(Test-Path (Split-Path $profile))) { mkdir (Split-Path $profile) } ; if (!(Test-Path $profile)) { New-Item $profile -ItemType file } ; code $profile
```

to create the `profile.ps1` file or open it if it does exist ready to C & P the following. The file will open in vs code because of `code` command :


```powershell
# Import-Module posh-git
Import-Module oh-my-posh

# Load my own custom functions at startup
$OwnFunctionsDir = "$env:USERPROFILE\Documents\MyPowerShell\functions"

Write-Host " Loading my own PowerShell functions from: $OwnFunctionsDir " -ForegroundColor Black -BackgroundColor Cyan
Get-ChildItem "$OwnFunctionsDir\*.ps1" | ForEach-Object{.$_}
Write-Host '_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
Write-Host '' # Empty line

# ****************************************************** #
# Using "oh-my-posh" to get a powershell theme and style #
# ****************************************************** #
# Update this next line with the theme name to load i.e. Set-PoshPrompt -Theme [theme-name]
Set-PoshPrompt -Theme slim

```

Add the above to `"C:\Users\ryanf\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"` and save.

Reopen powershell and these functions will now be ready to use. 👍🏼

---

## List of My Cmdlets

1. Get-PublicIP - Alias `pubip`
    - Retrieve this systems public IP address

2. Remove-PackMan - Alias `rmpm`
    - Removes package manager of choice either for **composer** or **npm**. *'vendor'* is removed by default or enter *'node'* or *'node_modules'*.
    i.e. `Remove-Packman node`

3. Get-UnixTime - Alias `uid`
    - Get the time stamp in integer to use as a UID in my code from time to time. Sets to clipboard so I can simply paste wherever.
---
## Using "Oh-My-Posh" (Powershell themes)

On first install run following cmd:

```
Install-Module oh-my-posh -Scope CurrentUser
```

Add the import line to `"C:\Users\ryanf\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"`.
```
Import-Module oh-my-posh
```

Two following cmds create a list of all available themes
 - Get-PoshThemes
 - Get-PoshThemes -list


Once selected add this line with them name to load that theme `Set-PoshPrompt -Theme [theme-name]` to the `$OwnFunctionsDir` file so that the selected theme loads when PowerShell loads up

```
Set-PoshPrompt -Theme slim
```
---
# GIT Commands
Added a large selection of GIT alias cmds for ease of use in PowerShell. Refer to the `my-functions.ps1` for more details or run the cmd `alias` to see all including the added GIT ones.

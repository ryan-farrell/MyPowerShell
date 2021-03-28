# MyPowerShell

Adding useful Powershell cmdlets to help with repetitive tasks. Held here for remote access and download from any pc I can work on.

## Setup
Clone this git repo to `C:\Users\<username>\Documents\MyPowerShell`

Create a profile in local directory at `C:\Users\<username>\Documents\PowerShell`

use this powershell cmd `if (!(Test-Path (Split-Path $profile))) { mkdir (Split-Path $profile) } ; if (!(Test-Path $profile)) { New-Item $profile -ItemType file } ; code $profile`

to create the `profile.ps1` file or open it if it does exist ready to C & P the following. The file will open in vs code because of `code` command :


```powershell
# Load my own custom functions at startup

$OwnFunctionsDir = "$env:USERPROFILE\Documents\MyPowerShell\functions"

Write-Host "Loading own PowerShell functions from:" -ForegroundColor Green

Write-Host "$OwnFunctionsDir" -ForegroundColor Blue

Get-ChildItem "$OwnFunctionsDir\*.ps1" | %{.$_}

Write-Host ''

```


Add the above to `profile.ps1` and save.

Reopen powershell and these functions will now be ready to use. 👍🏼


---

## List of My Cmdlets

1. Get-PublicIP
    - Retrieve this systems public IP address

2. Remove-PackMan
    - Removes package manager of choice either for **composer** or **npm**. *'vendor'* is removed by default or enter *'node'* or *'node_modules'*.
    i.e. `Remove-Packman node`
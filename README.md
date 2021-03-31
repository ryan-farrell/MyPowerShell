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

Write-Host " Loading my own PowerShell functions from: $OwnFunctionsDir " -ForegroundColor Black -BackgroundColor Cyan
Get-ChildItem "$OwnFunctionsDir\*.ps1" | ForEach-Object{.$_}
Write-Host '' # Empty line
Write-Host '_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
Write-Host '' # Empty line

# ****************************************************************************************** #
# Set Alias for my own Cmdlets (See my own functions in my functions dir = $OwnFunctionsDir) #
# ****************************************************************************************** #
Set-Alias -name pubip -Value Get-PublicIP
Set-Alias -name rmpm -Value Remove-PackMan
Set-Alias -name uid -Value Get-UnixTime

```


Add the above to `profile.ps1` and save.

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
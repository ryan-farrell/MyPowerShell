# *************************************************************************************************************************************** #
# DON'T AMEND THIS FILE. THE FILE TO AMEND IS IN $PROFILE  =  C:\Users\<username>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
# *************************************************************************************************************************************** #

# ****************** #
# * Import Modules * #
# ****************** #
# Import-Module posh-git
Import-Module oh-my-posh

# Load my own custom functions at startup
$OwnFunctionsDir = "$env:USERPROFILE\Documents\MyPowerShell\functions"

Write-Host " Loading my own PowerShell functions from: $OwnFunctionsDir " -ForegroundColor Black -BackgroundColor Cyan
Get-ChildItem "$OwnFunctionsDir\*.ps1" | ForEach-Object{.$_}
Write-Host '_-_-_-_-_-_--_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
Write-Host '' # Empty line

# ****************************************************** #
# Using "oh-my-posh" to get a powershell theme and style #
# ****************************************************** #
# Update this next line with the theme name to load i.e. Set-PoshPrompt -Theme [theme-name]
# Check out the readme in C:\Users\ryanf\Documents\MyPowerShell\README.md for more details
Set-PoshPrompt -Theme slim

# *************************************************************************************************************************************** #
# DON'T AMEND THIS FILE. THE FILE TO AMEND IS IN $PROFILE  =  C:\Users\<username>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
# *************************************************************************************************************************************** #

# Load my own custom functions at startup
$OwnFunctionsDir = "$env:USERPROFILE\Documents\MyPowerShell\functions"

Write-Host "Loading own PowerShell functions from:" -ForegroundColor Green

Write-Host "$OwnFunctionsDir" -ForegroundColor Blue

Get-ChildItem "$OwnFunctionsDir\*.ps1" | %{.$_}

Write-Host ''
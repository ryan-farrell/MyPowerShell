<#
.SYNOPSIS
    Retrieve this systems public IP address
.DESCRIPTION
    Retrieve this systems public IP address and use the ipify.org API to
    return IP address
.EXAMPLE
    Get-PublicIP

    Get the public IP
.INPUTS
    None
.OUTPUTS
    System.string
.NOTES
    General notes
#>
function Get-PublicIP {
    [CmdletBinding()]
    param (
    )

    $uri = 'https://api.ipify.org'
    Write-Verbose -Message "Getting public IP from $uri"
    Write-Debug $uri
    try {
        $invokeRestMethodSplat = @{
            Uri         = $uri
            ErrorAction = 'Stop'
        }

        $publicIP = Invoke-RestMethod @invokeRestMethodSplat
    }
    catch {
        Write-Error $_
    }

    return $publicIP
} # Get-PublicIP

<#
# -- TODO --
# take a param of a dir within and if present delete only that dir not the entire vendor or node_module dir
#>

<#
.SYNOPSIS
    Removes package manager directory
.DESCRIPTION
    Removes the package manager directory for the directory your in. By default PHP composer package directory
    'vendor' will be removed and all its contents. You can provide the parameter node or node_modules to remove
    the npm package manager directory. By default it will remove 'vendor' dir if no parameter passed.
.EXAMPLE
    Remove-Packman

    PS C:\project> Remove-Packman

    Will remove PHP 'vendor' package from this directory

.EXAMPLE
    Remove-Packman node or Remove-Packman node

    PS C:\project> Remove-Packman node

    Will remove PHP 'node_modules' package from this directory

.INPUTS
    System.string
.OUTPUTS
    None

    This cmdlet does not return any output.
.NOTES
    none
#>
function Remove-PackMan {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [ValidateSet('vendor', 'node', 'node_modules')]
        [string] $pm = 'vendor'
    )

    # Get the root dir
    $rootDir = Get-Location

    if ($pm -eq 'vendor') {
        $packagePath = "$rootDir\vendor\"
    }
    elseif ($pm -eq 'node') {
        $packagePath = "$rootDir\node_modules\"
    }
    else {
        $packagePath = "$rootDir\vendor\"
    }

    if (-not (Test-Path -Path $packagePath -ErrorAction Stop)) {
        Write-Host "The directory '$pm' does not exist within this directory."
    }
    else {
        Remove-Item $packagePath
    }
} # Remove-PackMan

<#
.SYNOPSIS
    Get the current time in unix timestamp
.DESCRIPTION
    Simple way to create a UID for purposes in code blocks essentially
.EXAMPLE
    Get-UnixTime
.INPUTS
    System.string
.OUTPUTS
    None
.NOTES
    none
#>
function Get-UnixTime {
    [CmdletBinding()]
    param (
    )
    [Alias("uid")]

    # Get the current time in unix
    $UnixTime =  Get-Date -UFormat %s

    # This will create a UID which is saved to the clipboard
    Write-Host "The '$UnixTime' UID has been saved to the clipboard."

    if ($UnixTime -gt 0) {
        # Save to clipboard
        Set-Clipboard -Value $UnixTime
    }
    else {
        Write-Error "The UID could not be copied to the clipboard. Please try again."
    }

} # Get-UnixTime

<#
.SYNOPSIS
    Retrieve my Powershell functions file for adding or editing
.DESCRIPTION
    Open my Powershell my-functions.ps1 file to edit or add additional functions on the go
.EXAMPLE
    Get-MyFunc
.INPUTS
    System.string
.OUTPUTS
    None
.NOTES
    none
#>
function Get-MyFunc {
    [CmdletBinding()]
    param (
    )

    # Open the file after checking it exists
    if (Test-Path "C:\Users\ryanf\Documents\MyPowershell\functions\my-functions.ps1") {
        # Open File
        Invoke-Item "C:\Users\ryanf\Documents\MyPowershell\functions\my-functions.ps1"
    }
    else {
        Write-Error "The file could not be found."
    }

} # Get-MyFunc

<#
.SYNOPSIS
    Open my cheat sheet
.DESCRIPTION
    Opens my cheat sheet for quick reference of adding to
.EXAMPLE
    Start-OpenVPN
.INPUTS
    System.string
.OUTPUTS
    None
.NOTES
    none
#>
function Start-CheatSheet {
    [CmdletBinding()]
    param (
    )

    # Open the file after checking it exists
    if (Test-Path "C:\Users\ryanf\OneDrive\Documents\PowerShell\CheatSheets\cheatsheet.md") {
        # Open File
        Invoke-Item "C:\Users\ryanf\OneDrive\Documents\PowerShell\CheatSheets\cheatsheet.md"
    }
    else {
        Write-Error "The file could not be found."
    }

} # Start-CheatSheet

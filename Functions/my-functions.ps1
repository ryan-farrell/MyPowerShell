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
# Make sure that this module is alway loaded and that alias can be used when my script has been loaded
# take a param of a dir within an if present delete only that dir not the entire vendor or node module
# create alias for both deleting a node_module or vendor dir
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

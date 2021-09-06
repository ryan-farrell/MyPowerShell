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

# *************************** #
# Set Alias for GIT commands  #
# *************************** #
function Get-GitStatus { & git status -sb $args }
New-Alias -Name gs -Value Get-GitStatus -Force -Option AllScope

function Get-GitAddAll { & git add --all $args }
New-Alias -Name gaa -Value Get-GitAddAll -Force -Option AllScope

function Get-GitAdd { & git add -- $args }
New-Alias -Name ga -Value Get-GitAdd -Force -Option AllScope

function Get-GitCommit { & git commit -m $args }
New-Alias -Name gc -Value Get-GitCommit -Force -Option AllScope

function Get-GitAddAllCommit { & git add --all; git commit -m $args }
New-Alias -Name gaac -Value Get-GitAddAllCommit -Force -Option AllScope

# function Get-GitCherryPick { & git cherry-pick $args }
# New-Alias -Name gcp -Value Get-GitCherryPick -Force -Option AllScope

# function Get-GitCommitEdit { & git commit -ev $args }
# New-Alias -Name gce -Value Get-GitCommitEdit -Force -Option AllScope

# function Get-GitCommitAmend { & git commit --amend $args }
# New-Alias -Name gca -Value Get-GitCommitAmend -Force -Option AllScope

function Get-GitTree { & git log --graph --oneline --decorate $args }
New-Alias -Name gt -Value Get-GitTree -Force -Option AllScope

function Get-GitPush { & git push --follow-tags $args }
New-Alias -Name gps -Value Get-GitPush -Force -Option AllScope

# function Get-GitPullRebase { & git pull --rebase $args }
# New-Alias -Name gpr -Value Get-GitPullRebase -Force -Option AllScope

function Get-GitFetch { & git fetch $args }
New-Alias -Name gf -Value Get-GitFetch -Force -Option AllScope

function Get-GitCheckout { & git checkout $args }
New-Alias -Name gch -Value Get-GitCheckout -Force -Option AllScope

function Get-GitCheckoutBranch { & git checkout -b $args }
New-Alias -Name gchb -Value Get-GitCheckoutBranch -Force -Option AllScope

# function Get-GitBranch { & git branch $args }
# New-Alias -Name gb -Value Get-GitBranch -Force -Option AllScope

# function Get-GitRemoteView { & git remote -v $args }
# New-Alias -Name grv -Value Get-GitRemoteView -Force -Option AllScope

# function Get-GitRemoteAdd { & git remote add $args }
# New-Alias -Name gra -Value Get-GitRemoteAdd -Force -Option AllScope
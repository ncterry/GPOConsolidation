#======================================
Function Get-GPOsDomainController {
<#
.SYNOPSIS
    Gather the primary domain controller holding this machine.

    .DESCRIPTION
    No Parameters. Simply returns the local domain controller.

    .Example
    Get-GPOsDomainController

    .Example
    Get-GPOsDomainController $writehost $true
    # Will return the domain controller to a function, and write the domain controller in terminal.

    .Example
    Get-GPOsDomainController $writehost $false
    # Will return the domain controller to a function, and WILL NOT write the domain controller in terminal.

    .OUTPUTS
    Return Domain Example:     DC02.WidgetLLC.Internal
#> 
#======================================
[CmdletBinding()]
Param(
    [Parameter()]
    [bool[]]
    $writehost = $true
    #Don't want to writeout if called by other function
) # End Param-------------------------------


    #Gather the local domain controller
    $domainController = Get-ADDomainController -Discover | Select-Object -ExpandProperty HostName


    # View results folder in terminal. Don't write if called by other function. 
    If ($writehost -eq $true) {
        Write-Host -ForegroundColor Yellow ("`n------------------`nDomain Controller:  ")
    } # End If-------------------------------


    return $domainController

    
} #End Function Get-GPOsDomainController
#======================================

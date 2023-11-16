#==============================
Function Get-GPOsDomain {  
<#
    .SYNOPSIS
    Gather the primary domain holding this machine.

    .DESCRIPTION
    No Parameters. Simply returns the local domain.

    .Example
    Get-GPOsDomain

    .Example
    Get-GPOsDomain $writehost $true
    # Will return the domain to a function, and write the domain in terminal.

    .Example
    Get-GPOsDomain $writehost $false
    # Will return the domain to a function, and WILL NOT write the domain in terminal.

    .OUTPUTS
    Return Domain Example:     WidgetLLC.Internal
#>  
#==============================  
[CmdletBinding()]
Param(
    [Parameter()]
    [bool[]]
    $writehost = $true # Don't want to writeout if called by other function
) # End Param-------------------------------


    # Gather the local Domain
    $domain = Get-ADDomain -Current LocalComputer  | Select-Object -ExpandProperty DNSRoot 

    
    If ($writehost -eq $true) { # Only write if not called from a sub-function
        Write-Host -ForegroundColor Yellow ("`n------------------`nDomain:  ")
    } #End If-------------------------------


    return $domain

} #End Function Get-GPOsDomain
#==============================

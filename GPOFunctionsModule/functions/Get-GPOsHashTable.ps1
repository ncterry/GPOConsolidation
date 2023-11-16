




Function Get-GPOsHashTable {
<#
    .SYNOPSIS
    Create a hash table for fast GPO lookups later in the report. Only used as a sub-function

    .DESCRIPTION
    No Parameters. Simply returns all GPOS in a hash form
    This is not usable to be returned without pre-hashtable code waiting for it.

    .Example
    Get-GPOsHashTable

    .OUTPUTS
    No viewable returns. Used for function data.

#> 
    #===============================
    # Pick a DC to target
    $dc = Get-GPOsDomainController


    # Grab a list of all GPOs
    $GPOs = Get-GPO -All -Server $dc | Select-Object ID, Path, DisplayName, GPOStatus, WMIFilter, CreationTime, ModificationTime, User, Computer

    
    # Hash table key is the policy path which will match the gPLink attribute later.
    # Hash table value is the GPO object with properties for reporting.
    $gpoHashTable = @{}
    ForEach ($GPO in $GPOs) {
        $gpoHashTable.Add($GPO.Path,$GPO)
    } # End ForEach


    return $gpoHashTable

} #End Function Get-GPOsHashTable



Function Get-AllGPOsNamesNumbered {
<#
    .SYNOPSIS
    From the Domain Controller, this collects the associated Group Policy Objects names

    .DESCRIPTION
    No Parameters. Simply returns a list of the names of all GPOS, but numbered in alphabetical order.

    .Example
    Get-AllGPOsNamesNumbered

    .Example
    Get-AllGPOsNamesNumbered | Out-Gridview

    .OUTPUTS
    (SAMPLE List)
    1) abc_GPO123
    2) def_GPO456
    3) ghi_GPO789
    -------------------------------
#> 

        # Just grab the DNSroot name, (full domain example: WidgetLLC2.Internal).
        $domain = Get-GPOsDomain -writehost $false #$false=Dont print to terminal 
        $allGPOs = Get-GPO -All -Domain $domain #Grab all GPOs on this domain.

        # This just grabs/displays the GPO display names
        $gpoNameArray = @()

        # Add names from Get-GPO collection
        $allGPOs | ForEach-Object {
            $gpoNameArray += $_.DisplayName 
        } # End $allGPOs | ForEach-Object-------------------------------


        # Simple sort in alphabetical order
        $sortedNameArray = $gpoNameArray | Sort-Object


        # For user view, add numbers before names. This is just a viewing list to see all GPOs
        $finalNameArray = @()
        $arrayPos = 0
        ForEach ($name in $sortedNameArray) {
            $arrayPos++
            $finalNameArray += "$arrayPos`) $name"
        } # End ForEach ($name in $sortedNameArray)-------------------------------

    
        return $finalNameArray
    
    } # End Function Get-AllGPOsNamesNumbered-------------------------------
    #============================
    
    
    

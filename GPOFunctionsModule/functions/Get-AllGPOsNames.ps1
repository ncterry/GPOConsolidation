

Function Get-AllGPOsNames {
<#
    .SYNOPSIS
    From the Domain Controller, this collects the associated Group Policy Objects names

    .DESCRIPTION
    No Parameters. Simply returns a list of the names of all GPOS

    .Example
    Get-AllGPOsNames

    .Example
    Get-AllGPOsNames | Out-Gridview

    .OUTPUTS
    (SAMPLE List)
    abc_GPO123
    def_GPO456
    ghi_GPO789
    -------------------------------
#> 

    # Just grab the DNSroot name, (full domain example: WidgetLLC2.Internal).
    $domain = Get-GPOsDomain -writehost $false #$false=Dont print to terminal 


    $allGPOs = Get-GPO -All -Domain $domain #Grab all GPOs on this domain.
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    $gpoNameArray = @()

    
    # Add all gpo names to an array
    $allGPOs | ForEach-Object {
        $gpoNameArray += $_.DisplayName 
    } # End $allGPOs | ForEach-Object-------------------------------


    # Simple array sort in alphabetical order
    $finalNameArray = $gpoNameArray | Sort-Object


    #Slight delay. Sometimes Moves too fast when returning in loops.
    Start-Sleep -s 0.5 

    return $finalNameArray

} # End Function Get-AllGPOsName-------------------------------
#============================



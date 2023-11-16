
Function Get-SingleGPOname {
<#
    .SYNOPSIS
    Many options need the user to choose a GPO(name) This is a single function to do that.

    .DESCRIPTION
    Simply returns a name of a chosen GPO to be used for other functions.
    Parameter is used to tell user what we are chosing the name for.

    .Example
    Get-SingleGPOname -gpoUseStatement "MERGE"
    # Output:   Pick Which existing GPO to MERGE
    # This can be any string.


    .OUTPUTS
    abc_GPO123

#> 
Param(
    [Parameter(Mandatory = $true)]
    [string] 
    $gpoUseStatement # String to print what the intention of the info request is for.
) # End Param-----------------------------------

    
    $gpoNamesArray = Get-AllGPOsNames    # Just for the user to see what GPOs exist.
    $gpoChoice = 0 # Default break value
    $arrayCount = $gpoNamesArray.count # Used for later display of GPO selection
    $gpoName = ""   # Gather a target GPO in the domain of the user
    $domain = Get-GPOsDomain -writehost $false


    # Let user pick initial GPO to get policies/preferences/links from, and confirm choice
    do {

        Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
        Clear-Host
        # Show user the GPOs to Choose From
        Write-Host -ForegroundColor Yellow ("-------------------`n$domain : List of Current GPO Display Names: `n-------------------`n")
        $list = Get-AllGPOsNamesNumbered
        $list | ForEach-Object {Write-Host($_)}


        # Selective statement if function/parameter used to gather GPO to import FROM
        Write-Host("`n---`nEnter: 0 to Return to Prior Menu")
        Write-Host -ForegroundColor Yellow ("Pick Which existing GPO to $gpoUseStatement")
        $gpoChoice = Read-Host ("Number 1 - $arrayCount")
        
        
        If ($gpoChoice -eq 0) {break}
        # If user want's first, and there is only one in the list
        If (($gpoChoice -eq 1) -AND ($arrayCount -eq 1)) {
            $gpoName = $gpoNamesArray
        } # End if-----------------------------------


        # If there is more than 1 choice available
        If (($gpoChoice -in 1..$arrayCount) -AND ($arrayCount -gt 1)) {
            # If position choice is in the range, apply that to get correct GPO name from array
            $gpoName = $gpoNamesArray[$gpoChoice - 1] # Drop 1 int to account for array position
        } Else {
            # Improper choice, null in order to restart do loop
            $gpoChoice = $null
            $gpoName = $null
        }# End If/ElseIf-----------------------------------
        
        
        # Secondary confirmation that the associated GPO name is active. (safety check)
        If ($gpoName -IN $gpoNamesArray) {
            Write-Host -ForegroundColor Yellow ("`nChosen GPO name:  `'$gpoName`'")
            Write-Host ("Is this existing GPO correct?")
            $confirm = Read-Host ("(y/n)")
            $confirm = $confirm -replace '\s', ''     #In case user enter spaces
            $confirm = $confirm.ToLower()             #In case user uses any capitol letters.
        } # End IF-----------------------------------
        
        
    } until ($confirm -eq "y" -OR $confirm -eq "yes")
     # Returns a zero so calling function will also know to break
     If ($gpoChoice -eq 0) {
         return $gpoChoice
    } Else {
        return $gpoName
    } # End If/Else-----------------------------------

    
} # End Function Get-SingleGPOname-----------------------------------
#============================

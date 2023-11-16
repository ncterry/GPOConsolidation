
Function Set-NewEmptyGPO {
<#
    .SYNOPSIS
    Create a new GPO with no initial settings, with a user provided name and comment.


    .DESCRIPTION
    Input the name of a GPO
    This collects all settings from that GPO both Policies and Preferences
    Exports this settings to an HTML that can be viewed in any browser.


    .EXAMPLE
    > Set-NewEmptyGPO
    # This will need user input in the function for GPO name etc.

    .EXAMPLE
    > Set-NewEmptyGPO -nameParam "newGPOnameX"
    # This will create a new empty gpo with that name, assuming that name does not already exist as a GPO

#>
[CmdletBinding()]
Param(
    [Parameter()]
    [string]
    $nameParam
) #End Param-----------------------------------


    $gpoNameArray = Get-AllGPOsNames            # Used to compare duplicate names
    $numberedArray = Get-AllGPOsNamesNumbered   # Just for the user to see what GPOs exist.
    $domain = Get-GPOsDomain -writehost $false    
    $gpoName, $confirm = ""  # Gather a target GPO in the domain of the user


    Write-Host("test1")
    # If user sends in name param or else get name here.
    If (($nameParam -ne "") -AND ($nameParam -notin $gpoNamesArray))  {
        $gpoName = $nameParam
    } Else {
        do {            
            # Do not continue until user GPO does not match one that already exists.
            Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
            Clear-Host
            Write-Host -ForegroundColor Yellow ("`n$domain : List of Current GPO Display Names: `n----------------`n")
            Write-Output($numberedArray)         # Display GPO names
            Write-Host("`n`n-------------`nEnter 0 to return to Menu")
            Write-Host -ForegroundColor Yellow ("Enter the name of the new GPO. `nRepeat names are not accepted.")
            $gpoName = Read-Host (" ")
            $gpoName = $gpoName.Trim()   # Remove top/bottom spaces


            If ($gpoName -NotIn $gpoNameArray -and $gpoName -ne '0' -and $gpoName -ne "") {
                Write-Host -ForegroundColor Yellow ("`nIs this new GPO name correct:   `'$gpoName`' ")
                $confirm = Read-Host "(y/n)"
                $confirm = $confirm -replace '\s', ''     #In case user enter spaces
                $confirm = $confirm.ToLower()             #In case user uses any capitol letters.
                If ($confirm -eq "yes") {$confirm = "y"}
                If ($confirm -eq "no") {$confirm = "n"}
            } # End If--------------------------------------
            
        } until ($confirm -eq 'y' -or $gpoName -eq '0') 
    } # End If.Else
    If ($gpoName -eq '0'){break}


    # If user sends in name param or else get name here.
    If (($nameParam -ne "") -AND ($nameParam -notin $gpoNamesArray)) {
        $gpoComment = "`nCreated by Set-NewEmptyGPO"
    } Else {
        # Only reach comment if name is acceptable
        Write-Host -ForegroundColor Yellow ("`nEnter a descriptor comment for new GPO `'$gpoName`' ")
        $gpoComment = Read-Host " "
        $gpoComment = $gpoComment + " Created by Set-NewEmptyGPO"
    } # End If/Else
    

    # Create blank GPO, with just a name and comment.
    New-GPO -Name $gpoName -Comment $gpoComment  # Create the blank GPO


    Find-AllGPOSettings -sourceGPOParam $gpoName # Display new GPO and full/blank settings from xml doc. 


} #End Function Set-NewEmptyGPO--------------------------------------
#--------------------------------------------------------------------

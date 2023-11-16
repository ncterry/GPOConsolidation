Function Set-GPOsCopy {
<#
    .SYNOPSIS
    Create a new GPO as a copy of an existing GPO
    GPO1 exists, and a temporary backup of GPO1 will be created.
    Create GPO2, import all setting from GPO1 into GPO2
    GPO2 will have all of the policies, preferences, and links (if they exist)


    .EXAMPLE
    Set-GPOsCopy
    # Confirmation and choices can be done through the function.

    .EXAMPLE
    Set-GPOsCopy -sourceGPOname "gpo1A" -destGPOname "gpo2B"
    # Add source and destination GPOs will bypass asking in the function.

#>
#======================================
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $false)]
    [String]
    $sourceGPOparam,
    [Parameter(Mandatory = $false)]
    [String]
    $destGPOparam
) # End Param--------------------------------------


    $destGPONamesArray = Get-AllGPOsNames    # Just for the user to see what GPOs exist.
    $domain = Get-GPOsDomain -writehost $false    
    $destGPOName = ""   # Gather a target GPO in the domain of the user
    $arrayPos, $sourceGPOChoice = 0
    $sourceGPOName, $sourceGPONameConfirm, $sourceGPOChosen, $confirm = ""
        
    
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # $PSScriptRoot only works by executing the script. Selective execution(F8) will not be successful.
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.


    # If user sent in source GPO name through function vs need to pick it here.
    If($sourceGPOparam -eq "") {
        $settingsChoice1 = Get-SingleGPOName -gpoUseStatement "copy FROM"
        $sourceGPOName = $settingsChoice1
    } Else {
        $sourceGPOName = $sourceGPOparam
    } # End IF/Else--------------------------------------
    If($settingsChoice1 -eq 0) {break} # Allow user to return to previous menu
    

    # Now we have the target GPO backup, now we need the new GPO name
    # New GPO, and it cannot conflict with current GPO names
    # Do not continue until user new GPO name input does not match one that already exists.
    do {  
        Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear          
        Clear-Host
        $confirm = "n"
        Write-Host -ForegroundColor Yellow ("`n$domain : List of Current GPO Display Names: `n----------------`n")
        Get-AllGPOsNamesNumbered         # Display GPO names
        Write-Warning("`n`nNew GPO name must be different than all existing GPO names.`nImporting From: `nGPO:  `'$sourceGPOName`'")
        Write-Output ("---`nEnter  0  To Return to Previous Menu ")

        
        do {
            # If users did not send in a param with destination new gpo name
            If($destGPOparam -eq "") {
                Write-Host -ForegroundColor Yellow ("Enter a new GPO name")
                $destGPOName = Read-Host (" ")
                $destGPOName = $destGPOName.Trim() # Trim any before/after whitespace
                If (($destGPOName -eq "0")) {break}
                If ($destGPOName -in $destGPONamesArray) {
                    Write-Host -ForegroundColor Yellow ("GPO Name already Exists")
                    Pause # Let user confirm they regognize the error
                } # End If--------------------------------------
            } Else {
                $destGPOName = $destGPOparam
                $destGPOName = $destGPOName.Trim() # Trim any before/after whitespace
                If ($destGPOName -in $destGPONamesArray) {
                    Write-Host -ForegroundColor Yellow ("GPO Name already Exists")
                    Pause # Let user confirm they regognize the error
                } # End If--------------------------------------
            } # End If/Else--------------------------------------
        } Until (($destGPOName -ne "") -AND ($destGPOName -notin $gpoNamesArray))
        

        If (($destGPOName -NotIn $destGPONamesArray) -AND ($destGPOName -ne "") -AND ($destGPOName -ne "0")) {
            Write-Host -ForegroundColor Yellow ("`nIs this name correct:   `'$destGPOName`'")
            $confirm = Read-Host ("(y/n)")
            $confirm = $confirm -replace '\s', ''     #In case user enter spaces
            $confirm = $confirm.ToLower()             #In case user uses any capitol letters.
            If ($confirm -eq "yes") {$confirm = "y"}
            If ($confirm -eq "no") {$confirm = "n"}
        } #End If--------------------------------------
        

    } until ($confirm -eq 'y' -or $destGPOName -eq '0') # End do
    If (($sourceGPONameConfirm -eq "0") -OR ($destGPOName -eq "0")) {break} # End If
    Write-Host("`n`n") # Terminal aesthetics


    # Only reaches comment if name is acceptable
    Write-Host -ForegroundColor Yellow ("`n`nEnter a descriptor comment for $destGPOName")
    $gpoComment = Read-Host (" ")
    $gpoComment = $gpoComment + " Created by Set-CreateGPOFromBackup.ps1"


    # Create the new gpo with name/comment, but is otherwise blank so far.
    New-GPO -Name $destGPOName -Comment "Created by:  Set-CreateGPOFrmBackup.ps1; Settings Imported from: $sourceGPOName. User Comment: $gpoComment"


    # User will provide old GPO(backup with settings), and existing GPO just created( to import settings INTO)
    # Import will overwrite any prior settings. Be careful. Usually Best to use a new, blank GPO
    Get-ImportGPOSingle -sourceGPOParam $sourceGPOName -destGPOParam $destGPOName -createNewGPO $false -ouOverwrite $true


    # Below is just a confirmation for user to view in terminal AFTER the change.
    (Get-GPO -Name $destGPOName).Description


    Write-Host("`n`nNOTE - You may need to RE-OPEN Group Policy Management to refresh the new GPO and associated links.`n")
    Find-AllGPOSettings -sourceGPOParam $destGPOName
    Pause


} #End Function Set-GPOsCopy--------------------------------------
#--------------------------------------

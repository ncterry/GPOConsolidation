Function Set-GPOsOverwrite {
<#
    .SYNOPSIS
    Select an existing source GPO1 to copy full GPO config from.
    Select an exsiting destination GPO2 to overwrite the full GPO config with GPO1 


    .EXAMPLE
    Set-GPOsOverwrite
    # Choose target active GPOs directly through the module.
    

    .EXAMPLE
    Set-GPOsOverwrite -sourceGPOparam "gpo1A" -destGPOparam "gpo2B"
    # State the target active GPOs through the function call. 

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


    do {
        # If user sent in source GPO name through function vs need to pick it here.
        If($sourceGPOparam -eq "") {
            $settingsChoice1 = Get-SingleGPOName -gpoUseStatement "copy FROM"
            $origGPOname = $settingsChoice1
        } Else {
            $origGPOname = $sourceGPOparam
        } # End IF/Else--------------------------------------
        If($settingsChoice1 -eq 0) {break} # Allow user to return to previous menu
        

        # Let user choose which existing GPO to import INTO, and confirm.
        # Allow user to return to previous menu
        do {
            If($destGPOparam -eq "") {
                $settingsChoice2 = Get-SingleGPOName -gpoUseStatement "copy INTO"
                $newGPOname = $settingsChoice2
            } Else {
                $newGPOname = $destGPOparam
            } # End If/Else--------------------------------------

            # Check for user exit request
            If($settingsChoice2 -eq 0) { # This break is duplicated outside of this do also.
                break 
            # Compare GPO1 to GPO2. Cannot be the same.
            } ElseIf ($origGPOname -eq $newGPOname) {
                Write-Host("`nYou cannot choose the same GPO name")
                $confirm2 = "n"
                Pause # Pause to make sure user knows, before the loop resets.

            # Checks have passed, make last confirmation with user.
            } Else {
                do {
                    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
                    Clear-Host
                    Write-Warning("`n----------------------`nFinal GPO Confirmation`n----------------------")
                    Write-Host -ForegroundColor Yellow ("Source GPO:  `'$origGPOname`' `nIs this GPO correct to copy FROM? ")
                    $confirm1 = Read-Host "(y/n)"
                    $confirm1 = $confirm1 -replace '\s', ''     #In case user enter spaces
                    $confirm1 = $confirm1.ToLower()             #In case user uses any capitol letters.
                    If ($confirm1 -eq "yes") {$confirm1 = "y"}
                    If ($confirm1 -eq "no") {$confirm1 = "n"}
                } Until (($confirm1 -eq "y") -OR ($confirm1 -eq "n"))
                If($confirm1 -eq "n") {break}
                do {
                    Write-Host -ForegroundColor Yellow ("`nDestination GPO:  `'$newGPOname`' `nIs this GPO correct to copy INTO? ")
                    $confirm2 = Read-Host ("(y/n)")
                    $confirm2 = $confirm2 -replace '\s', ''     #In case user enter spaces
                    $confirm2 = $confirm2.ToLower()             #In case user uses any capitol letters.
                    If ($confirm2 -eq "yes") {$confirm2 = "y"}
                    If ($confirm2 -eq "no") {$confirm2 = "n"}

                } Until (($confirm2 -eq "y") -OR ($confirm2 -eq "n"))
                If($confirm2 -eq "n") {break}                        
            } # End If/Else--------------------------------------


            # Final loop check that all choices/actions are appropriate to continue
        } until (($confirm1 -eq "y" -OR $confirm1 -eq "yes") -AND ($confirm2 -eq "y" -OR $confirm2 -eq "yes"))
        # This will allow to break out of the switch loop if user chose 0
        If($settingsChoice2 -eq 0) {break} # Allow user to return to previous menu


    } Until (($origGPOname -ne $newGPOname) -AND $confirm1 -eq "y" -AND $confirm2 -eq "y") # End do1
    If($settingsChoice1 -eq 0 -OR $settingsChoice2 -eq 0) {break} # Allow user to return to previous menu


    # Function created to visualy compare the OUs in to GPOs, so user can chose to overwrite or add together
    Get-CompareTwoGPOsOUs -sourceGPOParam $origGPOname -destGPOParam $newGPOname


    # We are bringing settings from GPO1 into GPO2. General settings all overwrite
    # Do we want to overwrite OU links, or merge OU links together.
    [string]$ouOverwrite = "" # This is a pseudo boolean
    Write-Warning("`nDo you want to:")
    Write-Host("`t1) Overwrite existing OU links in GPO `'$newGPOname`'")
    Write-Host("`t2) Add GPO `'$origGPOname`'s OU links to existing OU links in GPO `'$newGPOname`'")
    Write-Host("`t3) Keep GPO `'$newGPOname`'s OU Links without any change")
    Write-Host("-----------`n(1, 2 or 3)")
    

    do {
        $ouConfirm = Read-Host "Choice = "
        If ($ouConfirm -eq 1) {
            # Overwrite new gpos with old
            $ouOverwrite = "true"
        } ElseIf ($ouConfirm -eq 2){
            # Add old OUs on top of existing OUs
            $ouOverwrite = "false"
        } Else {
            # Do nothing, keep exisint GPO OUs
            $ouOverwrite = "null"   
        }# End If Else--------------------------------------

    } Until ($ouConfirm -eq 1 -or $ouConfirm -eq 2 -or $ouConfirm -eq 3 )



    # All checks and confirmations have passed
    # Backup gpo1, import settings from backup into gpo2. DO NOT create new GPO
    Get-ImportGPOSingle -sourceGPOParam $origGPOname -destGPOParam $newGPOname -createNewGPO $false -ouOverwrite $ouOverwrite


    # Module to gather and display all of target GPO settings
    Find-AllGPOSettings -sourceGPOParam $newGPOname            
    Pause


} #End Function Set-GPOsOverwrite--------------------------------------
#--------------------------------------

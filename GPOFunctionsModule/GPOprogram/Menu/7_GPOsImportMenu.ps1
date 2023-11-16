# Primary program run from '\GPOFunctionsModule\RunGPOProgram\'
# .\RunGPOProgram.ps1
#
# This GPO listing escalation can be run on its own, with all options.
# .\7_GPOsImportMenu.ps1
#-------------------------------------------------
# Function to show the main menu
function Get-GPOsImportMenu {

    Write-Host("
|======================================================================|
|====================--- Import GPO Settings  ---======================|
|======================================================================|`n")
    #
    Write-Host(" Selections:
------------------------------------------------------------------------")
    #
    Write-Host -ForegroundColor Yellow ("`n   1) COPY: GPO1 Exists; Create GPO2; `t`t`tEnter: 1")
    Write-Host("      (Copy settings from GPO1 into GPO2) ")
    Write-Host -ForegroundColor Yellow ("`n   2) Overwrite: GPO1 exists; GPO2 Exists; `t`tEnter: 2")
    Write-Host("      (Overwrite settings from GPO1 into GPO2) ")
    Write-Host -ForegroundColor Yellow ("`n   3) IMPORT: GPO1 Exists; Backup Exists; `t`tEnter: 3")
    Write-Host("      (Import settings from backup into GPO1) ")
    Write-Host -ForegroundColor Yellow ("`n   4) CREATE a new GPO from a backup; `t`t`tEnter: 4")
    Write-Host("      (New GPO name cannot exist in current GPOs) ")
    Write-Host -ForegroundColor Yellow ("`n   5) Create\Overwrite All GPOs from a full backup; `tEnter: 5")
    Write-Host("      (Create\Overwrite if GPO name DNE\Exists) ")
    #
    #
    Write-Host("`n------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   0) Return to Prior Menu `t`t`t`tEnter: 0`n")
    Write-Host("------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   HELP   - Enter the number + h  (1h, 2h, 3h...) `tEnter: `'#h`'`n")
    Write-Host -ForegroundColor Red ("   QUIT   - End the GPO Program `t`t`tEnter: `'quit`'`n") 
    Write-Host("------------------------------------------------------------------------")
} # END Get-GPOsImportMenu function 

#--------------------------------
# Continuing do loop unless quit
do {

    # Clearpage, write out menu, gather user input, account for simple user errors. 
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    Get-GPOsImportMenu                       # Write this menu (function)
    
    $choice = Read-Host "`nEnter Choice"    # Ask user for menu choice
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    $choice = $choice -replace '\s', ''     # In case user enter spaces
    $choice = $choice.ToLower()             # In case user uses any capitol letters.
    
    $gpoNamesArray = Get-AllGPOsNames # Grab all GPOs on this domain.
    $settingsChoice1, $settingsChoice2 = 0
    $origGPOname = ""   # GPO name to backup and merge FROM:
    $newGPOname = ""    # GPO name to backup and merge INTO:


    # If User input is acceptable, pick from switch list.
    switch ($choice) 
    {
        '1' 
        {
            # Let user pick initial GPO name to get policies/preferences/links from, and confirm choice
            $settingsChoice1 = Get-SingleGPOName -gpoUseStatement "import FROM"
            If($settingsChoice1 -eq 0) {break} # Allow user to return to previous menu


            # Let user enter name for a GPO to be created, and confirm
            do {
                Write-Output ("---`nEnter  0  To Quit and Return to Previous Menu ")
                Write-Warning("New GPO name must be different that all existing GPO names.")  
                do {
                    $newGPOname = Read-Host "Enter a new GPO name"
                    $newGPOname = $newGPOname -replace '\s', ''     #In case user enter spaces
                } until ($newGPOname -ne "") # Dont allow nothing
                
                

                If($newGPOname -eq "0") {break}
                If($newGPOname -in $gpoNamesArray) {
                    Write-Error("New GPO name must be different than all existing GPO names.")
                    $confirm2 = "n"     # Safety change to prevent loop end
                } Else {
                    Write-Host -ForegroundColor Yellow ("`nNew GPO name: $newGPOname `nIs the new GPO name correct? ")
                    $confirm2 = Read-Host "(y/n)"
                    $confirm2 = $confirm2 -replace '\s', ''     # In case user enter spaces
                    $confirm2 = $confirm2.ToLower()             # In case user uses any capitol letters.
                } # End If/Else
                
            # Switch loops until user confirms their input or breaks out
            } until ($confirm2 -eq 'y' -or $confirm2 -eq "yes")
            If($newGPOname -eq "0") {break}


            # Confirmed the sourceGPO, and the new GPO Name, now this will:
            # Create new gpo, backup old gpo, import setting from backup, then import OU links. 
            # Since the target is a new GPO, we overwrite all OUs, which are blank anyway.
            Get-ImportGPOSingle -sourceGPOParam $settingsChoice1 -destGPOParam $newGPOname -createNewGPO $true -ouOverwrite $true
            
            
            # Module to gather and display all of target GPO settings
            Find-AllGPOSettings -sourceGPOParam $newGPOname
            Pause

        } # END '1'
        #------------------------------------------------
        '1h' # Help/Information for 1
        {
            Get-GPOFunctionsModuleHelp -section "7.1"
            Pause
        } # End 1h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '2' 
        {
            # Dangerous to do an import, this menu has extensive confirmation.
            do {
                $settingsChoice1 = Get-SingleGPOName -gpoUseStatement "import FROM"
                $origGPOname = $settingsChoice1
                If($settingsChoice1 -eq 0) {break} # Allow user to return to previous menu
                

                # Let user choose which existing GPO to import INTO, and confirm.
                # Allow user to return to previous menu
                do {
                    $settingsChoice2 = Get-SingleGPOName -gpoUseStatement "import INTO"
                    $newGPOname = $settingsChoice2
                    # Check for user exit request
                    If($settingsChoice2 -eq 0) {
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
                            Write-Warning("Final GPO Confirmation")
                            Write-Host -ForegroundColor Yellow ("`nChosen GPO name:  $origGPOname `nIs this GPO correct to import FROM? ")
                            $confirm1 = Read-Host "(y/n)"
                            $confirm1 = $confirm1 -replace '\s', ''     #In case user enter spaces
                            $confirm1 = $confirm1.ToLower()             #In case user uses any capitol letters.
                        } Until (($confirm1 -eq "y") -OR ($confirm1 -eq "n"))
                        If($confirm1 -eq "n") {break}


                        do {
                            Write-Host -ForegroundColor Yellow ("`nChosen GPO name:  $newGPOname `nIs this GPO correct to import INTO? ")
                            $confirm2 = Read-Host "(y/n) "
                            $confirm2 = $confirm2 -replace '\s', ''     #In case user enter spaces
                            $confirm2 = $confirm2.ToLower()             #In case user uses any capitol letters.

                        } Until (($confirm2 -eq "y") -OR ($confirm2 -eq "n"))
                        If($confirm2 -eq "n") {break}                        
                    } # End If/Else


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
            Write-Host("`t`t1) Overwrite existing OU links in GPO `'$newGPOname`'")
            Write-Host("`t`t2) Add GPO `'$origGPOname`'s OU links to existing OU links in GPO `'$newGPOname`'")
            Write-Host("`t`t3) Keep GPO `'$newGPOname`'s OU Links without any change")
            Write-Host("1, 2 or 3")
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
                }# End If Else
            } Until ($ouConfirm -eq 1 -or $ouConfirm -eq 2 -or $ouConfirm -eq 3 )
            


            # All checks and confirmations have passed
            # Backup gpo1, import settings from backup into gpo2. DO NOT create new GPO
            Get-ImportGPOSingle -sourceGPOParam $origGPOname -destGPOParam $newGPOname -createNewGPO $false -ouOverwrite $ouOverwrite
            

            # Module to gather and display all of target GPO settings
            Find-AllGPOSettings -sourceGPOParam $newGPOname            
            Pause

        } #END 2
        #------------------------------------------------
        '2h' # Help/Information for 2
        {
            Get-GPOFunctionsModuleHelp -section "7.2"
            Pause
        } # End 2h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '3' 
        {
            do {
                Clear-Host
                Write-Host -ForegroundColor Yellow ("-----------------------`n0) Return to prior menu`n-----------------------`n1) Pick 1 GPO from target backups `n2) Pick 1 GPO from full backups`n")
                $fullOrSingle = Read-Host ("1 or 2")
                
            } until (($fullOrSingle -eq 0) -OR ($fullOrSingle -eq 1) -OR ($fullOrSingle -eq 2))
            
            If ($fullOrSingle -eq 0) {
                break
            } ElseIf ($fullOrSingle -eq 1) {
                #"This will import settings into a GPO, from a previous backup"
                Set-MergeGPOFromBackup
            } ElseIf ($fullOrSingle -eq 2) {
                #"This will import settings into a GPO, from a previous gpo, in a full backup set"
                Set-MergeGPOFromBackup -fullBackupParam $true
            } # End If/ElseIf
            Pause

        } # End 3
        #------------------------------------------------
        '3h' # Help/Information for 3
        {
            Get-GPOFunctionsModuleHelp -section "7.3"
            Pause
        } # End 3h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '4' 
        {
            #"This will create a brand new GPO, from a previous backup"
            Set-CreateGPOFromBackup
            Pause

        } # End 4      
        #------------------------------------------------
        '4h' # Help/Information for 4
        {
            Get-GPOFunctionsModuleHelp -section "7.4"
            Pause
        } # End 4h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '5' 
        {
            $confirm1, $confirm2, $confirm3 = ""
            # Confirm the users import all
            Write-Warning("`n--------`nThis will create new GPOs for any GPO backup name that is not active, `nand will also overwrite any active GPO with the same name as a backup. `n`nThis is dangerous. `nWe recommend doing a full GPO backup first, so that the current settings `ncan be brought back in, if this full import affects your system.`n`nWould you like a full GPO Backup to be called from here? `nEnter 0 to exit")


            # Loop to let user confirm a current safety backup or exit.
            do {  
                $confirm1 = Read-Host "(y/n)"
                $confirm1 = $confirm1 -replace '\s', ''     # In case user enter spaces
                If($confirm1 -eq 0) {break}
                $confirm1 = $confirm1.ToLower()             # In case user uses any capitol letters. 
                If($confirm1 -eq "yes") {$confirm1 = "y"}
                If($confirm1 -eq "no") {$confirm1 = "n"}
            # Y or N to confirm if user wants a safety backup first
            } until ($confirm1 -eq "y" -OR $confirm1 -eq "n")
            If($confirm1 -eq 0) {break}
            
            
            # Secondary confirmation if user chose to also create a current safety backup
            If ($confirm1 -eq "y") { 
                Write-Host -ForegroundColor Yellow ("`nFinal confirmation. `nThis will create a timestamped backup of the current GPOs. `nThen, after a user selection of a prior GPO backup set, `nit will create new GPOs for any GPO backup name that is not active, `nand will also overwrite any active GPO with the same name. `nConfirm a full GPO safety backup, and then a full prior GPO-backup import? `n`nEnter 0 to exit")
                # Secondary safety confirm
                do {
                    $confirm2 = Read-Host "(y/n)"
                    $confirm2 = $confirm2 -replace '\s', ''     # In case user enter spaces
                    If($confirm2 -eq 0) {break}
                    $confirm2 = $confirm2.ToLower()             # In case user uses any capitol letters.
                    If($confirm2 -eq "yes") {$confirm2 = "y"}
                    If($confirm2 -eq "no") {$confirm2 = "n"}
                } until ($confirm2 -eq "y" -OR $confirm2 -eq "n")
                If($confirm2 -eq 0) {break}
            } # End If 
            If($confirm2 -eq 0) {break}


            # Secondary confirmation if user chose NOT to create a current safety backup
            If ($confirm1 -eq "n") { 
                Write-Host -ForegroundColor Yellow ("`nFinal confirmation. `nThis will NOT create a timestamped backup of the current GPOs. `nThen, after a user selection of a prior GPO backup set, from that set, `nit will create new GPOs for any GPO backup name that is not active, `nand it will also overwrite any active GPO with the same name. `nCan you confirm, DO NOT do a full GPO safety backup, and then do a full GPO backup import? `n`nEnter 0 to exit")
                do {
                    $confirm3 = Read-Host "(y/n)"
                    $confirm3 = $confirm3 -replace '\s', ''     # In case user enter spaces
                    If($confirm3 -eq 0) {break}
                    $confirm3 = $confirm3.ToLower()             # In case user uses any capitol letters.
                    If($confirm3 -eq "yes") {$confirm3 = "y"}
                    If($confirm3 -eq "no") {$confirm3 = "n"}
                } until ($confirm3 -eq "y" -OR $confirm3 -eq "n")
                If($confirm3 -eq 0) {break}
            } # End If 
            If($confirm3 -eq 0) {break}
            

            # User wants a current safety backup of all GPOs and then a full import
            If ($confirm2 -eq "y") {
                Get-ImportGPOsAllBackups -safetyBackup $true
                Pause
            } # End If


            # DANGEROUS - User DOES NOT want a safety backup of all current GPOs, just a full import
            If ($confirm3 -eq "y") {
                Get-ImportGPOsAllBackups -safetyBackup $false
                Pause
            } # End If
        }  # End 5
        #------------------------------------------------
        '5h' # Help/Information for 5
        {
            Get-GPOFunctionsModuleHelp -section "7.5"
            Pause
        } # End 5h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        'quit' 
        {
            $Global:quit = "quit"
            $choice = "0"

        }  # End quit------------------------------------ 
           
    } # END switch()
    
} until (($choice -eq '0'))  #END do()==================

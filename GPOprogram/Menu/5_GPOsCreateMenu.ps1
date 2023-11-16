# Primary program run from '\GPOFunctionsModule\GPOprogram\'
# .\RunGPOProgram.ps1
#
# This GPO creator can be run on its own, with all options.
# .\5_GPOsCreateMenu.ps1
#-------------------------------------------------
#Function to show the main menu
function Get-GPOsCreateMenu {

    Write-Host("
|======================================================================|
|=========================--- Create GPOs ---==========================|
|======================================================================|`n")
    #
    Write-Host(" Selections:
------------------------------------------------------------------------")
    #
    Write-Host -ForegroundColor Yellow ("`n   1) Create a New Blank GPO `t`t`t`tEnter: 1")
    Write-Host -ForegroundColor Yellow ("`n   2) Create a New GPO, from a Backup `t`t`tEnter: 2")
    Write-Host -ForegroundColor Yellow ("`n   3) Create a New GPO, from a GPO Copy `t`tEnter: 3")
    Write-Host -ForegroundColor Yellow ("`n   4) Overwrite GPO1 with Existing GPO2 `t`tEnter: 4 ")
    Write-Host -ForegroundColor Yellow ("`n   5) Open Group Policy Management Console `t`tEnter: 5")
    Write-Host -ForegroundColor Yellow ("`n   6) WARNING: Delete a GPO `t`t`t`tEnter: 6 ")
    #
    #
    Write-Host("`n------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   0) Return to Prior Menu `t`t`t`tEnter: 0`n")
    Write-Host("------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   HELP   - Enter the number + h  (1h, 2h, 3h...) `tEnter: `'#h`'`n")
    Write-Host -ForegroundColor Red ("   QUIT   - End the GPO Program `t`t`tEnter: `'quit`'`n") 
    Write-Host("------------------------------------------------------------------------")
}# END Get-GPOsCreateMenu Function

#--------------------------------
# Continuing do loop unless quit
# quit will resort back to the main menu unless program is executed directly by ./1_CreateGPOsMenu.ps1
do {
    # Clearpage, write out menu, gather user input, account for simple user errors. 
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    Get-GPOsCreateMenu #Write this menu (function)
    
    $choice = Read-Host "`nEnter Choice"   #Ask user for menu choice
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    $choice = $choice -replace '\s', ''     #In case user enter spaces
    $choice = $choice.ToLower()             #In case user uses any capitol letters.

    # If User input is acceptable, pick from switch list.
    switch ($choice) 
    {
        '1' 
        {
            #"This will create a brand new GPO, that is blank and can be added-to/merged-with later."
            Set-NewEmptyGPO
            Pause

        } # End 1
        #------------------------------------------------
        '1h' # Help/Information for 1
        {
            Get-GPOFunctionsModuleHelp -section "5.1"
            Pause
        } # End 1h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '2' 
        {
            #"This will create a brand new GPO, from a previous backup"
            Set-CreateGPOFromBackup
            Pause

        } # End 2
        #------------------------------------------------
        '2h' # Help/Information for 2
        {
            Get-GPOFunctionsModuleHelp -section "5.2"
            Pause
        } # End 2h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------        
        '3' 
        {
            # Create a new GPO as an exact copy of another GPO, with a new name
            Set-GPOsCopy

        } # End 3
        #------------------------------------------------
        '3h' # Help/Information for 3
        {
            Get-GPOFunctionsModuleHelp -section "5.3"
            Pause
        } # End 3h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------        
        '4' 
        {
            # This GPO copy will copy GPO policies, preferences, and OU links from GPO1 into GPO2
            Set-GPOsOverwrite

        } # End 4
        #------------------------------------------------
        '4h' # Help/Information for 4
        {
            Get-GPOFunctionsModuleHelp -section "5.4"
            Pause
        } # End 4h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '5' 
        {
            gpmc.msc # Open the Group Policy Mangement Console
            Pause

        } # End 5
        #------------------------------------------------
        '5h' # Help/Information for 5
        {
            Get-GPOFunctionsModuleHelp -section "5.5"
            Pause
        } # End 5h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '6' 
        {
            Set-DeleteSingleGPO
            Pause

        } # End 6
        #------------------------------------------------
        '6h' # Help/Information for 6
        {
            Get-GPOFunctionsModuleHelp -section "5.6"
            Pause
        } # End 6h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        'quit' 
        {
            $Global:quit = "quit"
            $choice = "0"
        } # End quit------------------------------------------------        
    }#END switch()
    
} until (($choice -eq '0'))  #END do()==================

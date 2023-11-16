# Primary program run from '\GPOFunctionsModule\RunGPOProgram\'
# .\RunGPOProgram.ps1
#
# This GPO listing escalation can be run on its own, with all options.
# .\2_GPOsInfoMenu.ps1
#-------------------------------------------------
# Function to show the main menu
function Get-GPOsInfoMenu {
    Write-Host("
|======================================================================|
|========================--- Current GPOs ---==========================|
|======================================================================|`n")
    #
    Write-Host(" Selections:
------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow (" `n   1) View All GPOs Display Names `t`t`tEnter: 1 ")
    Write-Host -ForegroundColor Yellow ("`n   2) View All GPOs Summary Info (Terminal) `t`tEnter: 2  ")
    Write-Host -ForegroundColor Yellow ("`n   3) View All GPOs Summary Info (Gridview) `t`tEnter: 3  ")    
    Write-Host -ForegroundColor Yellow ("`n   4) View Single GPO Full Configuration `t`tEnter: 4")
    #
    #
    Write-Host("`n------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   0) Return to Prior Menu `t`t`t`tEnter: 0`n")
    Write-Host("------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   HELP   - Enter the number + h  (1h, 2h, 3h...) `tEnter: `'#h`'`n")
    Write-Host -ForegroundColor Red ("   QUIT   - End the GPO Program `t`t`tEnter: `'quit`'`n") 
    Write-Host("------------------------------------------------------------------------")
} # END function Get-GPOsInfoMenu Function

#--------------------------------
# Continuing do loop unless quit
# quit will resort back to the main menu unless program is executed directly by ./1_KeywordSearchMenu.ps1
do
{
    # Clearpage, write out menu, gather user input, account for simple user errors. 
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    Get-GPOsInfoMenu # Write this menu (function)
    
    $choice = Read-Host "`nEnter Choice"    # Ask user for menu choice
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    $choice = $choice -replace '\s', ''     # In case user enter spaces
    $choice = $choice.ToLower()             # In case user uses any capitol letters.

    # If User input is acceptable, pick from switch list.
    switch ($choice) 
    {
        '1' 
        {
            $domain = Get-GPOsDomain -writehost $false
            # Show user the GPOs to Choose From
            Write-Host -foregroundcolor Yellow ("`n$domain : List of Current GPO Display Names: `n----------------`n")
            Get-AllGPOsNamesNumbered
            Write-Output("`n")
            Pause

        } # END 1
        #------------------------
        '1h' # Help/Information for 1
        {
            Get-GPOFunctionsModuleHelp -section "2.1"
            Pause

        } # End 1h
        #------------------------  
        #------------------------  
        #------------------------        
        '2' 
        {
            # Module created to gather all primary information summary on all local GPOs
            # Deep GPO information on all GPOs, printed to terminal and saved to the file
            Get-AllGPOsSummary -gridview $false #module that is imported when this program is run
            Write-Output "--------------"
            Pause

        } # END 2
        #------------------------  
        '2h' # Help/Information for 2
        {
            Get-GPOFunctionsModuleHelp -section "2.2"
            Pause

        } # End 2h
        #------------------------  
        #------------------------  
        #------------------------
        '3' 
        {
            # Module created to gather all primary information summary on all local GPOs
            # Deep GPO information on all GPOs, printed to gridview and saved to the file
            Get-AllGPOsSummary -gridview $true #module that is imported when this program is run
            Write-Output "--------------"
            Pause

        } # END 3
        #------------------------  
        '3h' # Help/Information for 3
        {
            Get-GPOFunctionsModuleHelp -section "2.3"
            Pause

        } # End 3h
        #------------------------  
        #------------------------  
        #------------------------           
        '4' 
        {               
            $targetGPO = Get-SingleGPOname -gpoUseStatement "view full configuration of"
            If ($targetGPO -eq 0) {break}
            # Module created to gather and display all of target GPO settings
            Find-AllGPOSettings -sourceGPOParam $targetGPO
            Pause

        } # END 4
        #------------------------ 
        '4h' # Help/Information for 4
        {
            Get-GPOFunctionsModuleHelp -section "2.4"
            Pause

        } # End 4h
        #------------------------  
        #------------------------  
        #------------------------ 
        'quit' 
        {
            $Global:quit = "quit"
            $choice = "0"
        }        
    }#END switch()
    
} until (($choice -eq '0'))  #END do()==================


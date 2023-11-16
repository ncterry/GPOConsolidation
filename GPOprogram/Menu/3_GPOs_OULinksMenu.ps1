
# Primary program run from '\GPOFunctionsModule\RunGPOProgram\'
# .\RunGPOProgram.ps1
#
# This GPO listing escalation can be run on its own, with all options.
# .\3_GPOs_OULinksMenu.ps1
#-------------------------------------------------
# Function to show the main menu
function Get-GPOs_OULinksMenu {
    Write-Host("
|======================================================================|
|========================--- OU/GPO Links ---==========================|
|======================================================================|`n")
    #
    Write-Host(" Selections:
------------------------------------------------------------------------")
    #
    Write-Host -ForegroundColor Yellow ("`n View Organizational Units with Linked GPOs")
    Write-Host -ForegroundColor Yellow ("   1) Terminal`t`t`t`t`t`tEnter: 1")
    Write-Host -ForegroundColor Yellow ("   2) Gridview`t`t`t`t`t`tEnter: 2")

    Write-Host -ForegroundColor Yellow ("`n View Organizational Units for a Target GPO")
    Write-Host -ForegroundColor Yellow ("   3) Terminal`t`t`t`t`t`tEnter: 3")
    Write-Host -ForegroundColor Yellow ("   4) Gridview`t`t`t`t`t`tEnter: 4")

    Write-Host -ForegroundColor Yellow ("`n View All GPOs with Linked Status")
    Write-Host -ForegroundColor Yellow ("   5) Terminal`t`t`t`t`t`tEnter: 5")
    Write-Host -ForegroundColor Yellow ("   6) Gridview`t`t`t`t`t`tEnter: 6")

    Write-Host -ForegroundColor Yellow ("`n View GPOs Linked to a Target OU")
    Write-Host -ForegroundColor Yellow ("   7) Terminal`t`t`t`t`t`tEnter: 7")
    Write-Host -ForegroundColor Yellow ("   8) Gridview`t`t`t`t`t`tEnter: 8")

    Write-Host -ForegroundColor Yellow ("`n`n   9) Compare Organizational Units of 2 GPOs `t`tEnter: 9")
    #
    #
    Write-Host("`n------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   0) Return to Prior Menu `t`t`t`tEnter: 0`n")
    Write-Host("------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   HELP   - Enter the number + h  (1h, 2h, 3h...) `tEnter: `'#h`'`n")
    Write-Host -ForegroundColor Red ("   QUIT   - End the GPO Program `t`t`tEnter: `'quit`'`n") 
    Write-Host("------------------------------------------------------------------------")
} # END Menu function 

#--------------------------------
# Continuing do loop unless quit
do {
    # Clearpage, write out menu, gather user input, account for simple user errors. 
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    Get-GPOs_OULinksMenu                     # Write this menu (function)
    
    $choice = Read-Host "`nEnter Choice"    # Ask user for menu choice
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    $choice = $choice -replace '\s', ''     # In case user enter spaces
    $choice = $choice.ToLower()             # In case user uses any capitol letters.

    # If User input is acceptable, pick from switch list.
    switch ($choice) 
    {
        '1' # Gather and display all OUs that have been linked to GPOs
        {
            Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
            Clear-Host
            Get-LinkedOUsAll -gridview $false

        } # END 1----------------
        #------------------------
        '1h' # Help/Information for 1
        {
            Get-GPOFunctionsModuleHelp -section "3.1"
            Pause

        } # End 1h---------------------------------------
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------         
        '2' # Gather and display all OUs that have been linked to GPOs in gridview
        {
            Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
            Clear-Host
            Get-LinkedOUsAll -gridview $true

        } # END 2----------------
        #------------------------
        '2h' # Help/Information for 2
        {
            Get-GPOFunctionsModuleHelp -section "3.2"
            Pause

        } # End 2h---------------------------------------
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------        
        '3' # OU links for a target GPO displayed in terminal
        {
            $gpoName = Get-SingleGPOname -gpoUseStatement "view linked OUs"
            # Should return gpo name, but allow for break also
            If ($gpoName -eq 0) {break}
            Write-Host("`n`n") # Terminal aesthetics
            Get-LinkedOUsSpecific  -gridview $false -gpoName $gpoName

        } # END 3----------------
        #------------------------
        '3h' # Help/Information for 3
        {
            Get-GPOFunctionsModuleHelp -section "3.3"
            Pause

        } # End 3h---------------------------------------
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '4' # OU links for a target GPO displayed in gridview
        {
            $gpoName = Get-SingleGPOname -gpoUseStatement "view linked OUs"
            # Should return gpo name, but allow for break also
            If ($gpoName -eq 0) {break}
            Write-Host("`n`n")      # Terminal aesthetics
            Get-LinkedOUsSpecific  -gridview $true -gpoName $gpoName


        } # END 4----------------
        #------------------------
        '4h' # Help/Information for 4
        {
            Get-GPOFunctionsModuleHelp -section "3.4"
            Pause

        } # End 4h---------------------------------------
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '5' # Choose an OU and display all GPOs linked 
        {
            # View list of gpo with linked status
            Get-UnlinkedGPOs
            Get-UnLinkedGPOs | Format-Table
            Pause

        } # END 5----------------
        #------------------------
        '5h' # Help/Information for 5
        {
            Get-GPOFunctionsModuleHelp -section "3.5"
            Pause

        } # End 5h---------------------------------------
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '6' # Choose an OU and display all GPOs linked 
        {
            # View list of gpo with linked status
            Get-UnLinkedGPOs | Out-GridView -Title "Linked Status of all active GPOs"

        } # END 6----------------
        #------------------------
        '6h' # Help/Information for 6
        {
            Get-GPOFunctionsModuleHelp -section "3.6"
            Pause

        } # End 6h---------------------------------------
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '7' # Choose an OU and display all GPOs linked to that OU
        {
            # Let user do repeated OU queries for GPOS until they break out.
            Get-LinkedGPOs | Format-List

        } # END 7----------------
        #------------------------
        '7h' # Help/Information for 7
        {
            Get-GPOFunctionsModuleHelp -section "3.7"
            Pause

        } # End 7h---------------------------------------
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '8' # Choose an OU and display all GPOs linked to that OU in gridview
        {
            # Let user do repeated OU queries for GPOS until they break out.
            Get-LinkedGPOs -gridview $true
                
        } # END 8----------------
        #------------------------
        '8h' # Help/Information for 8
        {
            Get-GPOFunctionsModuleHelp -section "3.8"
            Pause

        } # End 8h---------------------------------------
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '9' # Simple visual comparison of the organizational units between 2 GPOs
        {
            do { 
                $gpo1name = Get-SingleGPOname -gpoUseStatement "view linked OUs (GPO1)"
                If($gpo1name -eq 0) {break}
                $gpo2name = Get-SingleGPOname -gpoUseStatement "view linked OUs (GPO2)"
                If($gpo2name -eq 0) {break}
                Get-CompareTwoGPOsOUs -sourceGPOParam $gpo1name -destGPOParam $gpo2name
                Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
                Clear-Host
                Write-Host -ForegroundColor Yellow ("`n--------------`nCompare another set of GPOs?")
                $confirm = Read-Host "(y/n) "
            } Until ($confirm -eq "n")
                       
        } # END 9----------------      
        #------------------------
        '9h' # Help/Information for 9
        {
            Get-GPOFunctionsModuleHelp -section "3.9"
            Pause

        } # End 9h---------------------------------------
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------        
        'quit' 
        {
            $Global:quit = "quit"
            $choice = "0"
        } # End quit-------------    
    }#END switch()
    
} until (($choice -eq '0'))  #END do()==================






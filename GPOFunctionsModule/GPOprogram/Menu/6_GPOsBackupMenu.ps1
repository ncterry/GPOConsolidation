# Primary program run from '\GPOFunctionsModule\RunGPOProgram\'
# .\RunGPOProgram.ps1
#
# This GPO listing escalation can be run on its own, with all options.
# .\6_GPOsBackupMenu.ps1
#-------------------------------------------------
# Function to show the main menu
function Get-GPOsBackupMenu {

    Write-Host("
|======================================================================|
|========================--- Backup GPOs  ---==========================|
|======================================================================|`n")
    #
    Write-Host(" Selections:
------------------------------------------------------------------------")
    #
    Write-Host -ForegroundColor Yellow ("`n   1) Back-up a Target GPO `t`t`t`tEnter: 1")
    Write-Host -ForegroundColor Yellow ("`n   2) View Target GPO Backups`t`t`t`tEnter: 2")
    Write-Host -ForegroundColor Yellow ("`n   3) Back-up All GPOs    `t`t`t`tEnter: 3")
    Write-Host -ForegroundColor Yellow ("`n   4) View Full GPO Backups`t`t`t`tEnter: 4")
    Write-Host -ForegroundColor Yellow ("`n   5) Open Explorer GPO Backups`t`t`t`tEnter: 5")
    #
    #
    Write-Host("`n------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   0) Return to Prior Menu `t`t`t`tEnter: 0`n")
    Write-Host("------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   HELP   - Enter the number + h  (1h, 2h, 3h...) `tEnter: `'#h`'`n")
    Write-Host -ForegroundColor Red ("   QUIT   - End the GPO Program `t`t`tEnter: `'quit`'`n") 
    Write-Host("------------------------------------------------------------------------")
} # END Get-GPOsBackupMenu function 

#--------------------------------
# Continuing do loop unless quit
do {
    # Clearpage, write out menu, gather user input, account for simple user errors. 
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    Get-GPOsBackupMenu                      # Write this menu (function)
    
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
            $gpoName = ""   # Gather a target GPO in the domain of the user
            # Let user pick initial GPO to get policies/preferences/links from, and confirm choice
            $gpoName = Get-SingleGPOName -gpoUseStatement "BACKUP"
            If ($gpoName -eq 0) {break}
            $confirm1, $confirm2 = ""


            Write-Host(" ") # Empty write for terminal aesthetics
            # Confirm user backup choice
            Write-Warning("--------`nAre you sure that you want to back-up GPO `'$gpoName`'`?")
            do {
                $confirm1 = Read-Host "(y/n)"
                $confirm1 = $confirm1 -replace '\s', ''     # In case user enter spaces
                $confirm1 = $confirm1.ToLower()             # In case user uses any capitol letters.
                If ($confirm1 -eq "yes") {$confirm1 = "y"}
                If ($confirm1 -eq "no") {$confirm1 = "n"}
            } until (($confirm1 -eq "y") -OR ($confirm1 -eq "n"))

            
            # User backup choice is confirmed, now confirm GPO backup encryption
            If ($confirm1 -eq "y") {
                do { 
                    Write-Host -ForegroundColor Yellow ("`nDo you want the backups to be Administrator Encrypted?")
                    $confirm2 = Read-Host "(y/n)"
                    $confirm2 = $confirm2 -replace '\s', ''     # In case user enter spaces
                    $confirm2 = $confirm2.ToLower()             # In case user uses any capitol letters.
                    If ($confirm2 -eq "yes") {$confirm2 = "y"}
                    If ($confirm2 -eq "no") {$confirm2 = "n"}
                } until (($confirm2 -eq "y") -OR ($confirm2 -eq "n"))
            } # End If
            

            # Wrong choice just defaults to NO backup
            If (($confirm1 -eq "y") -AND ($confirm2 -eq "y") ) {
                Set-BackupSingleGPO -sourceGPOParam $gpoName -encrypt $true
                Pause
            } # End If


            If (($confirm1 -eq "y") -AND ($confirm2 -eq "n") ) {
                Set-BackupSingleGPO -sourceGPOParam $gpoName -encrypt $false
                Pause
            } # End If

        } # END 1
        #------------------------------------------------
        '1h' # Help/Information for 1
        {
            Get-GPOFunctionsModuleHelp -section "6.1"
            Pause

        } # End 1h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '2' 
        {
            Get-GPOsBackups
            Pause

        } # END 2
        #------------------------------------------------
        '2h' # Help/Information for 2
        {
            Get-GPOFunctionsModuleHelp -section "6.2"
            Pause

        } # End 2h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '3' 
        {
            $confirm1, $confirm2 = ""
            Write-Warning("`n--------`nAre you sure that you want to back-up all GPOs?")
            do {
                $confirm1 = Read-Host "(y/n)"
                $confirm1 = $confirm1 -replace '\s', ''     # In case user enter spaces
                $confirm1 = $confirm1.ToLower()             # In case user uses any capitol letters.
                If ($confirm1 -eq "yes") {$confirm1 = "y"}
                If ($confirm1 -eq "no") {$confirm1 = "n"}
            } until (($confirm1 -eq "y") -OR ($confirm1 -eq "n"))
            If ($confirm1 -eq "y") {
                Write-Host -ForegroundColor Yellow ("`nDo you want the backups to be Administrator Encrypted?")
                do {
                    $confirm2 = Read-Host "(y/n)"
                    $confirm2 = $confirm2 -replace '\s', ''     # In case user enter spaces
                    $confirm2 = $confirm2.ToLower()             # In case user uses any capitol letters.
                    If ($confirm2 -eq "yes") {$confirm2 = "y"}
                    If ($confirm2 -eq "no") {$confirm2 = "n"}
                } until (($confirm2 -eq "y") -OR ($confirm2 -eq "n"))
            } # End If


            # Wrong choice just defaults to NO backup
            If (($confirm1 -eq "y") -AND ($confirm2 -eq "y") ) {
                Set-BackupAllGPOs -encrypt $true
                Pause
            } # End If
            If (($confirm1 -eq "y") -AND ($confirm2 -eq "n") ) {
                Set-BackupAllGPOs -encrypt $false
                Pause
            } # End If
            
        } # END 3
        #------------------------------------------------
        '3h' # Help/Information for 3
        {
            Get-GPOFunctionsModuleHelp -section "6.3"
            Pause

        } # End 3h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '4' 
        {
            Get-GPOsBackups -fullBackupParam $true
            Pause

        } # END 4
        #------------------------------------------------
        '4h' # Help/Information for 2
        {
            Get-GPOFunctionsModuleHelp -section "6.4"
            Pause

        } # End 4h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        '5' 
        {
            # Open the GPOData/GPOBackup directory in explorer
            explorer.exe "C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata"
            Pause

        } # END 5
        #------------------------------------------------
        '5h' # Help/Information for 5
        {
            Get-GPOFunctionsModuleHelp -section "6.5"
            Pause

        } # End 5h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------
        'quit' 
        {
            $Global:quit = "quit"
            $choice = "0"
        } # END quit-------------------------------------

    }#END switch()
    
} until (($choice -eq '0'))  #END do()==================

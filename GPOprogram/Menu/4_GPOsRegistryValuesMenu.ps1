# Primary program run from '\GPOFunctionsModule\RunGPOProgram\'
# .\RunGPOProgram.ps1
#
# This GPO listing escalation can be run on its own, with all options.
# .\4_GPOsRegistryValuesMenu.ps1
#-------------------------------------------------
# Function to show the main menu
function Get-GPOsRegistryValuesMenu {

    Write-Host("
|======================================================================|
|====================--- GPO Registry Values  ---======================|
|======================================================================|`n")
    #
    Write-Host(" Selections:
------------------------------------------------------------------------")
    #
    Write-Host -ForegroundColor Yellow ("`n   1) Full Registry for Target GPO (Terminal)`t`tEnter: 1")
    Write-Host -ForegroundColor Yellow ("`n   2) Full Registry for Target GPO (Gridview) `t`tEnter: 2")
    Write-Host -ForegroundColor Yellow ("`n   3) View Target Registry for Target GPO `t`tEnter: 3")
    #
    #
    Write-Host("`n------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   0) Return to Prior Menu `t`t`t`tEnter: 0`n")
    Write-Host("------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   HELP   - Enter the number + h  (1h, 2h, 3h...) `tEnter: `'#h`'`n")
    Write-Host -ForegroundColor Red ("   QUIT   - End the GPO Program `t`t`tEnter: `'quit`'`n") 
    Write-Host("------------------------------------------------------------------------")
} # END Get-GPOsRegistryValuesMenu

#--------------------------------
# Continuing do loop unless quit
do {
    # Clearpage, write out menu, gather user input, account for simple user errors. 
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    Get-GPOsRegistryValuesMenu           # Write this menu (function)

    $choice = Read-Host "`nEnter Choice"    # Ask user for menu choice
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host

    $choice = $choice -replace '\s', ''     # In case user enter spaces
    $choice = $choice.ToLower()             # In case user uses any capitol letters.

    $arrayPos, $gpoChoice = 0               # Used for later display of GPO selection
    $gpoName = ""
    $gpoChoice = 0

    # If User input is acceptable, pick from switch list.
    switch ($choice) 
    {
        '1' 
        {   
            do {
                Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
                Clear-Host
                $gpoName = Get-SingleGPOName -gpoUseStatement "view Registry Values"
                If ($gpoName -eq 0) {break} #End If
                

                # Base registry pathways to search through for target GPO registry values.
                # PowerShell can only go through HKLM\ and HKCU\
                $baseKeys = 'HKLM\System', 'HKLM\Software', 'HKLM\Hardware', 'HKLM\SAM', 'HKLM\Security', 'HKCU\Software', 'HKCU\System', 'HKCU\AppEvents', 'HKCU\Console', 'HKCU\Control Panel', 'HKCU\Environment', 'HKCU\EUDC','HKCU\Network', 'HKCU\Keyboard Layout', 'HKCU\Printers', 'HKCU\Volatile Environment'
                

                # timestamp for current records sent to and saved from Get-GPOsRegistryValues
                # Collect once here, so it does not change in the loop
                $global:timestampX = Get-Date -f 'yyyy-MM-dd-HHmmss' 
                

                # Cycle through all primary registry key paths to collect all GPO active registry values
                $gpoRegArray = @()
                ForEach ($key in $baseKeys) { 
                    # Double implementation, or else there is overlap. This prints to terminal, AND saves expected array.
                    Get-GPOsRegistryValues -gpoNameParam $gpoName -keyParam $key 
                    $gpoRegArray += Get-GPOsRegistryValues -gpoNameParam $gpoName -keyParam $key 
                } #End ForEach----------------------


                Pause # Allow for pause since full results will be printed to terminal and gridview.


            } until (($choice -eq 0)) # End do
            If ($choice -eq 0){break} # Skip the pause
            
        }#END 1
        #------------------------------------------------
        '1h' # Help/Information for 1
        {
            Get-GPOFunctionsModuleHelp -section "4.1"
            Pause
        } # End 1h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------       
        '2' 
        {   
            do {
                Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
                Clear-Host
                $gpoName = Get-SingleGPOName -gpoUseStatement "view Registry Values"
                If ($gpoName -eq 0) {break} # End If
                

                # Base registry pathways to search through for target GPO registry values.
                # PowerShell can only go through HKLM\ and HKCU\
                $baseKeys = 'HKLM\System', 'HKLM\Software', 'HKLM\Hardware', 'HKLM\SAM', 'HKLM\Security', 'HKCU\Software', 'HKCU\System', 'HKCU\AppEvents', 'HKCU\Console', 'HKCU\Control Panel', 'HKCU\Environment', 'HKCU\EUDC','HKCU\Network', 'HKCU\Keyboard Layout', 'HKCU\Printers', 'HKCU\Volatile Environment'
                

                # timestamp for current records sent to and saved from Get-GPOsRegistryValues
                # Collect once here, so it does not change in the loop
                $global:timestampX = Get-Date -f 'yyyy-MM-dd-HHmmss' 
                

                # Cycle through all primary registry key paths to collect all GPO active registry values
                $gpoRegArray = @()
                ForEach ($key in $baseKeys) { 
                    # Double implementation, or else there is overlap. This prints to terminal, AND saves expected array.
                    Get-GPOsRegistryValues -gpoNameParam $gpoName -keyParam $key 
                    $gpoRegArray += Get-GPOsRegistryValues -gpoNameParam $gpoName -keyParam $key 
                } # End ForEach----------------------


                # Gridview display of registry results for a GPO. Indicate if nothing is found
                If($gpoRegArray.count -gt 0) {
                    $gpoRegArray | Out-GridView -Title "Registry Results for GPO $gpoName" # Display results in user window
                } else {
                    "GPO $gpoName is void of Registry Keys" | Out-GridView
                } # End If/Else
                
                Pause # Allow for pause since full results will be printed to terminal and gridview.


            } until (($choice -eq 0)) # End do
            If ($choice -eq 0){break} # Skip the pause
            
        } # END 2
        #------------------------------------------------
        '2h' # Help/Information for 2
        {
            Get-GPOFunctionsModuleHelp -section "4.2"
            Pause
        } # End 2h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------          
        '3' 
        {
            Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
            Clear-Host
            $gpoName = Get-SingleGPOName -gpoUseStatement "view Registry Values"
            If ($gpoName -eq 0) {break} # End If


            # Common base Registry paths
            $baseKeys = 'HKLM\System', 'HKLM\Software', 'HKLM\Hardware', 'HKLM\SAM', 'HKLM\Security', 'HKCU\Software', 'HKCU\System', 'HKCU\AppEvents', 'HKCU\Console', 'HKCU\Control Panel', 'HKCU\Environment', 'HKCU\Network'
            

            # timestamp for current records sent to and saved from Get-GPOsRegistryValues
            # Collect once here, so it does not change in the loop
            $global:timestampX = Get-Date -f 'yyyy-MM-dd-HHmmss' 


            # Once GPO is targeted, this allows user to then target a registry path.
            do {

                $arrayPos = 0
                Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
                Clear-Host
                Write-Host -ForegroundColor Yellow ("`n`nVerified GPO selected:   $gpoName `nCommon, base registry paths below:`n------------")
                # Display the common registry paths
                ForEach ($key in $baseKeys) { 
                    $arrayPos++     # Display position value, and final will be total amount of basekeys available
                    Write-Host("$arrayPos`) $key")
                } # End ForEach-------------------
                
                
                # List the primary registry base paths
                Write-Host -ForegroundColor Yellow ("`n---------`n(Enter  0 to return to previous menu, or...)`n `nPick a primary path number, or...`nEnter a target path to check\gather Registry Values from. `nExamples:`n`tHKCU\Software`n`tHKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System `n`n")
                $baseKEY = Read-Host (" ")
                If ($baseKEY -eq 0) {break} # Allow user to break search.


                # If user chose a number, convert that to the primary path they picked. Then registry search.
                If(($baseKEY -eq 1) -AND ($arrayPos -eq 1)) {
                    $key = $baseKeys
                    Get-GPOsRegistryValues -gpoNameParam $gpoName -keyParam $key
                    Pause
                } ElseIf (($baseKEY -in 1..$arrayPos) -AND ($arrayPos -gt 1)) {
                    $key = $baseKeys[$baseKEY - 1]  # Sub 1 to account for array position
                    Get-GPOsRegistryValues -gpoNameParam $gpoName -keyParam $key
                    Pause
                } else {
                    # If a user entered the registry path manually instead of a number, the system will search here.
                    Get-GPOsRegistryValues -gpoNameParam $gpoName -keyParam $baseKEY
                    Pause
                } # End If/Else ----------------
                

            } until ($baseKEY -eq 0) # End do

            
        } # END 3
        #------------------------------------------------
        '3h' # Help/Information for 2
        {
            Get-GPOFunctionsModuleHelp -section "4.3"
            Pause
        } # End 3h
        #------------------------------------------------  
        #------------------------------------------------  
        #------------------------------------------------

        'quit' 
        {
            $Global:quit = "quit"
            $choice = "0"
        } # End quit
        #------------------------------------------------
 
    } # END switch()
    
} until (($choice -eq '0'))  # END do()==================

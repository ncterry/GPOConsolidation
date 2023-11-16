

Function Set-DeleteSingleGPO {
<#
    .SYNOPSIS
    This is just to delete a single GPO with prior information and warnings.
    GPO deletion is easy, but this includes safety to prevent unwanted deletion.


    .EXAMPLE
    Set-DeleteSingleGPO
    # All actions, confirmations done through the function
#>


    $gpoNamesArray = Get-AllGPOsNames    # Just for the user to see what GPOs exist.
    $gpoName = 0 # Default break value
    $domain = Get-GPOsDomain -writehost $false
    $dc = Get-GPOsDomainController -writehost $false
    $gpoName = ""   # Gather a target GPO in the domain of the user


    # Let user pick initial GPO to get policies/preferences/links from, and confirm choice
    do {
        # Show user the GPOs to Choose From
        Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
        Clear-Host
        Write-Warning("`n----------`nDELETE GPO`n`nDeleting the wrong GPO can cause significant problems.")
        Pause
        $gpoName = Get-SingleGPOName -gpoUseStatement "DELETE"
        If ($gpoName -eq 0) {break}
        
    } until ($gpoName -in $gpoNamesArray)
    If ($gpoName -eq 0) {break} # Allow user to return to prior menu


    # Full gpo report will be displayed for user to view before deleting.
    Write-Warning("`n`nA full GPOReport for `'$gpoName`' Must be viewed prior to deleting.")
    Pause
    Get-GPOReport -Name $gpoName -Domain $domain -Server $dc -ReportType HTML -Path "C:\deleteGPOResults.html"
    (Get-Item -Path "C:\deleteGPOResults.html").Encrypt() # Report will be deleted regardless.
    explorer.exe "C:\deleteGPOResults.html"


    # Allow user to create a safety backup of GPO before deleting.
    $backupConfirm = ""
    do {
        Write-Warning("`n`nDo you want to create a safety backup of GPO:")
        $backupConfirm = Read-Host "$gpoName`n(yes/no)"
        $backupConfirm = $backupConfirm -replace '\s', ''     #In case user enter spaces
        $backupConfirm = $backupConfirm.ToLower()             #In case user uses any capitol letters.$gponame")
    } Until ($backupConfirm -eq "yes" -OR $backupConfirm -eq "no")


    # Create backup of GPO before deleting if user said yes
    If($backupConfirm -eq "yes") { 
        Set-BackupSingleGPO -sourceGPOParam $gpoName -encrypt $true
    } Else {
        Write-Warning("User did not confirm backup of $gponame with 'yes'")
    } # End If/Else--------------------------------------


    # Secondary deletion confirmation.  
    $finalConfirm = ""
    do {
        Write-Warning("`n`nAre you sure that you want to delete GPO:")
        $finalConfirm = Read-Host "$gpoName`n(yes/no)"
        $finalConfirm = $finalConfirm -replace '\s', ''     #In case user enter spaces
        $finalConfirm = $finalConfirm.ToLower()             #In case user uses any capitol letters.        
    } Until ($finalConfirm -eq "yes" -OR $finalConfirm -eq "no")
    

    # User has 1)chosen GPO, 2)confirmed, 3)viewed GPO report, 4)confirmed again. Now delete
    If($finalConfirm -eq "yes") { 
        Remove-GPO -Name $gpoName
        $gpoNamesArray = Get-AllGPOsNames
        If ($gpoName -notin $gpoNamesArray) {
            Write-Host -ForegroundColor Yellow ("GPO `'$gpoName`' was deleted.")
        } Else {
            Write-Host -ForegroundColor Red ("GPO `'$gpoName`' was NOT deleted.")
        } # End If/Else2--------------------------------------

    } Else {
        Write-Warning("`nUser chose not to delete GPO `'$gponame`'")
    } # End If/Else1--------------------------------------


    Remove-Item -Path "C:\deleteGPOResults.html" # Report is not needed, always delete.
    
    
} # End Function Set-DeleteSingleGPO--------------------------------------
#--------------------------------------

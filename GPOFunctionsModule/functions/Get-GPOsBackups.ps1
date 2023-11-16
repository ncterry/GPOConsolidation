Function Get-GPOsBackups {
<#
.SYNOPSIS
Simple module to display list of current GPO backups, and sub-backups.
Upon the selection of a target backup, if the target backup was created using the GPOFunctionsModule,
there there will also be a GPO Summary document that was also created to view everything that this
backup contains. If that does not exist in this target backup, then a new one will be created upon the
selection. This defaults to individual backups, but if the user includes $true for the parameter, they 
can then view individual GPO backups from the full backup sets.


.EXAMPLE
Get-GPOsBackups


.EXAMPLE
Get-GPOsBackups -fullBackupParam $true
# If param is true, this will view the full backup sets, not the individul backups.


#>
#===============================
[CmdletBinding()]
Param(
    [Parameter()]
    [bool] $fullBackupParam
) #End Param-------------------------------


    # Gather list of backup names. Names of folders in this location should only be backups.
    $arrayPos, $backupChoice = 0
    $backupName, $backupChosen, $confirm = ""
    
    # If report directory does not exist, create one.
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # $PSScriptRoot only works by executing the script. Selective execution(F8) will not be successful.
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $backupDirectory = "$functionPath\GPOdata\GPOBackups"
    If ($fullBackupParam -eq $true) {$backupDirectory = "$functionPath\GPOdata\GPOFullBackup"}
    $backupNamesArray = @()
    $backupNamesArray = Get-ChildItem $backupDirectory | Where-Object {$_.PSIsContainer} | Select-Object -expandProperty Name
    
    
    do { 
        $arrayPos = 0
        Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
        Clear-Host
        # List the current backups
        Write-Host -ForegroundColor Yellow ("`nGPO Backup Directory:`n$backupDirectory`n`nNames of current GPO Backups:`n-----------------------------")
        ForEach ($backup in $backupNamesArray) {
            $arrayPos++
            Write-Output("$arrayPos) $backup")
        } # End ForEach-------------------------------


        # Indicate if no backups have been saved
        If($null -eq $backupNamesArray) {
            Write-Output("No Backups`n`n`n")
        } # End If-------------------------------


        # Let user choose which backup to view sub-directory of
        # Loop until user exits with 0, or picks a backup in the range
        Write-Host  ("`n`n`n---`nEnter: 0  To Return to Prior Menu`n---")
        Write-Host -ForegroundColor Yellow ("Pick Which Existing GPO Backup View:")
        $backupChoice = Read-Host ("Number 1 - $arrayPos")
        $backupChoice = $backupChoice -replace '\s', ''     #In case user enters spaces


        # 0 = Break from loop if user requested to return to menu
        If ($backupChoice -eq 0) {
            break # Allow user to return to prior menu
        # Isolate the only choice if there is only 1 backup
        } ElseIf (($backupChoice -eq 1) -AND ($arrayPos -eq 1)){
            $backupName = $backupNamesArray
        # If choice is in backup list range, then gather the backup(gpo) name
        } ElseIf ($backupChoice -in 1..$arrayPos) {
            $backupName = $backupNamesArray[$backupChoice - 1 ] # Drop 1 int to account for array position
        # Or Else make sure to bypass and redo the loop
        } Else {
            $backupName = "wrong redo" # false corrections just to prevent a loop passing
            $confirm = "n"  # false corrections just to prevent a loop passing
        } # End IF/ElseIf/Else-------------------------------


        # Simple double confirmation on Backup Choice
        # Backupname exists, and user confirms choice
        If ($backupName -in $backupNamesArray) {
            Write-Host -ForegroundColor Yellow ("`nChosen GPO Backup name:  $backupName `nIs the Backup GPO correct? ")
            $confirm = Read-Host "(y/n)"
            $confirm = $confirm -replace '\s', ''     #In case user enter spaces
            $confirm = $confirm.ToLower()             #In case user uses any capitol letters.
            If ($confirm -eq "yes") {$confirm = "y"}
            If ($confirm -eq "no") {$confirm = "n"}
            If ($confirm -eq "y") {
                # User confirmed, so progress to sub-backup directory
                $backupDirectory = "$backupDirectory\$backupName"
            }# End If1-------------------------------
        } # End If2-------------------------------
        

    # Made it here, so passed tests, and checking if User also confirmed
    } Until ($confirm -eq "y") # End first do
    If ($backupChoice -eq 0) {break} # Allow user to return to prior menu


    do {
        # We just confirmed which backup name to target.
        # Directory now targets the sub directory with the individual backups, of the chosen GPO 
        # Gather all backups of chosen GPO. Newest down to oldest
        $backupNamesArray = Get-ChildItem $backupDirectory | Where-Object {$_.PSIsContainer} | Sort-Object CreationTime -Descending | Select-Object -expandProperty Name
        $arrayPos = 0
        Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
        Clear-Host
        # List the target GPOs backups
        Write-Host -ForegroundColor Yellow ("`nGPO:   $backupName `nList of Backups, Newest down to Oldest:`n---")
        ForEach ($backup in $backupNamesArray) {
            $arrayPos++
            Write-Output("$arrayPos) $backup")
        } # End ForEach-------------------------------
        # Indicate if no backups have been captured.
        If($null -eq $backupNamesArray) {
            Write-Output("No Backups")
        } # End If-------------------------------


        # Grab the most recent backup
        $latestBackup = Get-ChildItem $backupDirectory | Where-Object {$_.PSIsContainer} | Sort-Object CreationTime -Descending | Select-Object -First 1 | Select-Object -ExpandProperty Name
        

        # Let user choose which backup to import into a new GPO. Choose number next to backup
        # Loop until user exits with 0, or picks a backup in the range
        If($null -eq $backupNamesArray) {
            Write-Host -ForegroundColor Yellow ("`n`nThe most recent backup is: None")
            Write-Host ("---`nEnter: 0  To Return to Prior Menu`n---")
            Write-Host -ForegroundColor Yellow ("Pick Which Existing GPO Backup to View:")
            $backupChoice = Read-Host (" ")
            $backupChoice = 0
            break
        } ELse {
            Write-Host -ForegroundColor Yellow ("`n`nThe most recent backup is:  $latestBackup")
            Write-Host ("---`nEnter: 0  To Return to Prior Menu`n---")
            Write-Host -ForegroundColor Yellow ("Pick Which Existing GPO Backup to View:")
            $backupChoice = Read-Host ("Number: 1 - $arrayPos")
        } # End If/Else-------------------------------
        

        # 0 = Break from loop if user requested to return to menu, or no backups are available
        If (($backupChoice -eq 0) -OR ($null -eq $backupNamesArray)) {
            break # Allow user to return to prior menu
        } ElseIf(($backupChoice -eq 1) -AND ($arrayPos -eq 1)) {
            $backupChosen = $backupNamesArray
        # If choice is in backup list range, then gather the backup(gpo) name
        } ElseIf (($backupChoice -in 1..$arrayPos) -AND ($arrayPos -gt 1)) {
            If ($backupChoice -eq 1) {
                # Array position, if 1, just grab the latest backup.
                # There can be problems here, if you use 1-1
                $backupChosen = $latestBackup
            } Else {
                $backupChosen = $backupNamesArray[$backupChoice - 1 ] # Drop 1 int to account for array position
            } # End If1/Else1-------------------------------
        # Or Else make sure to bypass and redo the loop
        } Else {
            $backupChosen = "wrong redo loop" 
            $confirm = "n"  
        } # End IF/ElseIf-------------------------------


        # Simple double confirmation on Backup Choice
        # Backupname exists, and user confirms choice
        If ($backupChosen -in $backupNamesArray) {
            Write-Host -ForegroundColor Yellow ("`nChosen GPO Backup for:  $backupName `nIs the Backup  $backupChosen  correct? ")
            $confirm = Read-Host "(y/n)"
            $confirm = $confirm -replace '\s', ''     #In case user enter spaces
            $confirm = $confirm.ToLower()             #In case user uses any capitol letters.
            If ($confirm -eq "yes") {$confirm = "y"}
            If ($confirm -eq "no") {$confirm = "n"}
            
            If ($confirm -eq "y") {
                # User confirmed, so progress to sub-backup directory
                # backupDirectory is already up through the GPO name, now add the chosen backup ex. timestamp
                $backupDirectory = "$backupDirectory\$backupChosen" 
            }# End If1-------------------------------
        } # End If2-------------------------------
    # Made it here, so passed tests, and checking if User also confirmed
    } Until ($confirm -eq "y") # End first do
    If ($backupChoice -eq 0) {break} # Allow user to return to prior menu


    # Now we are inside of the primary backup
    $backupItems = Get-ChildItem -Path $backupDirectory
    # View items
    $backupItems     
    

    # If there is an HTML file in this location, it is the settings report of the GPO when backed up.
    If((Test-Path -Path "$backupDirectory\*" -Include "*.html")) {
        # Let user know where the report is
        Write-Host -ForegroundColor Yellow ("The settings report for GPO `'$backupName`', backup from `'$backupChosen`' `nCan be found at: `n$backupDirectory")
        # Open the report up
        Invoke-Item "$backupDirectory\*.html"

    } Else {
        # If html settings report for backup does not exist, we need a tempory GPO import to gather settings from
        $tempGPOName = "BackupInfo_for__$backupName`__from__$backupChosen"
        # The only way to view the full backup details, create a new gpo, import backup, then delete gpo
        # Create the new gpo with name/comment, but is otherwise blank so far.
        Write-Warning("GPO  `"$tempGPOName`"  `nCreated to gather full diagnostic information on the backup for GPO $backupName, $backupChosen.`nGPO will be deleted immediately after data is collected.")
        Pause


        New-GPO -Name $tempGPOName 


        # User will provide old GPO(backup with settings), and existing GPO just created( to import settings inTO)
        # Import will overwrite any prior settings. Be careful. Usually Best to use a new, blank GPO
        Import-GPO -BackupGpoName $backupName -Path $backupDirectory -TargetName $tempGPOName


        # We just imported the policies/preferences into the new GPO, from GPO backup
        # The original GPO links to OUs, were not included in the default backup/import modules.
        # GPOProgram also captured GPO linked OUs in seperate file. Now link to prior captured OUs
        # Gather prior linked OUs from backed up file.
        # Test if OU file exists, as imported backups may not have saved OUs, i.e. were not linked.
        $targetOUs = @()
        If (Test-Path -Path "$backupDirectory\targetOUs.txt") {
            $targetOUs = Get-Content -Path "$backupDirectory\targetOUs.txt"
        } #End If-------------------------------


        # Loop through all OUs linked to old GPO, and link new GPO to those same OUs
        # If $targetOUs is empty, or link is old, it will not link the GPO to an OU
        Write-Warning("`n-----`n-----`n-----`nOrganizational Units Linked to $backupName on backup $backupChosen")
        ForEach ($ou in $targetOUs) {
            New-GPLink -Name $tempGPOName -Target $ou -LinkEnabled Yes
        } # End ForEach-Object-------------------------------
        Write-Output("-------------------")


        # Temp GPO created as a copy of target backup, this will gather all data on that in a pretty html.
        Find-AllGPOSettings -sourceGPOParam $tempGPOName


        # Created GPO, imported backup to check, now delete new GPO
        Remove-GPO -Name $tempGPOName
        Write-Warning("`nTempory GPO:  $tempGPOName  was deleted.")
    } # End If/Else-------------------------------
    


} #End Function Get-GPOsBackups

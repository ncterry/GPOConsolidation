Function Set-MergeGPOFromBackup {
<#
    .SYNOPSIS
    This is an interactive function, that requires user input.
    Similar to Get-ImportGPOSingle but this allows for GPO backups that were imported 
    and do not exist currently and it will create a new GPO from a prior backup.
    - GPO Backups should be placed here:
    `"C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups`"

    This also allows the user to pick a single GPO from a full backup set.
    This requires a `$true in the function's parameter

    GPO1 has been backed up, it either may exist currently, or just remain as a backup.
    This backup can be imported into GPO2, which is created here.
    GPO2 will have all of the policies, preferences, and links (if they exist)


    .DESCRIPTION
    Choose name of prior GPO backup from list.
    Choose existing GPO Name, import the backup into existing GPO


    .EXAMPLE
    Set-MergeGPOFromBackup


    .EXAMPLE
    Set-MergeGPOFromBackup -fullBackupParam $true
    # Grab a single gpo, from a full backup

#>
#===============================
[CmdletBinding()]
Param(
    # indicate to import a single gpo, from the full backup set
    [Parameter()]
    [bool] $fullBackupParam
) #End Param-------------------------------


    # Gather list of backup names. Names of folders in this location should only be backups.
    $arrayPos, $backupChoice = 0
    $backupName, $backupNameConfirm, $destNameConfirm, $backupChosen, $destGPOName, $confirm = ""
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # $PSScriptRoot only works by executing the script. Selective execution(F8) will not be successful.
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $backupDirectory = "$functionPath\GPOdata\GPOBackups" 
    If ($fullBackupParam -eq $true) {$backupDirectory = "$functionPath\GPOdata\GPOFullBackup" }
    $backupNamesArray = @()
    # Gather all from local GPOFunctionsModule backup directory.
    $backupNamesArray = Get-ChildItem $backupDirectory | Where-Object {$_.PSIsContainer} | Select-Object -expandProperty Name
    
    
    do { 
        $arrayPos = 0
        Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
        Clear-Host
        # List the current backups
        Write-Host -ForegroundColor Yellow ("GPO Backup Directory:")
        Write-Host -ForegroundColor Yellow ("$backupDirectory")
        Write-Host -ForegroundColor Yellow ("Names of GPO Backup Sets:`n---")


        ForEach ($backup in $backupNamesArray) {
            $arrayPos++
            Write-Output("$arrayPos) $backup")
        } # End ForEach--------------------------------------


        # Let user choose which backup to import into a new GPO. Choose number next to backup
        # Loop until user exits with 0, or picks a backup in the range
        If($arrayPos -eq 0) {
            # If there are no backups, only tell user to pick 0
            Write-Host -ForegroundColor Yellow ("`n---`nEnter: 0  To Return to Prior Menu`n---`nPick Which Existing GPO Backup to Import From: $arrayPos")
            $backupChoice = Read-Host (" ") # This will break no matter what, but the read-host is a pause.
            break
        } Else {
            Write-Host -ForegroundColor Yellow ("`n---`nEnter: 0  To Return to Prior Menu`n---`nPick Which Existing GPO Backup to Import From: 1 - $arrayPos")
            $backupChoice = Read-Host (" ")
        } # End If/Else--------------------------------------


        # 0 = Break from loop if user requested to return to menu
        If ($backupChoice -eq 0) { # -------------IF/ElseIf
            break # Allow user to return to prior menu
        # If choice is in backup list range, then gather the backup(gpo) name
        # If there is only 1 backup choice available.
        } ElseIf (($arrayPos -eq 1) -AND ($backupChoice -eq 1)) {
            $backupName = $backupNamesArray # Only position available.
        # If there are more 
        } ElseIf (($backupChoice -in 1..$arrayPos) -AND ($arrayPos -gt 1)) {
            $backupName = $backupNamesArray[$backupChoice - 1 ] # Drop 1 int to account for array position
        # Or Else make sure to bypass and redo the loop
        } Else {
            $backupName = "wrong redo"
            $confirm = "n"  
        } # End IF/ElseIf--------------------------------------


        # Simple double confirmation on Backup Choice
        # Backupname exists, and user confirms choice
        If ($backupName -in $backupNamesArray) {
            Write-Host -ForegroundColor Yellow ("`nChosen GPO Backup set:  $backupName `nIs the Backup GPO correct? ")
            $confirm = Read-Host "(y/n) "
            $confirm = $confirm -replace '\s', ''     #In case user enter spaces
            $confirm = $confirm.ToLower()             #In case user uses any capitol letters.
            If ($confirm -eq "yes") {$confirm = "y"}
            If ($confirm -eq "no") {$confirm = "n"}
            If ($confirm -eq "y") {
                # User confirmed, so progress to sub-backup directory
                $backupDirectory = "$backupDirectory\$backupName"
            }# End If1--------------------------------------
        } # End If2--------------------------------------
        
        
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
        } # End ForEach--------------------------------------

        # Indicate if no backups have been captured.
        If($null -eq $backupNamesArray) {
            Write-Output("No Backups")
        } # End If--------------------------------------


        # Grab the most recent backup
        $latestBackup = Get-ChildItem $backupDirectory | Where-Object {$_.PSIsContainer} | Sort-Object CreationTime -Descending | Select-Object -First 1 | Select-Object -ExpandProperty Name
        

        # Let user choose which backup to import into a new GPO. Choose number next to backup
        # Loop until user exits with 0, or picks a backup in the range
        If($null -eq $backupNamesArray) {
            Write-Host -ForegroundColor Yellow ("`nThe most recent backup is: None")
        } ELse {
            Write-Host -ForegroundColor Yellow ("`nThe most recent backup is:  $latestBackup")
        } # End If/Else--------------------------------------


        If($arrayPos -eq 0) {
            # If there are no backups, only tell user to pick 0
            $backupChoice = Read-Host "`n---`nEnter: 0  To Return to Prior Menu`n---`nPick Which Existing GPO Backup to Import From: $arrayPos"
        } Else {
            $backupChoice = Read-Host "`n---`nEnter: 0  To Return to Prior Menu`n---`nPick Which Existing GPO Backup to Import From: Number 1 - $arrayPos"
        } # End If/Else--------------------------------------


        # 0 = Break from loop if user requested to return to menu
        If ($backupChoice -eq 0) { #---------------------------IF/Else1
            break # Allow user to return to prior menu
        } ElseIf (($backupChoice -eq 1) -AND ($arrayPos -eq 1)) {
            $backupChosen = $backupNamesArray
        # If choice is in backup list range, then gather the backup(gpo) name
        } ElseIf (($backupChoice -in 1..$arrayPos) -AND ($arrayPos -gt 1)) {
            If ($backupChoice -eq 1) { #---------IF/Else2
                # Array position, if 1, just grab the latest backup.
                # There can be problems here, if you use 1-1
                $backupChosen = $latestBackup
            } Else {
                $backupChosen = $backupNamesArray[$backupChoice - 1 ] # Drop 1 int to account for array position
            } # End If1/Else2--------------------------------------


        # Or Else make sure to bypass and redo the loop
        } Else {
            # This is in the do/until and will just keep user in picking which backup or exiting.
            $backupChosen = "wrong redo" 
            $confirm = "n"  
        } # End IF/Else1--------------------------------------


        # Simple double confirmation on Backup Choice
        # Backupname exists, and user confirms choice
        If ($backupChosen -in $backupNamesArray) { #--IF1
            Write-Host -ForegroundColor Yellow ("`nChosen GPO Backup for:  $backupName")
            $confirm = Read-Host ("Is the Backup  $backupChosen  correct? (y/n) ")
            $confirm = $confirm -replace '\s', ''     #In case user enter spaces
            $confirm = $confirm.ToLower()             #In case user uses any capitol letters.
            If ($confirm -eq "yes") {$confirm = "y"}
            If ($confirm -eq "no") {$confirm = "n"}
            If ($confirm -eq "y") { #---IF2
                # User confirmed, so progress to sub-backup directory
                # backupDirectory is already up through the GPO name, now add the chosen backup ex. timestamp
                $backupDirectory = "$backupDirectory\$backupChosen" 
            } # End IF2--------------------------------------
        } # End IF1--------------------------------------
    # Made it here, so passed tests, and checking if User also confirmed
    } Until ($confirm -eq "y") # End first do
    If ($backupChoice -eq 0) {break} # Allow user to return to prior menu


    # Now we have the target GPO backup, now we need the new GPO name
    # New GPO, and it cannot conflict with current GPOs
    # Do not continue until user new GPO name input does not match one that already exists.
    do {     
        Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear       
        Clear-Host
        $confirm = "n"
        

        # Backup was chosen, now let user pick which existing GPO to import that backup into.
        $destGPOName = Get-SingleGPOname -gpoUseStatement "Import settings into, FROM a Backup GPO `'$backupName`', `'$backupChosen`'"
        If ($destGPOName -eq "0") {break} # End If


        # Secondary confirmation that both choices were correct.
        Write-Host -ForegroundColor Yellow ("`nIs the backup `'$backupName`' from `'$backupChosen`' correct?")
        $backupNameConfirm = Read-Host ("`(y/n`)")
        $backupNameConfirm = $backupNameConfirm -replace '\s', ''     #In case user enter spaces
        $backupNameConfirm = $backupNameConfirm.ToLower()             #In case user uses any capitol letters.
        If ($backupNameConfirm -eq "yes") {$backupNameConfirm = "y"}
        If ($backupNameConfirm -eq "no") {$backupNameConfirm = "n"}
        If($backupNameConfirm -eq "y") {
            Write-Host -ForegroundColor Yellow ("`nIs the target GPO `'$destGPOName`' correct?")
            $destNameConfirm = Read-Host ("`(y/n`)")
            $destNameConfirm = $destNameConfirm -replace '\s', ''     #In case user enter spaces
            $destNameConfirm = $destNameConfirm.ToLower()             #In case user uses any capitol letters.
            If ($destNameConfirm -eq "yes") {$destNameConfirm = "y"}
            If ($destNameConfirm -eq "no") {$destNameConfirm = "n"}
        } # End If--------------------------------------
        If (($backupNameConfirm -eq "n") -OR ($destNameConfirm -eq "n")) {break} # End If

    } until (($backupNameConfirm -eq "y") -AND ($destNameConfirm -eq "y")) # End do


    If (($backupNameConfirm -eq "n") -OR ($destGPOName -eq "0") -OR ($destNameConfirm -eq "n")) {break} # End If
    Write-Host("`n`n") # Terminal aesthetics


    # User will provide old GPO(backup with settings), and existing GPO just created( to import settings inTO)
    # Import will overwrite any prior settings. Be careful. Usually Best to use a new, blank GPO
    If ($fullBackupParam -eq $true) {
        # Full backup naming convention is different than single backup naming
        $backupName = $backupChosen
        Import-GPO -BackupGpoName $backupName -Path $backupDirectory -TargetName $destGPOName
    } Else {
        Import-GPO -BackupGpoName $backupName -Path $backupDirectory -TargetName $destGPOName
    } # End If/Else
    


    # We just imported the policies/preferences into the new GPO, from GPO backup
    # The original GPO links to OUs, were not included in the default backup/import modules.
    # GPOProgram also captured GPO linked OUs in seperate file. Now link to prior captured OUs
    # Gather prior linked OUs from backed up file.
    # Test if OU file exists, as imported backups may not have saved OUs, i.e. were not linked.
    $targetOUs = @()
    If (Test-Path -Path "$backupDirectory\targetOUs.txt") {
        $targetOUs = Get-Content -Path "$backupDirectory\targetOUs.txt"
    } # End If--------------------------------------


    Write-Warning("Overwrite OUs of GPO `'$destGPOParam`' with OUs from GPO `'$sourceGPOParam`'")
        
    # Remove OU links to target GPO, and re-write with source GPO-OU links
    # Gather all OUs with established GPO Links
    $linkedOUs = (Get-ADOrganizationalUnit -filter * | Get-GPInheritance).GPOLinks | Select-Object -Property Target, DisplayName
    
    # Selective data gathering, so filter OUs currently linked to target GPO
    $linkedOUs1 = $linkedOUs | Where-Object{($_.DisplayName -eq $destGPOName)}

    # We want to overwrite, so first remove all linked OUs in target GPO
    ForEach ($ou in $linkedOUs1) {
        Remove-GPLink -Name $destGPOName -Target $ou.Target
    } # End ForEach-----------------------------------

    # Then Loop through all OUs linked to source GPO, and link them to the new GPO also
    # If $targetOUs for old GPO is empty, it will not link the GPO to any OU
    ForEach ($ou in $targetOUs) {
        New-GPLink -Name $destGPOName -Target $ou -LinkEnabled Yes
    } # End ForEach-Object 



    Write-Host("`n`nNOTE - You may need to RE-OPEN Group Policy Management to refresh the new GPO and associated links.`n")
    Find-AllGPOSettings -sourceGPOParam $destGPOName



} #End Function Set-MergeGPOFromBackup--------------------------------------
#--------------------------------------

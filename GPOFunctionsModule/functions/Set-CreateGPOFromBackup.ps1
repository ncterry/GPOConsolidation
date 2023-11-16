Function Set-CreateGPOFromBackup {
<#
    .SYNOPSIS
    Similar to Get-ImportGPOSingle but this allows for GPOs that were imported and do not exist currently.
    Create a new GPO from a prior backup.
    GPO1 has been backed up, it either may exist currently, or just remain as a backup.
    This backup can be imported into GPO2, which is created here.
    GPO2 will have all of the policies, preferences, and links (if they exist)


    .DESCRIPTION
    Chose name of prior GPO backup from list.
    Create a new GPO Name, import that backup into new GPO
    All actions are done through the function, not a prior menu.


    .EXAMPLE
    Set-CreateGPOFromBackup

#>

    $destGPONamesArray = Get-AllGPOsNames    # Just for the user to see what GPOs exist.
    $domain = Get-GPOsDomain -writehost $false    
    $destGPOName = ""   # Gather a target GPO in the domain of the user
    $arrayPos, $backupChoice = 0
    $backupName, $backupNameConfirm, $backupChosen, $confirm = ""
     
    
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # $PSScriptRoot only works by executing the script. Selective execution(F8) will not be successful.
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $backupDirectory = "$functionPath\GPOdata\GPOBackups" 
    $backupNamesArray = @()
    # Gather all from local GPOFunctionsModule backup directory.
    # Only gather name of direcory which is also the name of the GPO
    $backupNamesArray = Get-ChildItem $backupDirectory | Where-Object {$_.PSIsContainer} | Select-Object -expandProperty Name
    
    
    do { 
        $arrayPos = 0
        Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
        Clear-Host
        # List the current backups
        Write-Host -ForegroundColor Yellow ("GPO Backup Directory:")
        Write-Host -ForegroundColor Yellow ("$backupDirectory")
        Write-Host -ForegroundColor Yellow ("`nNames of Current GPO Backups:`n---")
        ForEach ($backup in $backupNamesArray) {
            $arrayPos++
            Write-Output("$arrayPos) $backup")
        } # End ForEach--------------------------------------


        # Indicate if no backups have been created
        If($null -eq $backupNamesArray) {
            Write-Output("No Backups")
        } # End If--------------------------------------


        # Let user choose which backup to import into a new GPO. Choose number next to backup
        # Loop until user exits with 0, or picks a backup in the range
        If($arrayPos -eq 0) {
            # If there are no backups, only tell user to pick 0
            Write-Host -ForegroundColor Yellow ("`n---`nEnter: 0  To Return to Prior Menu`n---`nThere are no backups: $arrayPos")
            $backupChoice = Read-Host (" ")
            $backupChoice = 0
            break
        } Else {
            Write-Host -ForegroundColor Yellow ("`n---`nEnter: 0  To Return to Prior Menu`n---`nPick Which Existing GPO Backup to Import From: 1 - $arrayPos")
            do {
                $backupChoice = Read-Host (" ")
            } until($backupChoice -in 0..$arrayPos)
        } # End If/Else--------------------------------------
        

        # 0 = Break from loop if user requested to return to menu
        If ($backupChoice -eq 0) {
            break # Allow user to return to prior menu
        # If choice is 1, and there is only 1 in the list.
        } ElseIf (($arrayPos -eq 1) -AND ($backupChoice -eq 1)) {
            $backupName = $backupNamesArray # Only position available.
        # If choice is in backup list range, then gather the backup(gpo) name
        } ElseIf (($backupChoice -in 1..$arrayPos) -AND ($arrayPos -gt 1)) {
            $backupName = $backupNamesArray[$backupChoice - 1 ] # Drop 1 int to account for array position
        # Or Else make sure to bypass and redo the loop
        } Else {
            $backupName = "wrong redo"
            $confirm = "n"  
        } # End IF/ElseIf/Else--------------------------------------


        # Simple double confirmation on Backup Choice
        # Backupname exists, and user confirms choice
        If ($backupName -in $backupNamesArray) {
            Write-Host -ForegroundColor Yellow ("`nChosen GPO Backup name:  `'$backupName`' `nIs the Backup GPO correct?")
            $confirm = Read-Host ("`(y/n`)")
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


        # Indicate if no backups have been created
        If($null -eq $backupNamesArray) {
            Write-Output("No Backups")
        } # End If--------------------------------------


        # Grab the most recent backup
        $latestBackup = Get-ChildItem $backupDirectory | Where-Object {$_.PSIsContainer} | Sort-Object CreationTime -Descending | Select-Object -First 1 | Select-Object -ExpandProperty Name
        

        # Let user choose which backup to import into a new GPO. Choose number next to backup
        # Loop until user exits with 0, or picks a backup in the range
        If($null -eq $backupNamesArray) {
            Write-Host -ForegroundColor Yellow ("`n`nThe most recent backup is: None")
        } ELse {
            Write-Host -ForegroundColor Yellow ("`n`nThe most recent backup is:  $latestBackup")
        } # End If/Else--------------------------------------
        

        If($arrayPos -eq 0) {
            # If there are no backups, only tell user to pick 0
            Write-Host -ForegroundColor Yellow ("`n---`nEnter: 0  To Return to Prior Menu`n---`nPick Which Existing GPO Backup to Import From: $arrayPos")
            $backupChoice = Read-Host " "
        } Else {
            Write-Host -ForegroundColor Yellow ("`n---`nEnter: 0  To Return to Prior Menu`n---`nPick Which Existing GPO Backup to Import From: Number 1 - $arrayPos")
            $backupChoice = Read-Host " "
        } # End If/Else--------------------------------------


        # 0 = Break from loop if user requested to return to menu
        If ($backupChoice -eq 0) {
            break # Allow user to return to prior menu
        # If choice is 1, and there is only 1 in the list.
        } ElseIf (($backupChoice -eq 1) -AND ($arrayPos -eq 1)) {
            $backupChosen = $backupNamesArray
        # If choice is in backup list range, then gather the backup(gpo) name
        } ElseIf (($backupChoice -in 1..$arrayPos) -AND ($arrayPos -gt 1)) {
            If ($backupChoice -eq 1) {
                # Array position, if 1, just grab the latest backup.
                # There can be problems here, if you use 1-1
                $backupChosen = $latestBackup
            } Else {
                $backupChosen = $backupNamesArray[$backupChoice - 1 ] # Drop 1 int to account for array position
            } # End If1/Else1--------------------------------------

        # Or Else make sure to bypass and redo the loop
        } Else {
            # This is in the do/until and will just keep user in picking which backup or exiting.
            $backupChosen = "wrong redo" 
            $confirm = "n"  
        } # End IF/ElseIf--------------------------------------


        # Simple double confirmation on Backup Choice
        # Backupname exists, and user confirms choice
        If ($backupChosen -in $backupNamesArray) {
            $confirm = ""
            Write-Host -ForegroundColor Yellow ("`nChosen GPO Backup for:  $backupName")
            Write-Host -ForegroundColor Yellow ("Is the Backup  $backupChosen  correct? ")
            $confirm = Read-Host ("(y/n) ")
            $confirm = $confirm -replace '\s', ''     #In case user enter spaces
            $confirm = $confirm.ToLower()             #In case user uses any capitol letters.
            If ($confirm -eq "yes") {$confirm = "y"}
            If ($confirm -eq "no") {$confirm = "n"}
            If ($confirm -eq "y") {
                # User confirmed, so progress to sub-backup directory
                # backupDirectory is already up through the GPO name, now add the chosen backup ex. timestamp
                $backupDirectory = "$backupDirectory\$backupChosen" 
            }# End If1--------------------------------------
        } # End If2--------------------------------------

    # Made it here, so passed tests, and checking if User also confirmed
    # Run until user confirms, or breaks out with 0
    } Until ($confirm -eq "y") # End first do
    If ($backupChoice -eq 0) {break} # Allow user to return to prior menu


    # Now we have the target GPO backup, now we need the new GPO name
    # New GPO, and it cannot conflict with current GPOs
    # Do not continue until user new GPO name input does not match one that already exists.
    do { 
        Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n")  # The screen can leave residual text. This overwrites before clear           
        Clear-Host
        $confirm = "n"
        Write-Host -ForegroundColor Yellow ("`n$domain : List of Current GPO Display Names: `n----------------`n")
        Get-AllGPOsNamesNumbered            # Display GPO names
        Write-Host("-------------`n") #Terminal aesthetics
        Write-Warning("`nNew GPO name must be different than all existing GPO names.`n`nImporting From: `nGPO:      $backupName`nBackup:   $backupChosen")

        Write-Output ("---`nEnter  0  To Return to Previous Menu ")

        If ($backupName -notin $destGPONamesArray) {
            Write-Host -ForegroundColor Yellow ("The GPO backup name `'$backupName`' is not active.`nWould you like to use $backupName as the name for the new GPO?")

            do {
                $backupNameConfirm = Read-Host ("`(y/n`)")
                $backupNameConfirm = $backupNameConfirm -replace '\s', ''     #In case user enter spaces
                $backupNameConfirm = $backupNameConfirm.ToLower()             #In case user uses any capitol letters.
                If ($backupNameConfirm -eq "yes") {$backupNameConfirm = "y"}
                If ($backupNameConfirm -eq "no") {$backupNameConfirm = "n"}
            } until (($backupNameConfirm -eq "y") -OR ($backupNameConfirm -eq "n"))
            If ($backupNameConfirm -eq "y") {
                $destGPOName = $backupName
            } # End If2--------------------------------------

        } Else {
            do {
                Write-Host -ForegroundColor Yellow ("Enter a new, unique GPO name")
                $destGPOName = Read-Host (" ")
                $destGPOName = $destGPOName.Trim() # Trim any before/after whitespace
                If (($destGPOName -eq "0")) {break}
                If ($destGPOName -in $destGPONamesArray) {
                    Write-Host -ForegroundColor Yellow ("GPO Name already Exists")
                    Pause # Let user confirm they regognize the error
                } # End If--------------------------------------
            } Until (($destGPOName -ne "") -AND ($destGPOName -notin $gpoNamesArray))
        }# End If/Else1--------------------------------------


        # Backup name can be used again, but user wants a new name
        If ($backupNameConfirm -eq "n") {
            Write-Host -ForegroundColor Yellow ("Enter a new, unique GPO name")
            $destGPOName = Read-Host (" ")
        } # End If--------------------------------------
        If (($backupNameConfirm -eq "0") -OR ($destGPOName -eq "0")) {break} # End If


        If (($destGPOName -NotIn $destGPONamesArray) -AND ($destGPOName -ne "") -AND ($destGPOName -ne "0")) {
            $confirm = ""
            Write-Host -ForegroundColor Yellow ("`nIs this name correct:   $destGPOName ")
            $confirm = Read-Host ("(y/n)")
            $confirm = $confirm -replace '\s', ''     #In case user enter spaces
            $confirm = $confirm.ToLower()             #In case user uses any capitol letters.
            If ($confirm -eq "yes") {$confirm = "y"}
            If ($confirm -eq "no") {$confirm = "n"}
        } #End If--------------------------------------
        

    } until ($confirm -eq 'y' -or $destGPOName -eq '0') # End do
    If (($backupNameConfirm -eq "0") -OR ($destGPOName -eq "0")) {break} # End If


    # Only reaches comment if name is acceptable
    Write-Host -ForegroundColor Yellow ("`n`nEnter a descriptor comment for $destGPOName")
    $gpoComment = Read-Host (" ")
    $gpoComment = $gpoComment + " Created by Set-CreateGPOFromBackup.ps1"


    # Create the new gpo with name/comment, but is otherwise blank so far.
    New-GPO -Name $destGPOName -Comment "Created by:  Set-CreateGPOFrmBackup.ps1; Settings Imported from: $backupName, $backupChosen --- User Comment: $gpoComment"


    # User will provide old GPO(backup with settings), and existing GPO just created( to import settings inTO)
    # Import will overwrite any prior settings. Be careful. Usually Best to use a new, blank GPO
    Import-GPO -BackupGpoName $backupName -Path $backupDirectory -TargetName $destGPOName


    # Below is just a confirmation for user to view in terminal AFTER the change.
    (Get-GPO -Name $destGPOName).Description


    # We just imported the policies/preferences into the new GPO, from GPO backup
    # The original GPO links to OUs, were not included in the default backup/import modules.
    # GPOProgram also captured GPO linked OUs in seperate file. Now link to prior captured OUs
    # Gather prior linked OUs from backed up file.
    # Test if OU file exists, as imported backups may not have saved OUs, i.e. were not linked.
    $targetOUs = @()
    If (Test-Path -Path "$backupDirectory\targetOUs.txt") {
        $targetOUs = Get-Content -Path "$backupDirectory\targetOUs.txt"
    } # End If --------------------------------------


    # Loop through all OUs linked to old GPO, and link new GPO to those same OUs
    # If $targetOUs is empty, it will not link the GPO to any OU
    ForEach ($ou in $targetOUs) {
        New-GPLink -Name $destGPOName -Target $ou -LinkEnabled Yes
    } # End ForEach-Object--------------------------------------


    Write-Host("`n`nNOTE - You may need to RE-OPEN Group Policy Management to refresh the new GPO and associated links.`n")
    Find-AllGPOSettings -sourceGPOParam $destGPOName


} #End Function Set-CreateGPOFromBackup--------------------------------------
#--------------------------------------

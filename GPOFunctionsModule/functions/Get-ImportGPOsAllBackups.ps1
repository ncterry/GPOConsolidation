

Function Get-ImportGPOsAllBackups {
    <#
        .SYNOPSIS
        Import all GPO backups from a full backup set.
        This will only gather GPO backups from the GPOFullBackup directory. 
        A full import can only be done using a full backup.
        This will create a new GPO if the backup name does not currently exist.
        This will overwrite settings in an existing GPO if the name matches a backup. 
        This is to replicate all GPO backups in a new system.
        This will NOT delete GPOs that are not associated with a backup. They will remain.
        
    
        .DESCRIPTION
        Set of GPOs exists already, and were all backed up, by default to:
        C:\Program Files\WindowsPowerShell\GPOFullBackups\
        Full backups are timestamped, which the user will choose from.
        This will overwrite existing GPOs, so a safety backup param is mandatory. $true/$false


        .EXAMPLE
        Get-ImportAllGPOBackups -safetyBackup $true
        # Creates a full GPO safety backup before the full GPO import


        .EXAMPLE
        Get-ImportAllGPOBackups -safetyBackup $false
        # DANGEROUS - Does not create a full GPO backup. Overwritten GPOs will not be saved.
        

        .EXAMPLE
        Get-ImportAllGPOBackups -gpoBackupPath "C:\gpobackups\" -safetyBackup $false
        # If a full GPO backup has been moved to the non-default location, and a backup is wanted.
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [String] $gpoBackupPath = "", #If backup path is not sent in.
        [Parameter(Mandatory = $true)]
        [bool] $safetyBackup
    ) #End Param-------------------------------
        

        # Default WindowsPowerShell directory + \GPOBackups
        If ($gpoBackupPath -eq "") { # If no GPO backup directory is sent in.
            # If report directory does not exist, create one.
            # If this GPOFunctionsModule exist, the admin privs must also in that location.
            # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
            # This is built to be an imported Windows PowerShell script.
            # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
            $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
            $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
            $gpoBackupPath = "$functionPath\GPOdata\GPOFullBackup"  
        } #End if-------------------------------


        $dateDirectory, $finalGPObackupPath = ""
        $gpoBackupNames, $fullBackupDates = @()
        $fullBackupDates += Get-ChildItem -Directory -Path $gpoBackupPath | Select-Object -ExpandProperty Name
        $arrayPos = 0
        # List the dates of full backups along with associated number to pick
        Write-Host -ForegroundColor Yellow ("`nDates of Full System GPO Backups:`n--------------------")
        ForEach ($date in $fullBackupDates) {
            Write-Host("> $date")
        } # End ForEach-------------------------------
        

        # Let user pick if they want to use a backup or view the backup GPOs

        do {
            $arrayPos = 0 # Reset to 0 if being looped
            $dateDirectory = ""
            Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
            Clear-Host
            Write-Host -ForegroundColor Yellow ("`nDates of Full System GPO Backups:`n--------------------")
            ForEach ($date in $fullBackupDates) {
                $arrayPos++
                Write-Host("$arrayPos) $date")
            } # End ForEach-------------------------------


            # Let user pick which date they want to view the GPOs collected
            If ($arrayPos -eq 0) {
                Write-Host("There are no full GPO backups currently to import from.")
                Pause
                break # No backups, break out of import, but it will still create backup if user said yes
            } Else  {
                Write-Host -ForegroundColor Yellow ("----------`nEnter 0 to exit`nWhich date of full GPO backups do you want to view? ")
                do {
                    $dateChoice = Read-Host ("(1 - $arrayPos)")
                    $dateChoice = $dateChoice -replace '\s', ''     # In case user enter spaces
                    If($dateChoice -eq 0) {break}
                    $dateChoice = $dateChoice.ToLower()             # In case user uses any capitol letters.
                # Until choice is assoociated with one of the dates
                } until ($dateChoice -in 1..$arrayPos)
                If ($dateChoice -eq 0) {break}


                # Only 1 backup set available
                If (($dateChoice -eq 1) -AND ($arrayPos -eq 1)) {
                    $dateDirectory = $fullBackupDates   # only 1 object in date array
                } # End If-------------------------------


                # Numerous valid backup sets are available
                If (($dateChoice -in 1..$arrayPos) -AND ($arrayPos -gt 1)) {
                    $dateDirectory = $fullBackupDates[$dateChoice - 1]
                } # End If-------------------------------


                # We have chosen which date to examine, now just grab all gpo names from that backup date
                # Prior GPO Backups are done for each GPO, the location has the name of the GPO as the subdirectory name.
                # Consecutive GPO backups for each GPO are listed in each named directory
                # Cycle through main backup location, grab each name
                # This is simply an import of all prior GPOs using backup names.
                $finalGPObackupPath = "" # Reset the backup path if the loop recycles
                $finalGPObackupPath = "$gpoBackupPath\$dateDirectory"
                $gpoBackupNames = @() # Reset names array if the loop recycles
                # Default backups may contain a file such as readme. Only gather directory(GPO) names.
                $gpoBackupNames += Get-ChildItem -Directory -Path $finalGPObackupPath | Select-Object -ExpandProperty Name
                

                Write-Host -ForegroundColor Yellow ("`nGPOs from `'$dateDirectory`' backup. `n----------")
                ForEach ($gpo in $gpoBackupNames) { 
                    Write-Host("> $gpo")
                } # End ForEach-------------------------------


                # Confirm with user that this backup date is the one to import
                Write-Host -ForegroundColor Yellow ("----------`nIs the GPO Backup set from `'$dateDirectory`' your choice to import from?")
                do {
                    $confirmBackupDate = Read-Host ("(y/n)")
                    $confirmBackupDate = $confirmBackupDate -replace '\s', ''     # In case user enter spaces
                    $confirmBackupDate = $confirmBackupDate.ToLower()             # In case user uses any capitol letters.
                    If($confirmBackupDate -eq "yes") {$confirmBackupDate = "y"}
                    If($confirmBackupDate -eq "no") {$confirmBackupDate = "n"}
                } until (($confirmBackupDate -eq "y") -OR ($confirmBackupDate -eq "n"))
            } # End If/Else


        } until(($dateChoice -in 1..$arrayPos) -AND ($confirmBackupDate -eq "y"))
        If ($dateChoice -eq 0) {break}
        # If user did not break, then we chose the backup date/path, and have the gpo-names from that backup date


        # User just chose which backup to import, now create a safety backup if they wanted.
        # User must choose if a safety backup of all GPOs should be done. Sent as a parameter
        # A full import will overwrite all GPOs that have the same name as a GPO backup
        Write-Host -ForegroundColor Yellow ("`n----------`nStarting Safety Backup...")
        Start-Sleep -Seconds 5 # Pause just to show user the step.
        If ($safetyBackup -eq $true) {
            Set-BackupAllGPOs -encrypt $true
        } # End If-------------------------------


        # Gather list of all GPO names that are currently active in the domain.
        $currentGPOList = Get-AllGPOsNames
        $step=0


        Write-Host -ForegroundColor Yellow ("`nStarting full GPO import...")
        Start-Sleep -Seconds 5 # Pause just to show user the step.


        # Using GPO names gathered from previous GPO backups
        # If GPO name does not exist, create it, import backup
        # If GPO name does exist, just import most recent backup.
        # If OUs exists, Link to those previous OUs associated with GPO backups.
        ForEach ($gpo in $gpoBackupNames) {
            $step++ # Simple progress bar in the terminal. 
            Write-Progress -Activity "Importing Backups..." -Status "Progress:" -PercentComplete ($step/$gpoBackupNames.count*100)


            # Step to each latest backup: 
            # EX> C:\Program Files\WindowsPowerShell\Module\GPOFunctionsModule\GPOdata\GPOBackups\gpo1A\
            $currentBackup = "$finalGPObackupPath\$gpo"


            # This will not create a GPO if the name already exists i.e. active GPO
            # Only create GPOs if backup name does not exist in active GPOs
            # This is to account for imported GPO backups, to add that GPO to current Domain.
            If ($currentGPOList -notcontains $gpo) {
                New-GPO -Name $gpo -Comment "Created by:  Get-ImportAllGPOBackups.ps1; All new GPOs with Settings Imported from previous GPO Backups. `'$gpo`', `'$dateDirectory`'. <>"
            } # End If-------------------------------


            # There may be numerous backups for this GPO, only use the latest.
            # Backup is a directory, last one that was created, just get the name(likely a timestamp)
            # EX> 2021-07-08-104917
            #$latestBackup = Get-ChildItem $currentBackup | Where-Object {$_.PSIsContainer} | Sort-Object CreationTime -Descending | Select-Object -First 1 | Select-Object -ExpandProperty Name


            # Append lastest backup directory to the target backup path
            # EX> C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\fakeGPOwEverything\2021-07-08-104917\
            $currentBackup = "$finalGPObackupPath\$gpo" #$latestBackup"


            # If new GPO name now exists, with a matching backup name, import backup GPO settings
            Import-GPO -BackupGpoName $gpo -Path $currentBackup -TargetName $gpo


            # We just imported the policies/preferences into the new GPO
            # The original GPO links to OUs, were not included. Now link to prior captured OUs
            # Gather prior linked OUs from backed up file.
            # Test if exists, as imported backups may not have saved OUs to file
            $targetOUs = @()
            If (Test-Path -Path "$currentBackup\targetOUs.txt") {
                $targetOUs = Get-Content -Path "$currentBackup\targetOUs.txt"
            } # End If-------------------------------


            # This is a full import so all GPO links to OU should be overwritten
            # New GPO is created already, so source-gpo now equals dest-gpo
            Write-Warning("Overwrite OUs of GPO `'$gpo`' with OUs from GPO `'$gpo`', `'$dateDirectory`'") #`'$latestBackup`' ")


            # Remove OU links to target GPO, and re-write with source GPO-OU links
            # Gather all OUs with established GPO Links
            $linkedOUs = (Get-ADOrganizationalUnit -filter * | Get-GPInheritance).GPOLinks | Select-Object -Property Target, DisplayName


            # Selective data gathering, so filter OUs currently linked to target GPO
            $linkedOUs1 = $linkedOUs | Where-Object{($_.DisplayName -eq $gpo)}


            # We want to overwrite, so first remove all linked OUs in target GPO
            ForEach ($ou in $linkedOUs1) {
                Remove-GPLink -Name $gpo -Target $ou.Target
            } # End ForEach-------------------------------

            
            # Then Loop through all OUs linked to source GPO, and link them to the new GPO also
            # If $targetOUs for old GPO is empty, it will not link the GPO to any OU
            ForEach ($ou in $targetOUs) {
                New-GPLink -Name $gpo -Target $ou -LinkEnabled Yes
            } # End ForEach ($ou in $targetOUs)-------------------------------


            # Terminal line between each GPO results
            Write-Host("____________________________")
            

        } # End ForEach ($gpo in $gpoBackupNames)-------------------------------


        Write-Warning("NOTE - You may need to RE-OPEN Group Policy Management to refresh the new GPO and associated links.")
        # Group Policy Management Editor
        gpmc.msc
    
        
    } #End Function Get-ImportGPOsAllBackups-------------------------------
#===========================================
        
        
    
    

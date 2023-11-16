

Function Set-BackupSingleGPO {
<#
    .SYNOPSIS
    Create a backup of a single GPO.
    Includes both GPO policies and preferences, however if there are Domain shared items such as files, they will not be copied automatically if this import is targeted at an external GPO.


    .DESCRIPTION
    Uses default WindowsPowerShell Directory: C:\Program Files\WindowsPowerShell\
    Creates a \GPOdata\GPOBackups directory in this location if it does not exist.
    User calls this function and provides the name of the target GPO
    GPO backup saved to: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\


    .EXAMPLE
    Set-BackupSingleGPO -sourceGPOParam "xInstall 7zip" -encrypt $true
    # Back up GPO xInstall 7zip and Administrator encrypt the backup
-----------------------------------#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [String]
    $sourceGPOParam,
    [Parameter()]
    [String]
    $timestampParam,
    [Parameter()]
    [bool]
    $encrypt, 
    [Parameter()]
    [bool]
    $fullBackup
) #End Param


    # Default WindowsPowerShell directory + ...\GPOBackups
    # If this GPOFunctionsModule exists, the admin must have privs in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # $PSScriptRoot only works by executing the script. Selective execution(F8) will not be successful.
    # This works individually, but is built to be part of an imported WindowsPowerShell module.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $backupDirectory = "$functionPath\GPOdata\GPOBackups" 
    $fullBackupDirectory = "$functionPath\GPOdata\GPOFullBackup\" 
    # Mark individual GPO backups with a timestamp.
    $timestamp = ""
    If($timestampParam -eq "") {
        $timestamp = Get-Date -f 'yyyy-MM-dd-HHmmss'
    } Else {
        $timestamp = $timestampParam
    } # End If/Else-----------------------------------
    
    
    # Full backups are placed in seperate folder to keep the set together. 
    If ($fullBackup -eq $true) {
        $newBackupDirectory = "$fullBackupDirectory\$timestamp\$sourceGPOParam"
    } Else {
        # If called for individual backups
        $newBackupDirectory = "$backupDirectory\$sourceGPOParam\$timestamp"  
    } # End If-----------------------------------

    
    # Verify/create that a default WindowsPowerShell + new backup directory exists.
    If(!(Test-Path -Path $backupDirectory)) { #If backup directory has not been created yet
        New-Item -ItemType Directory "$backupDirectory"
        New-Item -ItemType File "$backupDirectory\README.txt"
        Add-Content "$backupDirectory\README.txt" -Value "Directory to hold Group Policy Object backups. Created by GPOFunctionsModule\Set-GPOBackupSingle. `nThis directory only holds GPO backups that are done individually through the GPOFunctionsModule. Full system GPO backups are held in `nC:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOFullBackup"
        
        # Lock folder. Only the creator can edit.
        (Get-ChildItem -Path $backupDirectory).Encrypt()
    } # End IF-----------------------------------


    # Verify/create that a default WindowsPowerShell + new backup directory exists.
    If(!(Test-Path -Path $fullBackupDirectory)) { #If backup directory has not been created yet
        New-Item -ItemType Directory $fullBackupDirectory
        New-Item -ItemType File "$fullBackupDirectory\README.txt"
        Add-Content "$fullBackupDirectory\README.txt" -Value "Directory to hold Group Policy Object backups. Created by GPOFunctionsModule\Set-GPOBackupSingle. `n`nThis is for FULL System GPO backups to keep the Full GPO Set together. A Full GPO backup import will only be gathered from here."
        
        # Lock folder. Only the creator can edit.
        (Get-ChildItem -Path $fullBackupDirectory).Encrypt()
    } # End IF-----------------------------------


    # Create timestamped backup location inside of named GPO backup directory. Do after verification above.
    New-Item -ItemType Directory $newBackupDirectory
    

    # Backup the stated GPO in the \GPOBackups directory.
    Backup-GPO -Name $sourceGPOParam -Path $newBackupDirectory


    # Stash a settings report for this GPO for every backup.
    # Settings report is just a file path
    $settingsReport = Find-AllGPOSettings -sourceGPOparam $sourceGPOParam -returnfile $true
    Copy-Item -Path $settingsReport -Destination $newBackupDirectory


    # Very First GPO backup, and only that one copies over these  also. Not sure why
    # Does not affect anything, but might as well remove them since they are meaningless
    If (Test-Path "$newBackupDirectory\$sourceGPOParam") {
        Remove-Item -Path "$newBackupDirectory\$sourceGPOParam"  
    }# End IF-----------------------------------


    If (Test-Path "$newBackupDirectory\GPOSettingsReports\"){ 
        Remove-Item -Path "$newBackupDirectory\GPOSettingsReports"
    }# End IF-----------------------------------


    If (Test-Path "$newBackupDirectory\README.txt"){ 
        Remove-Item -Path "$newBackupDirectory\README.txt"
    }# End IF-----------------------------------


    # GPO Backup does not record the OUs that the GPO is linked to.
    # We need to capture those linked OU addresses and save next to the backup
    # This grabs all linked OU/GPO and sections them off
    #$linkedOUs[$i].DisplayName     This is the GPO
    #$linkedOUs[$i].Target          This is the OU that the GPO is linked to.
    $linkedOUs = (Get-ADOrganizationalUnit -filter * | Get-GPInheritance).GPOLinks | Select-Object -Property Target, DisplayName
    

    # File with just linked OU addresses created right next to timestamped backup of GPO
    New-Item -ItemType File -Path "$newBackupDirectory\targetOUs.txt"


    # For the GPO being backed up, capture any of those OUs it is linked to.
    For($i=0; $i -lt $linkedOUs.Length; $i++) {
        If($sourceGPOParam -eq $linkedOUs[$i].DisplayName) {
            # Save OUs (addresses) next to the GPO backup, so they can be re-linked on a GPO import.
            # Each line on file is another OU that this GPO is linked to.
            $linkedOUs[$i].Target | Add-Content -Path "$newBackupDirectory\targetOUs.txt"
        } # End If-----------------------------------
    } # End For-----------------------------------


    # Lock folder. Only the creator can edit.
    # Gather every file in directory and Encrypt. Only the creator has access to files now.
    If ($encrypt -eq $true) { # ----------------IF/Else
        $items = (Get-ChildItem -Path $newBackupDirectory -File -Recurse) | Select-Object DirectoryName, Name
        
        ForEach ($item in $items) {
            $target = $item.DirectoryName + "\" + $item.Name
            (Get-ChildItem -Path $target).Encrypt()
        } # End ForEach-----------------------------------

        
        Write-Host -ForegroundColor Yellow ("`n`nGPO backup `'$sourceGPOParam`', `'$timestamp`' was admin encrypted. `nOnly the user that created this backup, will have future access to it. `nIn order to push out a backup or file for viewing, or for import by another user, `nThe creator can use PowerShell to decrypt:`n  
        > (Get-ChildItem <fileName>).Decrypt()
        > (Get-ChildItem <directoryName>).Decrypt() `n`nIf this GPO was created for a new GPO copy/merge, `nthen this temp GPO will be deleted after the copy/merge is complete.`n`n")
    } Else {
        Write-Host -ForegroundColor Yellow ("`n`nGPO backup `'$sourceGPOParam`', `'$timestamp`' was completed with no encryption. `nIf this GPO was created for a GPO copy/merge, `nthen this temp GPO will be deleted once complete.`n`n")
    }# End If/Else--------------------------------------

      
} # End Function Set-BackupSingleGPO---------
# -----------------------------------

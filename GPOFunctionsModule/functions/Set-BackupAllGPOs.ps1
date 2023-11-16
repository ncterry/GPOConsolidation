

Function Set-BackupAllGPOs {
<#
    .SYNOPSIS
    Create backups of all GPOs.
    -encrypt Parameter is mandatory.


    .DESCRIPTION
    Uses default WindowsPowerShell Directory: C:\Program Files\WindowsPowerShell\
    Creates \GPOBackups directories in this location if they do not exist.
    User calls this function.
    GPO backups saved to: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\


    .EXAMPLE
    Set-BackupAllGPOs -encrypt $true
    # All backups are Administrator encrypted


    .EXAMPLE
    Set-BackupAllGPOs -encrypt $false
    # All backups are not encrypted
-----------------------------------#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [bool]
    $encrypt
) #End Param-----------------------------------


    # Gather all local GPOs
    $gpoNamesArray = Get-AllGPOsNames


    # Default WindowsPowerShell directory + ...\GPOBackups
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $backupDirectory = "$functionPath\GPOdata\GPOFullBackup" 


    $timestamp = Get-Date -f 'yyyy-MM-dd-HHmmss'
    ForEach ($gpo in $gpoNamesArray) {

        # If encrypt send in as $true, the backup will be administrator-encrypted
        Set-BackupSingleGPO -sourceGPOParam $gpo -encrypt $encrypt -timestampParam $timestamp -fullBackup $true
        

    } #End ForEach ($gpo in $gpoNamesArray)
    Write-Warning("`n`nThis was a full system GPO backup. GPO set was all backed up to: `n$backupDirectory")
    
    
} #End Function Set-BackupAllGPOs-----------------------------------

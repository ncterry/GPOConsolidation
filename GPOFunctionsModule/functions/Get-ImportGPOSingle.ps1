

Function Get-ImportGPOSingle {
<#
    .SYNOPSIS
    This takes 2 GPOs. You can take an existing GPO, and create a new one; `nor just use 2 existing GPOs. This then creates a backup of the source GPO`n and then imports all polices/preferences into the destination GPO. `nThe Parameters include the names of the 2 GPOs, `nif you want one of those GPOs to be created here, and if you want to overwrite `nor combine the Organizational Unit links of the first GPO, in the second GPO.


    .DESCRIPTION
    All Parameters are mandatory.
    GPO1 exists already, and will be backed up here.
    GPO2 has not been created: $createNewGPO will be set to $true when called. 
    GPO2 has already been created, $createNewGPO will be set to $false when called.
    Then the policy/preferences are imported from the GPO1 backup.
    This straight backup/import will overwrite any pre-settings on the new GPO2
    

    .EXAMPLE
    > Get-ImportGPOSingle -sourceGPOParam oldGPO -destGPOParam targetGPO -createNewGPO $false -ouOverwrite $false
    # Target GPO that will be imported into, has already been created, and we will add the old OUs to the new OUs.


    .EXAMPLE
    > Get-ImportGPOSingle -sourceGPOParam oldGPO -destGPOParam targetGPO -createNewGPO $true -ouOverwrite $true
    # Target GPO will be created here, and then backup settings will be imported into the new GPO, and all OU's will be overwritten. Technically in this example, the new GPO is empty, but this would apply if we import into an existing GPO that has existing OUs already.
    
    
    .EXAMPLE
    > Get-ImportGPOSingle -sourceGPOParam oldGPO -destGPOParam targetGPO -createNewGPO $false -ouOverwrite $null
    # Target GPO that will be imported into, has already been created, $null = nothing will change with the OUs 
#>

[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [String] $sourceGPOParam,
    [Parameter(Mandatory = $true)] 
    [String] $destGPOParam, # The name of existing destination GPO, or name-to-be
    [Parameter(Mandatory = $true)] 
    [bool[]] $createNewGPO, # Default to false, to not create a new GPO,
    [Parameter(Mandatory = $true)]
    [String] $ouOverwrite

) #End Param-----------------------------------
    

    # If report directory does not exist, create one.
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $backupDirectory = "$functionPath\GPOdata\GPOBackups"  


    # Verify/create that a default WindowsPowerShell + new backup directory exists.
    If(!(Test-Path -Path $backupDirectory)) { #If backup directory has not been created yet
        # If report directory does not exist, create one.
        New-Item -ItemType Directory "$backupDirectory"
        New-Item -ItemType File "$backupDirectory\README.txt"
        Add-Content "$backupDirectory\README.txt" -Value "Directory to hold Group Policy Object backups. Created by GPOFunctionsModule\Set-GPOBackupSingle"
    } #End IF-----------------------------------


    # Backup the stated original GPO in the \GPOBackups directory.
    # This only works if the original GPO currently exists
    # To copy policies AND preference from a GPO into another, it must be done from a backup.
    # The PowerShell copy GPO function does not import GPO preferences, only policies
    Set-BackupSingleGPO -sourceGPOParam $sourceGPOParam
    

    # If a new GPO has not been previously created to import settings into. Create if param is true.
    If ($createNewGPO -eq $true) {
        New-GPO -Name $destGPOParam -Comment "Created by:  Get-ImportGPOSingle.ps1; Settings Imported from: $sourceGPOParam"
    } #End IF-----------------------------------


    # User will provide old GPO(backup with settings), and existing/new GPO(to import settings INTO)
    # Import will overwrite any prior settings. 
    # Be careful. Usually Best to use a new, blank GPO
    $backupDirectory = "$backupDirectory\$sourceGPOParam"
    

    # Grab the name of the most recent backup, likely a timestamp of the backup.
    # This is the backup that was just created a few lines above.
    $latestBackup = Get-ChildItem $backupDirectory | Where-Object {$_.PSIsContainer} | Sort-Object CreationTime -Descending | Select-Object -First 1 | Select-Object -ExpandProperty Name
    

    # Adjust the path to the target gpo --> latest backup
    $newBackupDirectory = "$backupDirectory\$latestBackup"


    # Import the GPO backup, into the new GPO
    Import-GPO -BackupGpoName $sourceGPOParam -Path $newBackupDirectory -TargetName $destGPOParam
    # Target GPO Description changes above, but it changes to the Description from the Imported GPO.
    # Change to a new Description
    (Get-GPO -Name $destGPOParam).Description="Created by:  Get-ImportGPOSingle.ps1; Settings Imported from: $sourceGPOParam, on $latestBackup"
    

    # Below is just a confirmation for user to view in terminal AFTER the change.
    Write-Output("GPO Desciption above is also imported from $sourceGPOParam.`nNow adjusted to: ")
    (Get-GPO -Name $destGPOParam).Description


    # Capture all active GPOs and the linked OU addresses currently linked to them
    # We need to prevent an error if adding the same OUs from sourceGPO
    # This grabs all linked OU/GPO and sections them off
    #$linkedOUs[$i].DisplayName     This is the GPO
    #$linkedOUs[$i].Target          This is the OU that the GPO is linked to.
    $linkedOUs = (Get-ADOrganizationalUnit -filter * | Get-GPInheritance).GPOLinks | Select-Object -Property Target, DisplayName
    

    # For the GPO being added to with OUs, capture any of the OUs it may already be linked to.
    # If a GPO Name on this list, matches the target GPO name, then grab any linked OU here.
    $destOUsArray = @()
    For($i=0; $i -lt $linkedOUs.Length; $i++) {
        If($destGPOParam -eq $linkedOUs[$i].DisplayName) {
            # Each line on file is another OU that this GPO is linked to.
            # $linkedOUs[$i].Target          This is the OU that the GPO is linked to.
            $destOUsArray += $linkedOUs[$i].Target
        } # End If-----------------------------------
    } # End For-----------------------------------


    # A direct GPO copy, will not import GPO preferences.
    # Importing a gpo backup into another GPO will bring the preferences.
    # We just imported the policies AND preferences into the new GPO, from the GPO backup
    # The original GPO's links to OUs, were not included in the default backup/import modules.
    # In backup, we also captured source GPO linked OUs in seperate file. Now link new GPO to prior captured OUs
    # Gather prior linked OUs from backed up file. From the $sourceGPOparam
    # Test if OU file exists, as backups not using this program may not have saved OUs, or were not linked.
    $targetOUs = @()
    If (Test-Path -Path "$newBackupDirectory\targetOUs.txt") {
        $targetOUs = Get-Content -Path "$newBackupDirectory\targetOUs.txt"
    } #End If-----------------------------------


    # Default New-GPLink will just add OU links on top of existing GPO OU links
    # Was parameter sent in to add or overwrite or ignore.
    If ($ouOverwrite -eq "false") { # Just add all source OUs on top of existing OUs
        # Loop through all OUs linked to source GPO, and link them to the new GPO also
        # If $targetOUs is empty, it will not link the GPO to any OU
        Write-Warning("Added OUs from GPO `'$sourceGPOParam`' into GPO `'$destGPOParam`'")
        ForEach ($ou in $targetOUs) {
            # If sourceGPO OU is NOT linked the destGPO, then add it also
            If(!($ou -in $destOUsArray)) {
                New-GPLink -Name $destGPOParam -Target $ou -LinkEnabled Yes
            } # End If-----------------------------------------------------
        } # End ForEach-Object-----------------------------------
    } # End If ($ouOverwrite -eq $false)----------------


    # All OUs on target GPO will be removed, and replaced with the source GPO OUs
    If ($ouOverwrite -eq "true") {
        Write-Warning("Overwrite OUs of GPO `'$destGPOParam`' with OUs from GPO `'$sourceGPOParam`'")
        
        # Remove OU links to target GPO, and re-write with source GPO-OU links
        # Gather all OUs with established GPO Links
        $linkedOUs = (Get-ADOrganizationalUnit -filter * | Get-GPInheritance).GPOLinks | Select-Object -Property Target, DisplayName
        
        # Selective data gathering, so filter OUs currently linked to target GPO
        $linkedOUs1 = $linkedOUs | Where-Object{($_.DisplayName -eq $destGPOParam)}

        # We want to overwrite, so first remove all linked OUs in target GPO
        ForEach ($ou in $linkedOUs1) {
            Remove-GPLink -Name $destGPOParam -Target $ou.Target
        } # End ForEach-----------------------------------

        # Then Loop through all OUs linked to source GPO, and link them to the new GPO also
        # If $targetOUs for old GPO is empty, it will not link the GPO to any OU
        ForEach ($ou in $targetOUs) {
            New-GPLink -Name $destGPOParam -Target $ou -LinkEnabled Yes
        } # End ForEach-Object  
    } # End If ($ouOverwrite -eq $true)

    
    If ($ouOverwrite -eq "null") {
        Write-Warning("Keep existing OUs of $destGPOParam with no change")
    } # End If


    Write-Host("`n`nNOTE - You may need to RE-OPEN Group Policy Management to refresh the new GPO and associated links.`n")


    # Delete backups that were not intended to be remaining as backups.
    # Backups called from this module were just to import prior settings.
    Remove-Item -Path $newBackupDirectory -Recurse -Force
    # This is a double remove to make sure the backup removes files, and then the empty directory
    # Goes through full backup directory, and removes anything that is empty
    Get-ChildItem "$functionPath\GPOdata\GPOBackups" -Recurse -Force | Where{$_.PSIsContainer -AND (Get-ChildItem $_.FullName -Force -Recurse | ? {$_.PSIsContainer}).Count -eq 0} | Remove-Item -Recurse -Force


    Write-Host -ForegroundColor Yellow ("Backups created through Get-ImportGPOSingle.ps1 are just for imports. `nTemporary backup for `'$sourceGPOParam, `'$latestBackup`' was deleted.")


} #End Function Get-ImportGPOSingle-----------------------------------
<#========================#>
    
    



Function Get-GPOsRegistryValues {
<#
    .SYNOPSIS
    Find the Registry values i.e. policy keys associated with a GPO. This will progress through any key-path given, and will also return error messages for all sub-paths that do not hold a registry key.

    .DESCRIPTION
    Simply returns registry values from a target registry path.
    This can be set in a loop to cover all registry paths, or all GPOs for a target keypath.

    .Example
    Get-GPOsRegistryValues -gpoNameParam Secure_computer -keyParam 'HKCU\Software'

    .Example
    Get-GPOsRegistryValues -gpoNameParam "Secure_computer" -keyParam "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies"

    .Example
    Get-GPOsRegistryValues -gpoNameParam Secure_computer -keyParam 'HKCU\Software' | Out-Gridview

    .OUTPUTS
    SAMPLE ERROR - Powershell red-text with this comment below, indcates that there is no registry value in that location.
    Get-GPRegistryValue : The following Group Policy registry setting was not found: 
    "HKEY_CURRENT_USER\Software\Policies\Microsoft\SystemCertificates\Trust\Certificates".
    Parameter name: keyPath

#> 
[CmdletBinding()]
Param(
    [Parameter()]
    [string] $gpoNameParam,
    [Parameter()]
    [string] $keyParam
) # End Param-------------------------------


    # Get-GPRegistryValue is a built in module. Gather primary registry values
    $initialRegistryValues = Get-GPRegistryValue -Name $gpoNameParam -Key $keyParam -ErrorAction SilentlyContinue
    # If report directory does not exist, create one.
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $resultsDirectory = "$functionPath\GPOdata"  
    $primaryDirectory = "$resultsDirectory\GPORegistryValues"
    $currentDirectory = "$resultsDirectory\GPORegistryValues\$gpoNameParam"
    # Timestamp captured in 4_GPOsRegistryValuesMenu.ps1 to prevent loop changes
    $resultsFile = "$resultsDirectory\GPORegistryValues\$gpoNameParam\$global:timestampX`_registryRecords.txt"
    

    # Check for /create a primary registry collection records directory.
    If (!(Test-Path -Path $primaryDirectory)) {
        New-Item -itemtype  Directory $primaryDirectory
        New-Item -itemtype File "$primaryDirectory\README.txt"
        Add-Content "$primaryDirectory\README.txt" -Value "Directory to hold a collection of Group Policy Object registy values. Created by GPOFunctionsModule\Get-GPOsRegistryValues"
    } #End If-------------------------------
    

    # Check for /create timestamped records directory/file
    If (!(Test-Path -Path $currentDirectory)) {
        New-Item -itemtype Directory $currentDirectory
    } #End If-------------------------------


    If (!(Test-Path -Path $resultsFile)) {
        New-Item -itemtype File $resultsFile
        Write-Output("$resultsfile")
        $domain = Get-GPOsDomain -writehost $false          #false=dont print to terminal
        $dc = Get-GPOsDomainController -writehost $false    #false=dont print to terminal
        Add-Content $resultsFile -Value ("Domain: $domain `nDomain Controller: $dc `nGroup Policy Object: $gpoNameParam Registry Records `n") # Title the results file with the GPO name

        # File Header with user's target registry path 
        Add-Content $resultsFile -Value "`n===========`nREGISTRY BASE PATH: $keyParam `n===========`n"
        (Get-Item -Path $resultsFile).Encrypt()
    } #End If-------------------------------


    ForEach ($registryValue in $initialRegistryValues) {
        If ($registryValue.ValueName){ # If the registry value is valid/active
            $registryValue # Display a found registry value in the terminal.
            # Add active registry values to the records file.
            Add-Content $resultsFile -Value "::::::::::ValueName:::::::::::: ", $registryValue.ValueName
            Add-Content $resultsFile -Value "::::::::::KeyPath:::::::::::::: ", $registryValue.KeyPath
            Add-Content $resultsFile -Value "::::::::::FullKeyPath:::::::::: ", $registryValue.FullKeyPath
            Add-Content $resultsFile -Value "::::::::::Hive::::::::::::::::: ", $registryValue.Hive
            Add-Content $resultsFile -Value "::::::::::PolicyState:::::::::: ", $registryValue.PolicyState
            Add-Content $resultsFile -Value "::::::::::Value:::::::::::::::: ", $registryValue.Value
            Add-Content $resultsFile -Value "::::::::::Type::::::::::::::::: ", $registryValue.Type
            Add-Content $resultsFile -Value "::::::::::HasValue::::::::::::: ", $registryValue.HasValue
            Add-Content $resultsFile -Value "`n===========`n===========`n===========`n===========`n===========`n"
            (Get-Item -Path $resultsFile).Encrypt()
        } Else {
            # FullKeyPath = Recursive registry path, based on initial key.
            # HKCU\Software   will search recursively down everything under HKCU\Software\....
            Get-GPOsRegistryValues -keyParam $registryValue.FullKeyPath -gpoNameParam $gpoNameParam
        } #End If/Else-------------------------------


    } # End Foreach-------------------------------
    # Make sure registry values are encrypted. Only the creator can access them.

    
} # End Function Get-GPOsRegistryValues-------------------------------

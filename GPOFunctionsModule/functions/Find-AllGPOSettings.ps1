
Function Find-AllGPOSettings {
<#
    .SYNOPSIS
    View all settings, policies, preferences, and links in a single GPO


    .DESCRIPTION
    Input the name of an active GPO. ($sourceGPOParam) This is a mandatory parameter.
    This collects all settings from that GPO both Policies and Preferences
    Exports this settings to an HTML that can be viewed in any browser.


    .EXAMPLE
    > Find-AllGPOSettings -sourceGPOParam "gpoName"
    # Get full settings report for a specific GPO. Files will be saved, and displayed.


    .EXAMPLE
    > Find-AllGPOSettings -sourceGPOParam "Install 7zip" -returnfile $true
    # Get full settings report for a specific GPO. Files will be saved, and displayed.
    # HTML settings report will also be returned to the caller


#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [String] 
    $sourceGPOParam,
    [Parameter()]
    [bool[]]
    $returnfile
) #End Param-------------------------------

    # If report directory does not exist, create one.
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # $PSScriptRoot only works by executing the script. Selective execution(F8) will not be successful.
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $reportDirectory = "$functionPath\GPOdata\GPOSettingsReports"
    $subDirectory = "$reportDirectory\$sourceGPOParam"


    # Main results directory first
    If (!(test-path "$reportDirectory\README.txt")) {
        New-Item -ItemType Directory "$reportDirectory"
        New-Item -ItemType File "$reportDirectory\README.txt"
        Add-Content -Path "$reportDirectory\README.txt" -Value "GPO Information Policies and Preferences harvested by \GPOFunctionsModule\Find-AllGPOSettings.ps1"
        (Get-ChildItem -Path "$reportDirectory\README.txt").Encrypt()
    } #End If-------------------------------


    # results subdirectory 
    If (!(test-path $subDirectory)) {
        New-Item -ItemType Directory $subDirectory # Full path to target GPO results. Will create reportDirectory also      
        New-Item -ItemType File "$subDirectory\README.txt"
        Add-Content -Path "$subDirectory\README.txt" -Value "Full GPO Information Policies and Preferences harvested by \GPOFunctionsModule\Find-AllGPOSettings.ps1 for $sourceGPOParam"
        (Get-ChildItem -Path "$subDirectory\README.txt").Encrypt()
    } #End If-------------------------------


    # Gather Domain and domain controller
    $domain = Get-GPOsDomain -writehost $false
    $dc = Get-GPOsDomainController -writehost $false


    # Mark individual GPO backups with a timestamp.
    $timestamp = Get-Date -f 'yyyy-MM-dd-HHmmss'


    # Gather report on target GPO
    $htmlFileName = $timestamp + "_htmlReport.html"
    $xmlFileName = $timestamp + "_xmlReport.xml"

    
    # One call for Find-AllGPOSettings also wants a settings report returned for the GPO
    If ($returnfile -eq $true) {
        # Create report files
        Get-GPOReport -Name $sourceGPOParam -Domain $domain -Server $dc -ReportType HTML -Path "$subDirectory\$htmlFileName"
        (Get-Item -Path "$subDirectory\$htmlFileName").Encrypt()
        Start-Sleep -Seconds 1 # Seems to be moving too fast sometimes. Add pause

        # Return file path, then copy the file
        return ("$subDirectory\$htmlFileName")
        
    } Else {
        # Create report files
        Get-GPOReport -Name $sourceGPOParam -Domain $domain -Server $dc -ReportType HTML -Path "$subDirectory\$htmlFileName"
        Start-Sleep -Seconds 1 # Seems to be moving too fast sometimes. Add pause
        (Get-Item -Path "$subDirectory\$htmlFileName").Encrypt()
        

        Get-GPOReport -Name $sourceGPOParam -Domain $domain -Server $dc -ReportType Xml -Path "$subDirectory\$xmlFileName"
        Start-Sleep -Seconds 1 # Seems to be moving too fast sometimes. Add pause
        (Get-Item -Path "$subDirectory\$xmlFileName").Encrypt()


        Write-Warning("`n`nGPO:   `'$sourceGPOParam`' `n`nSettings Results Saved to:`n $subDirectory`n`n")
        #explorer.exe "$subDirectory\$htmlFileName" #Open results file
        Invoke-Item "$subDirectory\$htmlFileName" #Open results file
    } # End If/Else-------------------------------
    

} #End Function Find-AllGPOSettings-------------------------------
#=================================

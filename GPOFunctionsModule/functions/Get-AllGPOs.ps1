#===============================
Function Get-AllGPOs {
<#
    .SYNOPSIS
    From the Domain Controller, this collects summary info for the associated Group Policy Objects

    .Example
    > Get-AllGPOs -gridview $false
    # Results printed to terminal

    .Example
    > Get-AllGPOs -gridview $true
    # Results printed to gridview

    .OUTPUTS
    (SAMPLE GPO)
    Id               : 12408609-af63-4c86-9093-3465ed598e6c
    Path             : cn={12408609-AF63-4C86-9093-3465ED598E6C},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal
    DisplayName      : xTestNCTGPO
    GpoStatus        : AllSettingsEnabled
    WmiFilter        :
    CreationTime     : 5/17/2021 8:38:27 AM
    ModificationTime : 5/19/2021 12:19:24 PM
    User             : Microsoft.GroupPolicy.UserConfiguration
    Computer         : Microsoft.GroupPolicy.ComputerConfiguration
#> 
#===============================
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [bool] $gridview
) #End Param-------------------------------


    # Gather Domain Controller
    $dc = Get-GPOsDomainController -writeHost $false 
    # Just grab the DNSroot name, (full domain example: WidgetLLC2.Internal).
    $domain = Get-GPOsDomain -writehost $false


    # Gather Group Policy Objects from the Domain Controller
    $gpoCollection = Get-GPO -All -Server $dc | Select-Object ID, Path, DisplayName, GPOStatus, WMIFilter, CreationTime, ModificationTime, User, Computer

    # Create a hash table to hold Group Policy Objects
    $gpoHash = @{}


    # Append Group Policy Objects collected from the Domain Controller to the hash table
    ForEach ($gpo in $gpoCollection) { $gpoHash.Add($gpo.Path, $gpo) }


    # Export Scope of Management results to CSV report. 
    # Primary path Created in GPOFunctionsModule.psm1 when Imported
    # Include timestamp for csv export
    $timestamp = Get-Date -f 'yyyy-MM-dd-HHmmss'
    # If report directory does not exist, create one.
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $resultsPath = "$functionPath\GPOdata\GPOScanResults"


    If (!(Test-Path -Path $resultsPath)) {
        New-Item -ItemType Directory $resultsPath
        New-Item -ItemType File "$resultsPath\README.txt"
        Add-Content -Path "$resultsPath\README.txt" -Value "Scan results from GPOFunctionModule\Get-AllGPOs.ps1"
        (Get-ChildItem -Path $resultsPath).Encrypt() # Only creator can access
    } #End If (!(Test-Path-------------------------------


    $filePath = "$resultsPath\$timestamp`_reportGPOHashTable.csv"
    $allGPOs = Get-AllGPOsNamesNumbered


    # Export to save results, and to import as different formats from CSV.
    # HashTable needs a GetEnumerator() to export to CSV
    # Only place 'Value' from each GPOhash in the file.
    # 'Value' is a large object with assorted info on the GPO
    $gpoHash.GetEnumerator()  | Select-Object -Property Value | Export-Csv -Path $filePath -NoTypeInformation
    (Get-Item -Path $filePath).Encrypt() # Only creator can access


    # Parameter option to display results in just terminal, or in Gridview also
    If ($gridview -eq $false) {
        # Display the table in the terminal as well.
        $gpoSet = Import-Csv $filePath 
        $gpoSet = $gpoSet -split "@"
        $gpoSet = $gpoSet -split ";"
        $gpoSet # Write to terminal
    } ElseIf ($gridview -eq $true) {
        # Display results in the grid.
        $gpoSet = Import-Csv $filePath 
        $gpoSet = $gpoSet -split "@"
        $gpoSet = $gpoSet -split ";"
        $gpoSet | Out-GridView -Title "Basic Info Summary of all local Group Policy Objects"
    } # End If/ElseIf-------------------------------


    # Display numbered list of all GPO Names
    Write-Host("`n`n`n")
    $allGPOs


    # View results path
    Write-Host("`n`nResults: `n$filePath `n")


    # Used for get-gposScopeOfManagement. Do not print/export $gpoHash
    return $gpoHash

} # End Function Get-AllGPOs-------------------------------
<#===============================
-->Count total amount of GPOs
$GPOHash.Count      #Example: 15

-->Key is the policy path
$GPOHash.Keys       #Exmample[1]: cn={36787D68-710E-4762-8FE3-6C66AABD3D46},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal

=======================================#>

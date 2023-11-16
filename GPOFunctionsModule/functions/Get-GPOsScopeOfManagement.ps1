# SOM: Scope of Management
Function Get-GPOsScopeOfManagement {
<#
    .SYNOPSIS
    SOM: Scope of Management: Any location where a GPO is linked to such as a domain, or OU

    .DESCRIPTION
    If No Parameters, simply returns full scope of management information for GPO links

    .EXAMPLE
    Get-GPOScopeOfManagement

    .EXAMPLE
    Get-GPOScopeOfManagement -Path "OU=Domain Computers,OU=serveracademy,DC=WidgetLLC2,DC=Internal"

    .EXAMPLE
    Get-GPOScopeOfManagement | Out-Gridview

    .OUTPUTS
    ...
    OUDN                  : OU=Domain Computers,OU=serveracademy,DC=WidgetLLC2,DC=Internal
    BlockInheritance      : False
    LinkEnabled           : True
    Enforced              : False
    Precedence            : 3
    DisplayName           : xInstall Chrome
    GPOStatus             : AllSettingsEnabled
    WMIFilter             : 
    GUID                  : {db66e242-61e6-41d9-bb2e-04f0717a16f2}
    GPOCreated            : 5/18/2021 9:43:25 AM
    GPOModified           : 5/19/2021 12:18:56 PM
    UserVersionDS         : 0
    UserVersionSysvol     : 0
    ComputerVersionDS     : 1
    ComputerVersionSysvol : 1
    PolicyDN              : cn={DB66E242-61E6-41D9-BB2E-04F0717A16F2},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal

#>
Param(
    [Parameter()]
    [string]
    $Path
) # End Param-------------------------------


    # Empty array to hold all possible GPO link Scope of Management
    $groupPolicyLinks = @()
    $groupPolicyLinks = Get-GPOsLinks -Path $Path
    $gpoHashTable = Get-GPOsHashTable
    # Empty report array
    $gpoReportSOM = @()

    # SOM = Scope of Management -  to any location where a group policy could be linked: domain, OU, site.
    # Move through Group Policy Object link Scope of Management collected
    ForEach ($scopeOfManagement in $groupPolicyLinks) {
        
        # Filter out policy Scope of Management that have a policy linked
        If ($scopeOfManagement.gPLink) {

            # If an OU has 'Block Inheritance' set (gPOptions=1) and no Group Policy Objects linked,
            # then the gPLink attribute is no longer null but a single space.
            # There will be no gPLinks to parse, but we need to list it with BlockInheritance.
            If ($scopeOfManagement.gPLink.length -gt 1) {

                # Use @() for force an array in case only one object is returned.)
                # Example gPLink value:
                #   [LDAP://cn={DB66E242-61E6-41D9-BB2E-04F0717A16F2},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal;2][LDAP://cn={046584E4-F1CD-457E-8366-F48B7492FBA2},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal;0][LDAP://cn={12845926-AE1B-49C4-A33A-756FF72DCC6B},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal;1]
                # Split out the links enclosed in square brackets, then filter out
                # the null result between the closing and opening brackets ][
                $linksFound = @($scopeOfManagement.gPLink -split {$_ -eq '[' -or $_ -eq ']'} | Where-Object {$_})
                
                # Use a for loop with a counter so that we can calculate the precedence value
                For ( $i = $linksFound.count - 1 ; $i -ge 0 ; $i-- ) {
                    # Example gPLink individual value (note the end of the string):
                    #   LDAP://cn={DB66E242-61E6-41D9-BB2E-04F0717A16F2},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal;2
                    # Splitting on '/' and ';' gives us an array every time like this:
                    #   0: LDAP:
                    #   1: (null value between the two //)
                    #   2: distinguishedName of policy
                    #   3: numeric value for gPLinkOptions (LinkEnabled and Enforced)
                    $gpoInfo = $linksFound[$i] -split {$_ -eq '/' -or $_ -eq ';'}
                    
                    # Add a report row for each Group Policy Object link
                    $gpoReportSOM += New-Object -TypeName PSCustomObject -Property @{
                        Name              = $scopeOfManagement.Name;
                        OUDN              = $scopeOfManagement.distinguishedName;
                        PolicyDN          = $gpoInfo[2];
                        Precedence        = $linksFound.count - $i
                        GUID              = "{$($gpoHashTable[$($gpoInfo[2])].ID)}";
                        DisplayName       = $gpoHashTable[$gpoInfo[2]].DisplayName;
                        GPOStatus         = $gpoHashTable[$gpoInfo[2]].GPOStatus;
                        WMIFilter         = $gpoHashTable[$gpoInfo[2]].WMIFilter.Name;
                        GPOCreated        = $gpoHashTable[$gpoInfo[2]].CreationTime;
                        GPOModified       = $gpoHashTable[$gpoInfo[2]].ModificationTime;
                        UserVersionDS     = $gpoHashTable[$gpoInfo[2]].User.DSVersion;
                        UserVersionSysvol = $gpoHashTable[$gpoInfo[2]].User.SysvolVersion;
                        ComputerVersionDS = $gpoHashTable[$gpoInfo[2]].Computer.DSVersion;
                        ComputerVersionSysvol = $gpoHashTable[$gpoInfo[2]].Computer.SysvolVersion;
                        Config            = $gpoInfo[3];
                        LinkEnabled       = [bool](!([int]$gpoInfo[3] -band 1));
                        Enforced          = [bool]([int]$gpoInfo[3] -band 2);
                        BlockInheritance  = [bool]($scopeOfManagement.gPOptions -band 1)
                        
                    } # End gpoReport--------------------------------------------------------------
                } # End For ( $i = $linksFound.count----------------------------------------
            } #End If ($scopeOfManagement.gPLink.length----------------------------
        } #End If ($scopeOfManagement.gPLink)-------------------------------
    } # End ForEach ($scopeOfManagement in $groupPolicyLinks) {-------


    # Output the results to CSV file for viewing in Excel
    $gpoReportSOM | Select-Object OUDN, BlockInheritance, LinkEnabled, Enforced, Precedence,  DisplayName, GPOStatus, WMIFilter, GUID, GPOCreated, GPOModified, UserVersionDS, UserVersionSysvol, ComputerVersionDS, ComputerVersionSysvol, PolicyDN


    # Output the results to CSV file for viewing in Excel
    $gpoReportSOM | Select-Object OUDN, BlockInheritance, LinkEnabled, Enforced, Precedence, DisplayName, GPOStatus, WMIFilter, GUID, GPOCreated, GPOModified, UserVersionDS, UserVersionSysvol, ComputerVersionDS, ComputerVersionSysvol, PolicyDN


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
    $resultsDirectory = "$functionPath\GPOdata\GPOScanResults"


    If (!(Test-Path -Path $resultsDirectory)) {
        New-Item -ItemType Directory $resultsDirectory
        New-Item -ItemType File -Name "README.txt"
        Add-Content -Path "$resultsDirectory\README.txt" -Value "This results directory was created from a Scope of Management search for Group Policy Objects and linked Organizational Units. This was done by the WindowsPowerShell Module: GPOFunctionsModule\Get-GPOsScopeOfManagement.ps1"
    } # End If (!(Test-Path-------------------------------


    $filePath =  "$resultsDirectory\$timestamp`_reportScopeOfManagment.csv"
    $gpoReportSOM | Export-Csv -Path $filePath -NoTypeInformation
    #$gpoReportSOM | Format-Table
    #$gpoReportSOM | Out-GridView
    

    # View results path
    Write-Host("Results: $filePath `n")
    return $gpoReportSOM


} #End Function Get-GPOScopeOfManagement-------------------------------




Function Get-GPOsLinks {
<#
    .SYNOPSIS
    SOM: Scope of Management: Any location where a GPO is linked to such as a domain, or OU

    .DESCRIPTION
    No Mandatory Parameters. Simply returns GPO links

    .EXAMPLE
    Get-GPOLinks

    .EXAMPLE
    Get-GPOLinks | Out-Gridview

    .EXAMPLE
    Get-GPOLinks -Path "OU=serveracademy,DC=WidgetLLC2,DC=Internal"
    # A target address can be sent, otherwise it will cycle through all potential OU addresses

    .OUTPUTS
    name    
    ----
    WidgetLLC2 
    Domain Controllers
    serveracademy 
    Domain Groups
    SubGroups
    
    distinguishedName   
    -----------------    
    DC=WidgetLLC2,DC=Internal                    
    OU=Domain Controllers,DC=WidgetLLC2,DC=Internal         
    OU=serveracademy,DC=WidgetLLC2,DC=Internal        
    OU=Domain Groups,OU=serveracademy,DC=WidgetLLC2,DC=Internal                                                                         
    OU=SubGroups,OU=Domain Groups,OU=serveracademy,DC=WidgetLLC2 DC=Internal                                                             
   
    gPLink                                               
    ------                                               
    [LDAP://CN={31B2F340-016D-11D2-945F-00C04FB984F9},...
    [LDAP://CN={6AC1786C-016F-11D2-945F-00C04fB984F9},...
    [LDAP://cn={835e8b34-0d44-4b8e-9014-44f54f6f153f},...
    [LDAP://cn={F09D30FD-81AE-4F7B-9F5C-8343D98975BB},...
    [LDAP://cn={B85E5983-8FED-4BA1-94E5-46537516EF0B},...
#>
Param(
    [Parameter()]
    [string]
    $Path
) # End Param-------------------------------


    # Array to append all Group Policy Objects with links in the SOMs
    $groupPolicyLinks = @()
    $gpoDomainController = Get-GPOsDomainController  -writeHost $false 


    # PSBoundParameters is a built in hashtable containing params passed to a script or function.
    If ($PSBoundParameters.ContainsKey('Path')) {
        $groupPolicyLinks += Get-ADObject -Server $gpoDomainController -Identity $Path -Properties name, distinguishedName, gPLink, gPOptions | Select-Object name, distinguishedName, gPLink, gPOptions

    } Else {
        (Get-ADOrganizationalUnit -filter * | Get-GPInheritance).GPOLinks | Select-Object -Property Target, DisplayName, Enabled, Order, GpoId | Format-Table

        # Group Policy Objects linked to the root of the domain
        # Get-ADDomain does not return the groupPolicyLinks attribute
        $groupPolicyLinks += Get-ADObject -Server $gpoDomainController -Identity (Get-ADDomain).distinguishedName -Properties name, distinguishedName, gPLink, gPOptions | Select-Object name, distinguishedName, gPLink, gPOptions

        # Group Policy Objects linked to Organizational Units
        # Get-GPO does not return the $groupPolicyLinks attribute
        $groupPolicyLinks += Get-ADOrganizationalUnit -Server $gpoDomainController -Filter * -Properties name, distinguishedName, gPLink, gPOptions | Select-Object name, distinguishedName, gPLink, gPOptions

        # Group Policy Objects linked to sites
        $groupPolicyLinks += Get-ADObject -Server $gpoDomainController -LDAPFilter '(objectClass=site)' -SearchBase "CN=Sites, $((Get-ADRootDSE).configurationNamingContext)" -SearchScope OneLevel -Properties name, distinguishedName, gPLink, gPOptions | Select-Object name, distinguishedName, gPLink, gPOptions
    
    } #End If/Else-------------------------------


    # Export results to report. 
    # $Results path Created in GPOFunctionsModule.psm1 when Imported
    # Include timestamp for csv export
    $timestamp = Get-Date -f 'yyyy-MM-dd-HHmmss'
    # If report directory does not exist, create one.
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $resultsDirectory = "$functionPath\GPOdata\OUsWActiveLinks"
    $filePath =  "$resultsDirectory\$timestamp`_reportGroupPolicyLinks.csv"

    
    # If the results path does not exists, create and secure it.
    If (!(Test-Path -Path $resultsDirectory)) {
        New-Item -ItemType Directory $resultsDirectory
        New-Item -ItemType File -Name "README.txt"
        Add-Content -Path "$resultsDirectory\README.txt" -Value "This results directory was created from a Scope of Management search for Group Policy Objects and linked Organizational Units. These are Organizational Units that have established links. This was done by the WindowsPowerShell Module: GPOFunctionsModule\Get-GPOLinks.ps1"
        (Get-ChildItem -Path $resultsDirectory).Encrypt() #Lock results for everyone but created
    } #End If (!(Test-Path-------------------------------


    $groupPolicyLinks | Export-Csv -Path $filePath -NoTypeInformation
    (Get-Item -Path $filePath).Encrypt() #Lock results for everyone but created
    # View results folder
    Write-Host("Results: $filePath `n")
    Write-Host("Scope of Management: Any location where a GPO is linked to such as a domain, or OU")

    
    #Write-Output("$groupPolicyLinks")
    return $groupPolicyLinks


} #end Function Get-GPOsLinks-------------------------------
#=============================

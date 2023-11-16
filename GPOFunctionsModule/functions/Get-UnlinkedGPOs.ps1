Function Get-UnlinkedGPOs {
<#
.SYNOPSIS
Discover all GPO policies, and indicate it the GPO has a linked status.


.DESCRIPTION
No Parameters. Simply returns GPO list and indicates the linked status


.EXAMPLE
Get-UnlinkedGPOs


.EXAMPLE
Get-UnlinkedGPOs | Out-Gridview


.OUTPUTS
whenCreated       : 5/20/2021 1:32:34 PM
whenChanged       : 5/20/2021 1:45:56 PM
Linked            : {True}
DisplayName       : xPreferenceShareFile
Name              : {F09D30FD-81AE-4F7B-9F5C-8343D98975BB}
DistinguishedName : CN={F09D30FD-81AE-4F7B-9F5C-8343D98975BB},CN=Policies,CN=System,DC=WidgetLLC2,DC=Internal

whenCreated       : 6/1/2021 3:25:36 PM
whenChanged       : 6/7/2021 11:57:18 AM
Linked            : {}
DisplayName       : fakeGPOwEverything
Name              : {6795095C-7502-4508-A9CD-6862D0BAF99D}
DistinguishedName : CN={6795095C-7502-4508-A9CD-6862D0BAF99D},CN=Policies,CN=System,DC=WidgetLLC2,DC=Internal

#>

    # Get all policies, and put it in a hash, whether linked or unlinked.
    $gpoFindings = Get-ADObject -Filter * -SearchBase "CN=Policies,CN=System,$((Get-ADDomain).Distinguishedname)" -SearchScope OneLevel -Property DisplayName, whenCreated, whenChanged
    $gpoHashTable = @{}


    ForEach ($Policy in $gpoFindings) {
        $gpoHashTable.Add($Policy.DistinguishedName,$Policy)
    } #End ForEach-----------------------------------


    # If a policy is linked, add it to our list.
    $gpoLinks = Get-ADOrganizationalUnit -Filter * | Select-Object -ExpandProperty LinkedGroupPolicyObjects -Unique
    $gpoLinks += Get-ADDomain | Select-Object -ExpandProperty LinkedGroupPolicyObjects -Unique


    # Note each one that is linked.
    ForEach ($Policy in $gpoLinks) {
        $gpoHashTable[$Policy].Linked = $true
    } #End ForEach-----------------------------------

    
    # Indicate link status
    $gpoHashTable.Values | Select-Object whenCreated, whenChanged, Linked, DisplayName, Name, DistinguishedName
    

} # End Function Get-UnlinkedGPOs -----------------------------------

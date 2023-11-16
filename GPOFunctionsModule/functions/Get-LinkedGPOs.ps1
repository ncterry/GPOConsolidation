
Function Get-LinkedGPOs {
<#
    .SYNOPSIS
    Choose a target Organizational Unit, and view all linked GPOs to this OU


    .EXAMPLE
    > Get-LinkedGPOs


    .EXAMPLE
    # View linked GPOs in terminal. This function will always default to terminal
    # ----------------------------
    > Get-LinkedGPOs -gridview $false
    


    .EXAMPLE
    # View linked GPOs in gridview
    # -------------------------------
    > Get-LinkedGPOs -gridview $true
    



    .OUTPUTS
    DisplayName      : fakeGPOwEverything
    DomainName       : WidgetLLC2.Internal
    Owner            : WIDGETLLC2\Domain Admins
    Id               : 6795095c-7502-4508-a9cd-6862d0baf99d
    GpoStatus        : AllSettingsEnabled
    Description      :
    CreationTime     : 6/1/2021 3:25:36 PM
    ModificationTime : 7/14/2021 9:30:56 AM
    UserVersion      : AD Version: 41, SysVol Version: 41
    ComputerVersion  : AD Version: 31, SysVol Version: 31
    WmiFilter        :
-----------------------------------
#>
Param(
    [Parameter()]
    [bool]
    $gridview
) # End Param-----------------------------------


    # Create a list of all group policy objects in a hash table.
    # ----------------------------------------------------------
    $OUs = Get-ADOrganizationalUnit -Filter * 
    $ouAddress, $ouChoice = ""
    do {
        Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
        Clear-Host
        Write-Host ("Primary Organizational Units in this domain:`n")
        $counter = 0
        
        # Shows canonical name, not needed.
        #Get-ADOrganizationalUnit -Properties CanonicalName -Filter * | Sort-Object CanonicalName | Format-Table CanonicalName


        # List the primary OUs for user to see, and choose from based on stated number position
        ForEach ($ou in $OUs) {
            $counter++
            Write-Host -ForegroundColor Yellow ("$counter) $ou")  
        } # End ForEach ($ou in $OUs)-----------------------------------
        

        # Let user enter a target OU to find connected GPOs
        # User can enter an OU address, or pick a number from the displayed list.
        
        $ouChoice = Read-Host "`nEnter  0  to Return to Menu, or...`nEnter the target OU DistinguishedName. `nExample: `n`tOU=Domain Computers,OU=serveracademy,DC=WidgetLLC2,DC=Internal `n`nOr, enter the number next to the primary OUs listed"  
        

        # Convert number selection to an OU address from primary list that was displayed.
        # If user chose number from OU position in list
        If ($ouChoice -eq 0) {
            break
        } ElseIf (($ouChoice -eq 1) -AND ($counter -eq 1)) {
            # Account for only one OU available
            $ouAddress = $OUs
        } ElseIf (($ouChoice -in 1..$counter) -AND ($counter -gt 1)) {   
            # Drop one number to work with 0-# array format
            $ouAddress = $OUs[$ouChoice - 1]
        } Else {
            $ouAddress = $ouChoice # If user enters a address not a selection   
        }# End If-----------------------------------


        Write-Host -ForegroundColor Yellow ("`n`nOU Address = $ouAddress `n------------`nLinked GPOs Listed Below:`n")
        # Take user OU address and check for inhereted GPOs
        #Get-GPInheritance -Domain $domain -Server $dc -Target $ouAddress
        If($gridview -ne $true) {
            # Just view in terminal
            (Get-GPInheritance -Target $ouAddress).GpoLinks | ForEach-Object {Get-GPO -Name ($_.DisplayName)}
            Pause
        } ElseIf ($gridview -eq $true) {
            # Gridview and Terminal
            (Get-GPInheritance -Target $ouAddress).GpoLinks | ForEach-Object {Get-GPO -Name ($_.DisplayName)}
            $grid = (Get-GPInheritance -Target $ouAddress).GpoLinks | ForEach-Object {Get-GPO -Name ($_.DisplayName)}
            $grid | Out-GridView -Title "GPOs Linked to $ouAddress"
            Pause
        } # End If/ElseIf-----------------------------------
        If ($ouChoice -eq 0) {break}
        
    } while ($ouChoice -ne 0)   
    
} # End Function Get-LinkedGPOs-----------------------------------
    
<#
PS C:\Users\Administrator\Documents\grouppolicyconsolidation\GPOFunctionsModule\GPOprogram> $grid | Out-GridView
PS C:\Users\Administrator\Documents\grouppolicyconsolidation\GPOFunctionsModule\GPOprogram> Get-ADOrganizationalUnit -Properties CanonicalName -Filter * | Sort-Object CanonicalName | Format-Table CanonicalName, DistinguishedName

CanonicalName                                             DistinguishedName
-------------                                             -----------------
WidgetLLC2.Internal/Domain Controllers                    OU=Domain Controllers,DC=WidgetLLC2,DC=Internal
WidgetLLC2.Internal/serveracademy                         OU=serveracademy,DC=WidgetLLC2,DC=Internal
WidgetLLC2.Internal/serveracademy/Domain Computers        OU=Domain Computers,OU=serveracademy,DC=WidgetLLC2,DC=Internal
WidgetLLC2.Internal/serveracademy/Domain Groups           OU=Domain Groups,OU=serveracademy,DC=WidgetLLC2,DC=Internal
WidgetLLC2.Internal/serveracademy/Domain Groups/SubGroups OU=SubGroups,OU=Domain Groups,OU=serveracademy,DC=WidgetLLC2,DC=Internal
WidgetLLC2.Internal/serveracademy/Domain Users            OU=Domain Users,OU=serveracademy,DC=WidgetLLC2,DC=Internal
WidgetLLC2.Internal/serveracademy/Domain Users Extra      OU=Domain Users Extra,OU=serveracademy,DC=WidgetLLC2,DC=Internal
#>

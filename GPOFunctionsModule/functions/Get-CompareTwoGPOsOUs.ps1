#===============================
Function Get-CompareTwoGPOsOUs {
<#
    .SYNOPSIS
    This is a simple function to visually compare the Organizational Unts of 2 GPOs


    .Example
    > Get-CompareTwoGPOsOUs -sourceGPOParam "gpo1A" -destGPOParam "gpo2B"
    # Pick 2 GPOs from list of active GPOs. These are mandatory for a comparison

    .OUTPUTS
    OUs from GPO: gpo1A
    Target                                               DisplayName    Enabled Order GpoId
    ------                                              -----------    ------- ----- -----
    ou=serv1,dc=xTool2,dc=internal                       gpo1A          True    1     fef09f10-a67f...
    ou=domain users,ou=serv1,dc=xTool2,dc=internal       gpo1A          True    1     fef09f10-a67f...
    ou=domain users extra,ou=serv1,dc=xTool2,dc=internal gpo1A          True    1     fef09f10-a67f...


    OUs from GPO: gpo2B
    Target                                              DisplayName      Enabled Order GpoId
    ------                                              -----------      ------- ----- -----
    ou=domain groups,ou=serv1,dc=xTool2,dc=internal      gpo2B           True    3     ddbaa7fb-ef27...
    ou=domain computers,ou=serv1,dc=xTool2,dc=internal   gpo2B           True    7     ddbaa7fb-ef27...


#> 
#===============================
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [String] $sourceGPOParam,
    [Parameter(Mandatory = $true)] 
    [String] $destGPOParam 
) #End Param-------------------------------


    $gpoNamesArray = Get-AllGPOsNames
    $domain = Get-GPOsDomain -writehost $false
    # IF GPOs sent in are not a part of Domain
    If(($sourceGPOParam -notin $gpoNamesArray) -AND ($destGPOParam -notin $gpoNamesArray)) {
        Write-Warning("GPO $sourceGPOParam is not an active GPO in $domain")
        Write-Warning("GPO $destGPOParam is not an active GPO in $domain")
        Pause
        break
    } ElseIf ($sourceGPOParam -notin $gpoNamesArray) {
        Write-Warning("GPO $sourceGPOParam is not an active GPO in $domain")
        Pause
        break
    } ElseIf ($destGPOParam -notin $gpoNamesArray)  {
        Write-Warning("GPO $destGPOParam is not an active GPO in $domain")
        Pause
        break
    } # End IF/ElseIf-------------------------------


    # If report directory does not exist, create one.
    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # $PSScriptRoot only works by executing the script. Selective execution(F8) will not be successful.
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $resultsPath = "$functionPath\GPOdata\OUActiveLinks"
    If(!(Test-Path -Path $resultsPath)) {
        New-Item -ItemType Directory $resultsPath
        New-Item -ItemType File "$resultsPath\README.txt"
        Add-Content -Path "$resultsPath\README.txt" -Value "This directory holds data collected by GPOFunctionsModule, Get-LinkedOUs.ps1 to collect all Organizational Units that are directly linked to Group Policy Objects."
        (Get-ChildItem -Path $resultsPath).Encrypt() #Lock, access only by creator.
    } # End If-------------------------------


    # This is the menu, we want to show OU links for user to choose
    # Gather all OUs with established GPOLinks
    # This backup depends on backups being done already by this program
    $csvPath = "$resultsPath\$sourceGPOParam`VS$destGPOParam.csv"


    (Get-ADOrganizationalUnit -filter * | Get-GPInheritance).GPOLinks | Select-Object -Property Target, DisplayName, Enabled, Order, GpoId | Export-Csv -Path $csvPath
    
    # Only import csv data if line in csv file matches the target GPOs
    $linkedOUs1 = Import-Csv -Path $csvPath | Where-Object{($_.DisplayName -eq $sourceGPOParam)}
    $linkedOUs2 = Import-Csv -Path $csvPath | Where-Object{($_.DisplayName -eq $destGPOParam)}


    # Selective arrays to allow for visual indicators that OU is in both or NOT in the other
    $linkedOUs1Array = @()
    $linkedOUs2Array = @()
    $counter1, $counter2 = 0
 

    # If there is a linked OU from csv import 1, then  add to array 1
    If($null -ne $linkedOUs1) {
        For ($i=0;  $i -le $linkedOUs1.length;  $i++) {
            $linkedOUs1Array += $linkedOUs1[$i].Target
            $counter1 = $i
        } # End ForEach-------------------------------
    # CSV import will not allow a single object to be captured by loop.
    # Grab first object if nothing has been added, and csv import is not null
    # If csv import is null, then no OUs are linked.
    } ElseIf (($linkedOUs1Array.count -eq 0) -AND ($null -eq $linkedOUs1)) {
        $linkedOUs1Array += "None"
    } # End If/ElseIf-------------------------------


    If ($linkedOUs1Array.count -eq 0) {
        $linkedOUs1Array += $linkedOUs1[0].Target # Include the first one regardless.
    } # End If-------------------------------


    # If there is a linked OU from csv import 2, then  add to array 2
    If($null -ne $linkedOUs2) {
        For ($i=0;  $i -le $linkedOUs2.length;  $i++) {
            $linkedOUs2Array += $linkedOUs2[$i].Target
            $counter2 = $i
        } # End ForEach
    # CSV import will not allow a single object to be captured by loop.
    # Grab first object if nothing has been added, and csv import is not null
    # If csv import is null, then no OUs are linked.
    } ElseIf (($linkedOUs2Array.count -eq 0) -AND ($null -eq $linkedOUs2)){
        $linkedOUs2Array += "None"
    } # End If/ElseIf-------------------------------

    
    If ($linkedOUs2Array.count -eq 0) {
        $linkedOUs2Array += $linkedOUs2[0].Target # Include the first one regardless.
    } # End If/ElseIf-------------------------------
    

    # Show OUs linked to target GPOs so user decides to overwrite OUs or add together.
    Write-Host -ForegroundColor Yellow ("`nCompare linked Organizational Units between GPOs, `'$sourceGPOParam`' and `'$destGPOParam`'")
    Write-Host -ForegroundColor Green ("Green")
    Write-Host ("OU is in both GPOs")
    Write-Host -ForegroundColor Red ("Red")
    Write-Host ("OU is only in the target GPO")


    # Show list of linked OUs for source GPO
    Write-Host -ForegroundColor Yellow ("----------------------------`n`nOUs linked to GPO: $sourceGPOParam")
    $linkedOUs1 | Format-Table
    ForEach($ou in $linkedOUs1Array) {
        If ($ou -notin $linkedOUs2Array) {
            Write-Host -ForegroundColor Red ($ou)
        } ElseIf ($ou -in $linkedOUs2Array) {
            Write-Host -ForegroundColor Green ($ou)
        } # End IF/ElseIf-------------------------------
    } # End ForEach-------------------------------


    # Show list of linked OUs for destination GPO
    Write-Host -ForegroundColor Yellow ("----------------------------`n`nOUs linked to GPO: $destGPOParam")
    $linkedOUs2 | Format-Table
    ForEach($ou in $linkedOUs2Array) {
        If ($ou -notin $linkedOUs1Array) {
            Write-Host -ForegroundColor Red ($ou)
        } ElseIf ($ou -in $linkedOUs1Array) {
            Write-Host -ForegroundColor Green ($ou)
        } # End IF/ElseIf-------------------------------
    } # End ForEach-------------------------------
    Write-Host("`n----------------------------------------------")


    (Get-ChildItem -Path $csvPath).Encrypt() #Lock, access only by creator
    Pause



} # End Function Get-CompareTwoGPOsOUs-------------------------------


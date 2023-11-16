Function Get-LinkedOUsAll {
<#
    .SYNOPSIS
    Find all Linked Organizational Units, and list the GPOs linked to them.


    .DESCRIPTION
    Returns only the Organizational Units with GPO Links.


    .EXAMPLE
    Get-LinkedOUsAll
    # Default module results displayed in Gridview


    .EXAMPLE
    Get-LinkedOUsAll -gridview $false
    # Results only displayed on terminal.


    .EXAMPLE
    Get-LinkedOUsAll -gridview $true
    # Results displayed in gridview and on terminal.


    .OUTPUTS
    Target                                            DisplayName                   Order     GpoId
    ------                                            -----------                  -------    ----- -----
    ou=domain computers,ou=sacad,dc=widgetllc2,dc=internal   Install Chrome          3    db66e242-61e6-41d9-bb2e-04f...
    ou=domain computers,ou=sacad,dc=widgetllc2,dc=internal   User Default Wallpaper  4    b85e5983-8fed-4ba1-94e5-465...
    ou=domain computers,ou=sacad,dc=widgetllc2,dc=internal   Secure_computer         5    2c333aef-4b1c-49a3-be0c-44c...

    Target      : ou=domain computers,ou=serveracademy,dc=widgetllc2,dc=internal
    DisplayName : Secure_computer
    Enabled     : True
    Order       : 5
    GpoId       : 2c333aef-4b1c-49a3-be0c-44c0f6bcba7e

#>
#=================
Param(
    [Parameter()]
    [bool]
    $gridview # Defaults to terminal
) # End Param-----------------------------------

    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this scriptam
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $resultsPath = "$functionPath\GPOdata\OUActiveLinks" 
    $timestamp = Get-Date -f 'yyyy-MM-dd-HHmmss'
    $filePath =  "$resultsPath\$timestamp`_LinkedOUs.csv"


    If(!(Test-Path -Path $resultsPath)) {
        New-Item -ItemType Directory $resultsPath
        New-Item -ItemType File "$resultsPath\README.txt"
        Add-Content -Path "$resultsPath\README.txt" -Value "This directory holds data collected by GPOFunctionsModule, Get-LinkedOUs.ps1 to collect all Organizational Units that are directly linked to Group Policy Objects."
        (Get-ChildItem -Path $resultsPath).Encrypt() #Lock, access only by creator.
    } # End If-----------------------------------


    # Gather all OUs with established GPOLinks
    (Get-ADOrganizationalUnit -filter * | Get-GPInheritance).GPOLinks | Select-Object -Property Target, DisplayName, Enabled, Order, GpoId | Export-Csv -Path $filePath
    (Get-ChildItem -Path $filePath).Encrypt()

    
    (Get-Item -Path $filePath).Encrypt()  #Lock, access only by creator.
    $linkedOUs = Import-Csv -Path $filePath
    Write-Output("Linked OU Results:  $filePath")


    # Same collected data but visualized differently.
    If ($gridview -ne $true) {
        $linkedOUs | Format-List
        $linkedOUs | Format-Table
    } ElseIf ($gridview -eq $true) {
        $linkedOUs | Out-GridView -Title "Organizational Units(Target) with sequentially linked GPOs(DisplayName)"
    } # End IF/ElseIf-----------------------------------


    # Let user view results before moving on.
    Pause

   
} #End Function Get-LinkedOUsAll-----------------------------------



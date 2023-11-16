Function Get-LinkedOUsSpecific {
<#
    .SYNOPSIS
    Find Linked Organizational Units, for a specific GPO
    The target gpo, -gpoName Parameter is mandatory. 


    .EXAMPLE
    # OU links for a target GPO displayed in gridview
    #----------------------------------------------------------------------
    > Get-LinkedOUsSpecific  -gridview $true -gpoName "fakeGPOwEverything"
    

    .EXAMPLE
    # OU links for a target GPO displayed in terminal
    #------------------------------------------------------------------------
    > Get-LinkedOUsSpecific  -gridview $false -gpoName "fakeGPOwEverything"


    .OUTPUTS
    Target                                            DisplayName                   Order     GpoId
    ------                                            -----------                  -------    ----- -----
    ou=serveracademy,dc=widgetllc2,dc=internal        fakeGPOwEverything True         1     fef09f10-a67f-40d9...
    ou=domain users,dc=widgetllc2,dc=internal         fakeGPOwEverything True         1     fef09f10-a67f-40d9...
    ou=domain users extra,dc=widgetllc2,dc=internal   fakeGPOwEverything True         1     fef09f10-a67f-40d9.   

    Target      : ou=serveracademy,dc=widgetllc2,dc=internal
    DisplayName : fakeGPOwEverything
    Enabled     : True
    Order       : 1
    GpoId       : fef09f10-a67f-40d9-bc75-ec41a2516e01

-----------------------------------#>
Param(
    [Parameter()]
    [bool]
    $gridview = $true, #Default to gridview
    [Parameter(Mandatory = $true)]
    [string]
    $gpoName
) # End Param-----------------------------------


    # If this GPOFunctionsModule exist, the admin privs must also in that location.
    # Get the path to the GPOFunctionsModule. $PSScriptRoot = Script path
    # This is built to be an imported Windows PowerShell script.
    # The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\functions
    $gl = $PSScriptRoot # Based on assumption above, Gather the location of this script
    $functionPath = $gl.TrimEnd("\functions") # Adjust the address back one level.
    $resultsPath = "$functionPath\GPOdata\OUActiveLinks" 
    $timestamp = Get-Date -f 'yyyy-MM-dd-HHmmss'
    $filePath =  "$resultsPath\$timestamp`_$gpoName`_LinkedOUs.csv"


    If(!(Test-Path -Path $resultsPath)) {
        New-Item -ItemType Directory $resultsPath
        New-Item -ItemType File "$resultsPath\README.txt"
        Add-Content -Path "$resultsPath\README.txt" -Value "This directory holds data collected by GPOFunctionsModule, Get-LinkedOUs.ps1 to collect all Organizational Units that are directly linked to Group Policy Objects."
        (Get-ChildItem -Path $resultsPath).Encrypt() #Lock, access only by creator.
    } # End If-----------------------------------


    # Gather all OUs with established GPOLinks
    (Get-ADOrganizationalUnit -filter * | Get-GPInheritance).GPOLinks | Select-Object -Property Target, DisplayName, Enabled, Order, GpoId | Export-Csv -Path $filePath
    

    # OU links saved to file. Encrypt only for creator.
    (Get-Item -Path $filePath).Encrypt()  #Lock, access only by creator.


    # Only import csv data if line in csv file matches the target GPO
    # BUT This is a selective data gathering, so overwrite the original csv with narrowed data.
    $linkedOUs = Import-Csv -Path $filePath | Where-Object{($_.DisplayName -eq $gpoName)}

    
    # Let user know if there are no linked OUs, or where the results file is 
    If($null -eq $linkedOUs) {
        Write-Warning("NO Organizational Units Linked to $gpoName")
    } Else {
        $linkedOUs | Export-Csv -Path $filePath
        Write-Output("Linked OU Results:  $filePath")
    } # End If/Else-----------------------------------
    


    # Same collected data but visualized differently.
    If ($gridview -eq $false) {
        $linkedOUs | Format-Table
        $linkedOUs | Format-List
    } Else {
        # Add Gridview
        $linkedOUs | Format-Table
        $linkedOUs | Format-List
        $linkedOUs | Out-GridView -Title "Organizational Units(Target) with sequentially linked GPO `'$gpoName`'"
    } # End If/Else-----------------------------------


    # Let user view results before moving on.
    Pause

   
} #End Function Get-LinkedOUsSpecific-----------------------------------



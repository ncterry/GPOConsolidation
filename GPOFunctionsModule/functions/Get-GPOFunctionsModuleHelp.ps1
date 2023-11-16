
#-------------------------------------------------
# Function to show the GPOFunctionsModule help
# This is a sub-function that displays the help/explanations for GPOProgram sections.

function Get-GPOFunctionsModuleHelp {
#=================
Param(
    [Parameter(Mandatory = $true)]
    [string]
    $section
) # End Param-------------------------------
    
    Write-Host -ForegroundColor Yellow ("
|======================================================================|
|==================--- GPOFunctionsModule Help  ---====================|
|======================================================================|`n")
    
    
    If ($section -eq "1.1") {

Write-Host -ForegroundColor Yellow ("
---------
Section 1.1 - Display the associated Domain`n") # END WRITE-HOST

    #---------- These are just visual display seperations
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 1.1

    } ElseIf ($section -eq "1.2") {

Write-Host -ForegroundColor Yellow ("
---------
Section 1.2 - Display the associated Domain Controller`n") # END WRITE-HOST

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 1.2

    } ElseIf ($section -eq "1.3") {

Write-Host -ForegroundColor Yellow ("
---------
Section 1.3 - dcdiag `nDomain Controller Health Check
---------
`'dcdiag`' - Is one of the oldest and most useful tools to figure out 
what's going on in your Active Directory environment. This tool comes 
with Windows, and allows Admins to run various diagnostic checks.

This can be extensive, and may result in a successful test, with 
pseudo-errors if there is encrypted data assocated with the Domain 
such as encrypted GPO backups. These will be registered, and 
acknowledged by this test, but cannot be tested through dcdiag, 
even with Administrator privileges. `n") # END WRITE-HOST-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 1.3

    } ElseIf ($section -eq "1.4") {

Write-Host -ForegroundColor Yellow ("
---------
Section 1.4 - nltest - Domain Controller Health Check
---------
`'nltest`' - A comprehensive trust/communications testing tool for 
a domain, which will display basic information for the Domain and 
Domain Controller. `n") # END WRITE-HOST-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 1.4

    # END GP0 FUNCTIONS MODULE SECTION 1 -------------------------------
    #----------
    } ElseIf ($section -eq "2.1") {  # START GP0 FUNCTIONS MODULE SECTION 2
    #----------
    
# Help/Description function for 2_GPOsInfoMenu, section 1
Write-Host -ForegroundColor Yellow ("
---------
Section 2.1 - Gather and display all local GPOs in alphabetical order.")

Write-Host ("
Example (Not your Domain):
Domain: WidgetLLC2.Internal : List of Current GPO Display Names:
------------

    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox
    11) xPreferenceCreateFolder
    12) xPreferenceShareFile
    13) TestGPO1LinkedToOU
    14) TestGPO2LinkedToOU
    15) TestGPO3LinkedToOU
    16) User Default Wallpaper
`n") # END WRITE-HOST-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 2.1

    } ElseIf ($section -eq "2.2") {
        
# Help/Description function for 2_GPOsInfoMenu, section 2
Write-Host -ForegroundColor Yellow ("
---------
Section 2.2 - Gather information about all local GPOs In the TERMINAL.
This information is summary information about all GPOs. For specific,
in-depth information about a target GPO, use option 2.4 - `"View Single 
GPO Full Configuration`"`n`n")

Write-Host("Example: (Fake Domain)
GPO: xTestGPO1LinkedToOU
{Value=
{
    > Id=72b75000-6eaf-4ed6-ac4f-f58c376a575f
    > Path=cn={72B75000-6EAF-4ED6-AC4F-F58C376A575F},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal
    > DisplayName=xTestGPO1LinkedToOU
    > GpoStatus=AllSettingsEnabled
    > WmiFilter=
    > CreationTime=7/20/2021 10:30:52 AM
    > ModificationTime=7/26/2021 11:47:56 AM
    > User=Microsoft.GroupPolicy.UserConfiguration
    > Computer=xLink2011
`n}`n") # END Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 2.2

    } ElseIf ($section -eq "2.3") {
    
Write-Host -ForegroundColor Yellow ("
---------
Section 2.3 - Gather information about all local GPOs In the GRIDVIEW.
This information is summary information about all GPOs. For specific,
in-depth information about a target GPO, use option 2.4 - `"View Single 
GPO Full Configuration`"`n`n")

Write-Host("Example: (Fake Domain)
GPO: xTestGPO1LinkedToOU
{Value=
{
    > Id=72b75000-6eaf-4ed6-ac4f-f58c376a575f
    > Path=cn={72B75000-6EAF-4ED6-AC4F-F58C376A575F},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal
    > DisplayName=xTestGPO1LinkedToOU
    > GpoStatus=AllSettingsEnabled
    > WmiFilter=
    > CreationTime=7/20/2021 10:30:52 AM
    > ModificationTime=7/26/2021 11:47:56 AM
    > User=Microsoft.GroupPolicy.UserConfiguration
    > Computer=xLink2011
`n}`n") # END Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 2.3

    } ElseIf ($section -eq "2.4") {

# Help/Description function for 2_GPOsInfoMenu, section 4
Write-Host -ForegroundColor Yellow ("
---------
Section 2.4 - The most detailed collection of data related to the entire 
GPO that is being targeted.
----------
----------
----------") # END Write-Host-------------------------------
Write-Host -ForegroundColor Yellow ("
1) The program gathers and displays all local GPOs in alphabetical order. ")
Write-Host ("
    1) gpo1A 
    2) gpo2B 
    3) gpo3xyz 

----------") # END Write-Host-------------------------------
Write-Host -ForegroundColor Yellow ("
2) The user selects their target GPO that they want to view. ")
Write-Host ("
    > 1 
    
----------") # END Write-Host-------------------------------
Write-Host -ForegroundColor Yellow ("
3) The user confirms that target GPO. ")
Write-Host ("
    Chosen GPO name:  'gpo1A' 
    Is this existing GPO correct? 
    (y/n): y 
    
----------") # END Write-Host-------------------------------
Write-Host -ForegroundColor Yellow ("
4) The program then cycles through the system to gather all information 
about the target GPO such as: Polices, Preferences, and Organizational Units. 

----------") # END Write-Host-------------------------------
Write-Host -ForegroundColor Yellow ("
5) The program saves all of this information in the GPOFunctionsModule, 
which by default is located here:

    'C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\`' 
    
----------") # END Write-Host-------------------------------
Write-Host -ForegroundColor Yellow ("
6) The program saves this collected data on the GPO in two formats, 
as an HTML report and an XML report.
----------") # END Write-Host
Write-Host -ForegroundColor Yellow ("
7) The program then automatically opens the HTML report for the target 
GPO for the user to view.


This HTML is by default, opened through Internet Explorer, but can easily be viewed
through any browser, as an aesthetically pleasing, full documentation of all 
aspects, and information related to this GPO.`n`n`n") # END Write-Host
}# End If/ElseIf-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 2.4

    If ($section -eq "3.1") {

# Help/Description function for 3_OU_GPOLinksMenu, section 1
Write-Host -ForegroundColor Yellow ("
Section 3.1 - View Organizational Units with sequentially Linked GPOs 
Display results in the TERMINAL.")


Write-Host ("
    Target      : ou=domain users, ou=serveracademy, dc=widgetllc2,dc=internal
    DisplayName : CheckGPOAdd
    Enabled     : True
    Order       : 1
    GpoId       : 7f5b0943-fc1b-431e-9c54-a49c683308ba
") #End Write-Host-------------------------------


Write-Host ("
    Target      : ou=domain users, ou=serveracademy, dc=widgetllc2,dc=internal
    DisplayName : fakeGPOwEverything
    Enabled     : True
    Order       : 2
    GpoId       : 75fc93c3-a10e-4c94-8ce9-be745c88ece1
") #End Write-Host-------------------------------


Write-Host ("
    Target      : ou=domain users, ou=serveracademy, dc=widgetllc2,dc=internal
    DisplayName : xInstall 7zip
    Enabled     : True
    Order       : 3
    GpoId       : 9131d9e3-7123-4246-bcc2-05392168e1fa
") #End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 3.1

    } ElseIf ($section -eq "3.2") {

# Help/Description function for 3_OU_GPOLinksMenu, section 2
Write-Host -ForegroundColor Yellow ("
Section 3.2 - View Organizational Units with sequentially Linked GPOs 
Display results in the GRIDVIEW.")


Write-Host ("
    Target      : ou=domain users, ou=serveracademy, dc=widgetllc2,dc=internal
    DisplayName : CheckGPOAdd
    Enabled     : True
    Order       : 1
    GpoId       : 7f5b0943-fc1b-431e-9c54-a49c683308ba
") #End Write-Host-------------------------------


Write-Host ("
    Target      : ou=domain users, ou=serveracademy, dc=widgetllc2,dc=internal
    DisplayName : fakeGPOwEverything
    Enabled     : True
    Order       : 2
    GpoId       : 75fc93c3-a10e-4c94-8ce9-be745c88ece1
") #End Write-Host-------------------------------


Write-Host ("
    Target      : ou=domain users, ou=serveracademy, dc=widgetllc2,dc=internal
    DisplayName : xInstall 7zip
    Enabled     : True
    Order       : 3
    GpoId       : 9131d9e3-7123-4246-bcc2-05392168e1fa
") #End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 3.2

    } ElseIf ($section -eq "3.3") {
    
# Help/Description function for 3_OU_GPOLinksMenu, section 3
Write-Host -ForegroundColor Yellow ("
Section 3.3 - Organizational Unit links for a target GPO displayed in TERMINAL")
Write-Host -ForegroundColor Yellow ("
User chooses and confirms the number associated with the target GPO")
Write-Host("
User Selects a GPO Name:")
Write-Host("
EXAMPLE:`nWidgetLLC2.Internal : List of Current GPO Display Names:
    ----------------
    
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox
        
        ---
    Enter: 0 to Return to Prior Menu
    Pick Which existing GPO to view linked OUs
    Number 1 - 10:  5


    Chosen GPO name:  'fakeGPOwEverything'
    Is this existing GPO correct?
    (y/n): y
") # END WRITE-HOST-------------------------------


Write-Host -ForegroundColor Yellow ("
Corresponding GPO results are displayed, showing all asociated Organizational 
Units that are linked to this GPO.")
    

Write-Host ("
Linked OU Results:  
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\OUActiveLinks\
2021-07-27-114537_fakeGPOwEverything_LinkedOUs.csv


Target                                                           DisplayName      
------                                                           -----------        
ou=serveracademy,dc=widgetllc2,dc=internal                       fakeGPOwEverything
ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal       fakeGPOwEverything 
ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal fakeGPOwEverything 



    Target      : ou=serveracademy,dc=widgetllc2,dc=internal
    DisplayName : fakeGPOwEverything
    Enabled     : True
    Order       : 3
    GpoId       : 75fc93c3-a10e-4c94-8ce9-be745c88ece1

    Target      : ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal
    DisplayName : fakeGPOwEverything
    Enabled     : True
    Order       : 3
    GpoId       : 75fc93c3-a10e-4c94-8ce9-be745c88ece1

    Target      : ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal
    DisplayName : fakeGPOwEverything
    Enabled     : True
    Order       : 3
    GpoId       : 75fc93c3-a10e-4c94-8ce9-be745c88ece1
")# END WRITE-HOST-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 3.3

    } ElseIf ($section -eq "3.4") {

# Help/Description function for 3_OU_GPOLinksMenu, section 4
Write-Host -ForegroundColor Yellow ("
Section 3.4 - Organizational Unit links for a target GPO displayed in GRIDVIEW")
Write-Host -ForegroundColor Yellow ("
User chooses and confirms the number associated with the target GPO")
Write-Host("
User Selects a GPO Name:")
Write-Host("
EXAMPLE:`nWidgetLLC2.Internal : List of Current GPO Display Names:
----------------
    
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox
    11) xPreferenceCreateFolder
    12) xPreferenceShareFile
    13) TestGPO1LinkedToOU
    14) TestGPO2LinkedToOU
    15) TestGPO3LinkedToOU
    16) User Default Wallpaper
        
        ---
    Enter: 0 to Return to Prior Menu
    Pick Which existing GPO to view linked OUs
    Number 1 - 16:  5


    Chosen GPO name:  'fakeGPOwEverything'
    Is this existing GPO correct?
    (y/n): y
") # END WRITE-HOST-------------------------------


Write-Host -ForegroundColor Yellow ("
Corresponding GPO results are displayed, showing all asociated 
Organizational Units that are linked to this GPO.")
        
Write-Host ("
Linked OU Results:  
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\OUActiveLinks\
2021-07-27-114537_fakeGPOwEverything_LinkedOUs.csv

Target                                                           DisplayName      
------                                                           -----------       
ou=serveracademy,dc=widgetllc2,dc=internal                       fakeGPOwEverything 
ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal       fakeGPOwEverything 
ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal fakeGPOwEverything 



    Target      : ou=serveracademy,dc=widgetllc2,dc=internal
    DisplayName : fakeGPOwEverything
    Enabled     : True
    Order       : 3
    GpoId       : 75fc93c3-a10e-4c94-8ce9-be745c88ece1


    Target      : ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal
    DisplayName : fakeGPOwEverything
    Enabled     : True
    Order       : 3
    GpoId       : 75fc93c3-a10e-4c94-8ce9-be745c88ece1


    Target      : ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal
    DisplayName : fakeGPOwEverything
    Enabled     : True
    Order       : 3
    GpoId       : 75fc93c3-a10e-4c94-8ce9-be745c88ece1
")# END WRITE-HOST-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 3.4

    } ElseIf ($section -eq "3.5") {

# Help/Description function for 3_OU_GPOLinksMenu, section 5
Write-Host -ForegroundColor Yellow ("
Section 3.5 - Display all local Group Policy Objects with summary information. 
INCLUDING if the GPO currently has an active link to any Organizational Unit. 
These GPO results are displayed in the TERMINAL. 

Example: (Fake Domain)")


Write-Host ("
whenCreated       : 7/26/2021 11:46:54 AM
whenChanged       : 7/26/2021 11:46:54 AM
Linked            : {}
DisplayName       : fakeGPOwEverything
Name              : {75FC93C3-A10E-4C94-8CE9-BE745C00215A}
DistinguishedName : CN={5D3698ED-2739-4FE4-8FB4-6AB6BF00215A},CN=Policies,CN=System,DC=WidgetLLC2,DC=Internal


whenCreated       : 7/20/2021 10:30:54 AM
whenChanged       : 7/26/2021 11:48:02 AM
Linked            : {True}
DisplayName       : xUser Default Wallpaper
Name              : {C6552FA5-88CC-4AC8-8D22-AC6F5216C3DD}
DistinguishedName : CN={C6552FA5-88CC-4AC8-8D22-AC6F5216C3DD},CN=Policies,CN=System,DC=WidgetLLC2,DC=Internal


whenCreated       : 7/26/2021 11:47:33 AM
whenChanged       : 7/26/2021 11:47:36 AM
Linked            : {}
DisplayName       : xInstall 7zip
Name              : {9131D9E3-7123-4246-BCC2-05392168E1FA}
DistinguishedName : CN={9131D9E3-7123-4246-BCC2-05392168E1FA},CN=Policies,CN=System,DC=WidgetLLC2,DC=Internal


henCreated       : 5/14/2021 2:42:11 PM
whenChanged       : 7/26/2021 11:45:38 AM
Linked            : {True}
DisplayName       : Default Domain Controllers Policy
Name              : {6AC1786C-016F-11D2-945F-00C04fB984F9}
DistinguishedName : CN={6AC1786C-016F-11D2-945F-00C04fB984F9},CN=Policies,CN=System,DC=WidgetLLC2,DC=Internal



Linked    DisplayName                       Name
------    -----           -----------           ------ -----------                   
{}        fakeGPOwEverything                {75FC93C3-A10E-4C94-8CE9-BE745C...
{True}    xUser Default Wallpaper           {C6552FA5-88CC-4AC8-8D22-AC6F52...
{}        xInstall 7zip                     {9131D9E3-7123-4246-BCC2-053921...
{True}    Default Domain Controllers Policy {6AC1786C-016F-11D2-945F-00C04f...
") # END WRITE-HOST-------------------------------
    
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 3.5

    } ElseIf ($section -eq "3.6") {

# Help/Description function for 3_OU_GPOLinksMenu, section 6
Write-Host -ForegroundColor Yellow ("
Section 3.6 - Display all local Group Policy Objects with summary information. 
INCLUDING if the GPO currently has an active link to any Organizational Unit. 
These GPO results are displayed in the GRIDVIEW. 


Example: (Fake Domain)")

Write-Host ("
whenCreated       : 7/26/2021 11:46:54 AM
whenChanged       : 7/26/2021 11:46:54 AM
Linked            : {}
DisplayName       : fakeGPOwEverything
Name              : {75FC93C3-A10E-4C94-8CE9-BE745C00215A}
DistinguishedName : CN={5D3698ED-2739-4FE4-8FB4-6AB6BF00215A},CN=Policies,CN=System,DC=WidgetLLC2,DC=Internal


whenCreated       : 7/20/2021 10:30:54 AM
whenChanged       : 7/26/2021 11:48:02 AM
Linked            : {True}
DisplayName       : xUser Default Wallpaper
Name              : {C6552FA5-88CC-4AC8-8D22-AC6F5216C3DD}
DistinguishedName : CN={C6552FA5-88CC-4AC8-8D22-AC6F5216C3DD},CN=Policies,CN=System,DC=WidgetLLC2,DC=Internal


whenCreated       : 7/26/2021 11:47:33 AM
whenChanged       : 7/26/2021 11:47:36 AM
Linked            : {}
DisplayName       : xInstall 7zip
Name              : {9131D9E3-7123-4246-BCC2-05392168E1FA}
DistinguishedName : CN={9131D9E3-7123-4246-BCC2-05392168E1FA},CN=Policies,CN=System,DC=WidgetLLC2,DC=Internal


whenCreated       : 5/14/2021 2:42:11 PM
whenChanged       : 7/26/2021 11:45:38 AM
Linked            : {True}
DisplayName       : Default Domain Controllers Policy
Name              : {6AC1786C-016F-11D2-945F-00C04fB984F9}
DistinguishedName : CN={6AC1786C-016F-11D2-945F-00C04fB984F9},CN=Policies,CN=System,DC=WidgetLLC2,DC=Internal



Linked    DisplayName                       Name
------    -----           -----------           ------ -----------                   
{}        fakeGPOwEverything                {75FC93C3-A10E-4C94-8CE9-BE745C...
{True}    xUser Default Wallpaper           {C6552FA5-88CC-4AC8-8D22-AC6F52...
{}        xInstall 7zip                     {9131D9E3-7123-4246-BCC2-053921...
{True}    Default Domain Controllers Policy {6AC1786C-016F-11D2-945F-00C04f...
") # END WRITE-HOST-------------------------------
    
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 3.6

    } ElseIf ($section -eq "3.7") {

# Help/Description function for 3_OU_GPOLinksMenu, section 7
Write-Host -ForegroundColor Yellow ("
Section 3.7 - A user enters a local Organizational Unit address manually, 
or selects an OU listed from the primary gathered OU addresses. 
All GPOs that are linked to that OU address will be displayed, 
along with basic information.`n")
Pause # Let user read summary, then display the example.

Write-Host -ForegroundColor Yellow ("
All gathered information will be displayed in the TERMINAL.")


Write-Host ("
------------------------------
Primary Organizational Units in this domain:

    1) OU=Domain Controllers,DC=WidgetLLC2,DC=Internal
    2) OU=serveracademy,DC=WidgetLLC2,DC=Internal
    3) OU=Domain Groups,OU=serveracademy,DC=WidgetLLC2,DC=Internal
    4) OU=SubGroups,OU=Domain Groups,OU=serveracademy,DC=WidgetLLC2,DC=Internal
    5) OU=Domain Users,OU=serveracademy,DC=WidgetLLC2,DC=Internal
    6) OU=Domain Computers,OU=serveracademy,DC=WidgetLLC2,DC=Internal
    7) OU=Domain Users Extra,OU=serveracademy,DC=WidgetLLC2,DC=Internal

Enter  0  to Return to Menu, or...
Enter the target OU DistinguishedName.
Example:
        OU=Domain Computers,OU=serveracademy,DC=WidgetLLC2,DC=Internal

Or, enter the number next to the primary OUs listed: 1
------------------------------

------------------------------
OU Address = OU=Domain Controllers,DC=WidgetLLC2,DC=Internal
------------
Linked GPOs Listed Below:
------------
DisplayName      : Default Domain Controllers Policy
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 6ac1786c-016f-11d2-945f-00c04fb984f9
GpoStatus        : AllSettingsEnabled
Description      :
CreationTime     : 5/14/2021 2:42:11 PM
ModificationTime : 7/26/2021 11:45:38 AM
UserVersion      : AD Version: 21, SysVol Version: 21
ComputerVersion  : AD Version: 22, SysVol Version: 22
WmiFilter        :


DisplayName      : fakeGPOwEverything
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 75fc93c3-a10e-4c94-8ce9-be745c88ece1
GpoStatus        : AllSettingsEnabled
Description      : Settings Imported from GPO SSXgpo Backups.        
CreationTime     : 7/26/2021 11:47:26 AM
ModificationTime : 7/26/2021 11:47:28 AM
UserVersion      : AD Version: 1, SysVol Version: 1
ComputerVersion  : AD Version: 1, SysVol Version: 1
WmiFilter        :


DisplayName      : xInstall 7zip
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 9131d9e3-7123-4246-bcc2-05392168e1fa
GpoStatus        : AllSettingsEnabled
Description      : Created by:  Get-ImportGPOSettings.ps1; Settings Imported from: fakeGPOwEverything
CreationTime     : 7/26/2021 11:47:33 AM
ModificationTime : 7/26/2021 11:47:36 AM
UserVersion      : AD Version: 1, SysVol Version: 1
ComputerVersion  : AD Version: 1, SysVol Version: 1
WmiFilter        :
") # END WRITE-HOST-------------------------------
    
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 3.7

    } ElseIf ($section -eq "3.8") { 
        
# Help/Description function for 3_OU_GPOLinksMenu, section 8
Write-Host -ForegroundColor Yellow ("
Section 3.8 - A user enters a local Organizational Unit address manually, 
or selects an OU listed from the primary gathered OU addresses. 
All GPOs that are linked to that OU address will be displayed, along 
with basic information.`n")
Write-Host -ForegroundColor Yellow ("All gathered information will be displayed in the GRIDVIEW.")
Pause # Let user read summary, then display the example.

Write-Host ("
------------------------------
Primary Organizational Units in this domain:

    1) OU=Domain Controllers,DC=WidgetLLC2,DC=Internal
    2) OU=serveracademy,DC=WidgetLLC2,DC=Internal
    3) OU=Domain Groups,OU=serveracademy,DC=WidgetLLC2,DC=Internal
    4) OU=SubGroups,OU=Domain Groups,OU=serveracademy,DC=WidgetLLC2,DC=Internal
    5) OU=Domain Users,OU=serveracademy,DC=WidgetLLC2,DC=Internal
    6) OU=Domain Computers,OU=serveracademy,DC=WidgetLLC2,DC=Internal
    7) OU=Domain Users Extra,OU=serveracademy,DC=WidgetLLC2,DC=Internal

Enter  0  to Return to Menu, or...
Enter the target OU DistinguishedName.
Example:
        OU=Domain Computers,OU=serveracademy,DC=WidgetLLC2,DC=Internal

Or, enter the number next to the primary OUs listed: 1
------------------------------

------------------------------
OU Address = OU=Domain Controllers,DC=WidgetLLC2,DC=Internal
------------
Linked GPOs Listed Below:
------------
DisplayName      : Default Domain Controllers Policy
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 6ac1786c-016f-11d2-945f-00c04fb984f9
GpoStatus        : AllSettingsEnabled
Description      :
CreationTime     : 5/14/2021 2:42:11 PM
ModificationTime : 7/26/2021 11:45:38 AM
UserVersion      : AD Version: 21, SysVol Version: 21
ComputerVersion  : AD Version: 22, SysVol Version: 22
WmiFilter        :


DisplayName      : fakeGPOwEverything
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 75fc93c3-a10e-4c94-8ce9-be745c88ece1
GpoStatus        : AllSettingsEnabled
Description      : Settings Imported from GPO SSXgpo Backups.           
CreationTime     : 7/26/2021 11:47:26 AM
ModificationTime : 7/26/2021 11:47:28 AM
UserVersion      : AD Version: 1, SysVol Version: 1
ComputerVersion  : AD Version: 1, SysVol Version: 1
WmiFilter        :


DisplayName      : xInstall 7zip
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 9131d9e3-7123-4246-bcc2-05392168e1fa
GpoStatus        : AllSettingsEnabled
Description      : Created by:  Get-ImportGPOSettings.ps1; Settings Imported from: fakeGPOwEverything
CreationTime     : 7/26/2021 11:47:33 AM
ModificationTime : 7/26/2021 11:47:36 AM
UserVersion      : AD Version: 1, SysVol Version: 1
ComputerVersion  : AD Version: 1, SysVol Version: 1
WmiFilter        :
") # END WRITE-HOST-------------------------------
    
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 3.8

    } ElseIf ($section -eq "3.9") { 
        
# Help/Description function for 3_OU_GPOLinksMenu, section 9
Write-Host -ForegroundColor Yellow ("
Section 3.9 - This is to compare the linked Organizational Units between 
two Group Policy Objects that are selected by the user. This will then 
display all linked OUs for both GPOs and indicate if the OUs are linked 
to both-GPOs(green text) or only linked to one-GPO(red text)
Pause # Let user read summary, then display the example.

This is only displayed in TERMINAL")

Write-Host ("
EXAMPLE:
WidgetLLC2.Internal : List of Current GPO Display Names:
----------------

    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox
    11) xPreferenceCreateFolder
    12) xPreferenceShareFile
    13) TestGPO1LinkedToOU
    14) TestGPO2LinkedToOU
    15) TestGPO3LinkedToOU
    16) User Default Wallpaper

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to view linked OUs (GPO1)
Number 1 - 16: 5


Chosen GPO name:  'fakeGPOwEverything'
Is this existing GPO correct?
(y/n): y

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to view linked OUs (GPO2)
Number 1 - 16: 8


Chosen GPO name:  'Install 7zip'
Is this existing GPO correct?
(y/n): y
") # END WRITE-HOST-------------------------------


Write-Host ("Compare linked Organizational Units between GPOs, 'fakeGPOwEverything' and 'xInstall 7zip'")
Write-Host -ForegroundColor Green ("Green")
Write-Host ("OU is in both GPOs")
Write-Host -ForegroundColor Red ("Red")
Write-Host ("OU is only in the target GPO")
Write-Host ("----------------------------")
Write-Host ("OUs linked to GPO: fakeGPOwEverything")
Write-Host ("Target                                                           DisplayName        ...")
Write-Host ("------                                                           -----------        ...")
Write-Host ("ou=serveracademy,dc=widgetllc2,dc=internal                       fakeGPOwEverything ...")
Write-Host ("ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal       fakeGPOwEverything ...")
Write-Host ("ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal fakeGPOwEverything ...")
Write-Host -ForegroundColor Green ("ou=serveracademy,dc=widgetllc2,dc=internal")
Write-Host -ForegroundColor Green ("ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal")
Write-Host -ForegroundColor Green ("ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal")
Write-Host ("----------------------------")
Write-Host ("OUs linked to GPO: xInstall 7zip")
Write-Host ("Target                                                           DisplayName   ...")
Write-Host ("------                                                           -----------   ...")
Write-Host ("ou=serveracademy,dc=widgetllc2,dc=internal                       xInstall 7zip ...")
Write-Host ("ou=domain groups,ou=serveracademy,dc=widgetllc2,dc=internal      xInstall 7zip ...")
Write-Host ("ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal       xInstall 7zip ...")
Write-Host ("ou=domain computers,ou=serveracademy,dc=widgetllc2,dc=internal   xInstall 7zip ...")
Write-Host ("ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal xInstall 7zip ...")
Write-Host -ForegroundColor Green ("ou=serveracademy,dc=widgetllc2,dc=internal")
Write-Host -ForegroundColor Red ("ou=domain groups,ou=serveracademy,dc=widgetllc2,dc=internal")
Write-Host -ForegroundColor Green ("ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal")
Write-Host -ForegroundColor Red ("ou=domain computers,ou=serveracademy,dc=widgetllc2,dc=internal")
Write-Host -ForegroundColor Green ("ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal")
Write-Host ("-----------------------")
Write-Host ("-----------------------")
Write-Host ("-----------------------")
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 3.9

    } ElseIf ($section -eq "4.1") {
Write-Host -ForegroundColor Yellow ("
Section 4.1 - View Full Registry for a Target GPO 
The program will collect all local GPOs, then allow the user to choose 
which GPO to gather all local registry values from. These registry results 
will be viewed in the TERMINAL")
Pause # Let user read summary, then display the example.

Write-Host("
EXAMPLE:`nWidgetLLC2.Internal : List of Current GPO Display Names:
----------------

    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to view Registry Values
Number 1 - 10: 2


Chosen GPO name:  'Default Domain Policy'
Is this existing GPO correct?
(y/n): y


Records Saved To:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPORegistryValues\
Default Domain Policy\2021-07-28-091258_registryRecords.txt


Hive        : LocalMachine
PolicyState : Set
Value       : {1, 0, 1, 0...}
Type        : Binary
ValueName   : EFSBlob
HasValue    : True
KeyPath     : Software\Policies\Microsoft\SystemCertificates\EFS
FullKeyPath : HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates\EFS


Hive        : LocalMachine
PolicyState : Set
Value       : {2, 0, 0, 0...}
Type        : Binary
ValueName   : Blob
HasValue    : True
KeyPath     : Software\Policies\Microsoft\SystemCertificates\EFS\Certificates\8C2BC2B...
FullKeyPath : HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates\EFS\Certificates\8C2BC2...
") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 4.1

    } ElseIf ($section -eq "4.2") {

Write-Host -ForegroundColor Yellow ("
Section 4.2 - View Full Registry for a Target GPO 
The program will collect all local GPOs. Then allow the user to choose 
which GPO to gather all local registry values from. These registry 
results will be viewed in the GRIDVIEW")
Pause # Let user read summary, then display the example.


Write-Host("
EXAMPLE:`nWidgetLLC2.Internal : List of Current GPO Display Names:
----------------

    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to view Registry Values
Number 1 - 10: 2


Chosen GPO name:  'Default Domain Policy'
Is this existing GPO correct?
(y/n): y


Records Saved To:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPORegistryValues\
Default Domain Policy\2021-07-28-091258_registryRecords.txt


Hive        : LocalMachine
PolicyState : Set
Value       : {1, 0, 1, 0...}
Type        : Binary
ValueName   : EFSBlob
HasValue    : True
KeyPath     : Software\Policies\Microsoft\SystemCertificates\EFS
FullKeyPath : HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates\EFS


Hive        : LocalMachine
PolicyState : Set
Value       : {2, 0, 0, 0...}
Type        : Binary
ValueName   : Blob
HasValue    : True
KeyPath     : Software\Policies\Microsoft\SystemCertificates\EFS\Certificates\8C2BC2B...
FullKeyPath : HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates\EFS\Certificates\8C2BC2...
") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 4.2

    } ElseIf ($section -eq "4.3") {

Write-Host -ForegroundColor Yellow ("Section 4.3 - View a single Registry set for target GPO, and target registry address.")
Pause # Let user read summary, then display the example.
Write-Host("EXAMPLE:`nWidgetLLC2.Internal : List of Current GPO Display Names:
----------------

    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to view it's Registry Values
Number 1 - 10: 2


Chosen GPO name:  'Default Domain Policy'
Is this existing GPO correct?
(y/n): y


Verified GPO selected:   Default Domain Policy
Common, base registry paths below:
------------------
    1) HKLM\System
    2) HKLM\Software
    3) HKLM\Hardware
    4) HKLM\SAM
    5) HKLM\Security
    6) HKCU\Software
    7) HKCU\System
    8) HKCU\AppEvents
    9) HKCU\Console
    10) HKCU\Control Panel
    11) HKCU\Environment
    12) HKCU\Network

---------
(Enter  0 to return to previous menu, or...)

Pick a primary path number, or...
Enter a target path to check\gather Registry Values from.
Examples:
        HKCU\Software
        HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System
: 2


Records Saved To:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPORegistryValues\
Default Domain Policy\2021-07-28-110027_registryRecords.txt


Hive        : LocalMachine
PolicyState : Set
Value       : {1, 0, 1, 0...}
Type        : Binary
ValueName   : EFSBlob
HasValue    : True
KeyPath     : Software\Policies\Microsoft\SystemCertificates\EFS
FullKeyPath : HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates\EFS


Hive        : LocalMachine
PolicyState : Set
Value       : {2, 0, 0, 0...}
Type        : Binary
ValueName   : Blob
HasValue    : True
KeyPath     : Software\Policies\Microsoft\SystemCertificates\EFS\Certificates\8C2BC2...
FullKeyPath : HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates\EFS\Certificates\8C2BC2...
") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 4.3

    } ElseIf ($section -eq "5.1") {

Write-Host -ForegroundColor Yellow ("
Section 5.1 - Create a New Blank GPO. 
There will be no settings established here for the new GPO")
Pause # Let user read summary, then display the example.


Write-Host("
EXAMPLE:
WidgetLLC2.Internal : List of Current GPO Display Names:
----------------

    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

-------------
Enter  0 to return to Menu
Enter the name of the new GPO.
Repeat names are not accepted: newTESTGPO
Is this name correct:   newTESTGPO
(y/n): y


Enter a descriptor comment for newTESTGPO: test test test comment


DisplayName      : newTESTGPO
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 6782ebd7-3163-470b-a579-37af54658a98
GpoStatus        : AllSettingsEnabled
Description      : test test test comment
CreationTime     : 7/28/2021 9:37:35 AM
ModificationTime : 7/28/2021 9:37:35 AM
UserVersion      : AD Version: 0, SysVol Version: 0
ComputerVersion  : AD Version: 0, SysVol Version: 0
WmiFilter        :
PSPath            : Microsoft.PowerShell.Core\FileSystem::C:\Program
                    Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\newTESTGPO
PSChildName       : newTESTGPO
PSDrive           : C
PSProvider        : Microsoft.PowerShell.Core\FileSystem
PSIsContainer     : True
Name              : newTESTGPO
FullName          : 
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\newTESTGPO

Parent            : GPOSettingsReports
Exists            : True
Root              : C:\
Extension         :
CreationTime      : 7/28/2021 9:37:35 AM
CreationTimeUtc   : 7/28/2021 1:37:35 PM
LastAccessTime    : 7/28/2021 9:37:35 AM
LastAccessTimeUtc : 7/28/2021 1:37:35 PM
LastWriteTime     : 7/28/2021 9:37:35 AM
LastWriteTimeUtc  : 7/28/2021 1:37:35 PM
Attributes        : Directory
Mode              : d-----
BaseName          : newTESTGPO
Target            : {}
LinkType          :


WARNING:
GPO:     'newTESTGPO'
Settings Results Saved to:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\newTESTGPO
") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 5.1

    } ElseIf ($section -eq "5.2") {

Write-Host -ForegroundColor Yellow ("
Section 5.2 - Create a New GPO, from a Backup. 

Similar to making a copy of an existing GPO, if there were GPO backups 
made that contain prior settings, these can be copied into a new GPO. 
These GPO backups can still be imported into a new GPO if the primary 
GPO that the backup was made from was deleted, and does not currently 
exist in the domain.`n")


Pause # Let user read summary, then display the example.
Write-Host("GPO Backup Directory:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups
Names of GPO Backups:
---
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox
-------------

---
Enter: 0  To Return to Prior Menu
Pick Which Existing GPO Backup to Import From: 1 - 10
: 5


Chosen GPO Backup name:  fakeGPOwEverything
Is the Backup GPO correct? (y/n) : y


GPO:   fakeGPOwEverything
List of Backups, Newest down to Oldest:
---
1) 2021-07-27-142517
2) 2021-07-26-134449
3) 2021-07-26-134212
4) 2021-07-26-133519

The most recent backup is:  2021-07-27-142517

---
Enter: 0  To Return to Prior Menu
Pick Which Existing GPO Backup to Import From: Number 1 - 4: 2


Chosen GPO Backup for:  fakeGPOwEverything
Is the Backup  2021-07-26-134449  correct? (y/n) : y


    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox
-------------

WARNING:
New GPO name must be different than all existing GPO names.
Importing From:
GPO:      fakeGPOwEverything
Backup:   2021-07-26-134449


Enter  0  To Return to Previous Menu
Enter a new GPO name: testGPOX


Is this name correct:   testGPOX
(y/n): y


Enter a descriptor comment for testGPOX : test test test comment
-------------
    
DisplayName      : testGPOX
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 8487e30d-c3c7-4f18-be5c-715288125801
GpoStatus        : AllSettingsEnabled
Description      : 
Created by:  Set-CreateGPOFrmBackup.ps1; Settings Imported from: fakeGPOwEverything,
2021-07-26-134449 --- User Comment: test test test comment

CreationTime     : 7/28/2021 9:45:42 AM
ModificationTime : 7/28/2021 9:45:42 AM
UserVersion      : AD Version: 0, SysVol Version: 0
ComputerVersion  : AD Version: 0, SysVol Version: 0
WmiFilter        :


DisplayName      : testGPOX
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 8487e30d-c3c7-4f18-be5c-715288125801
GpoStatus        : AllSettingsEnabled
Description      : Created by:  Get-ImportAllGPOBackups.ps1; Settings Imported from previous GPO Backups.
CreationTime     : 7/28/2021 9:45:42 AM
ModificationTime : 7/28/2021 9:45:45 AM
UserVersion      : AD Version: 1, SysVol Version: 1
ComputerVersion  : AD Version: 1, SysVol Version: 1
WmiFilter        :


OU Links Imported from fakeGPOwEverything
------------------------------------------
DisplayName   : testGPOX
GpoId         : 8487e30d-c3c7-4f18-be5c-715288125801
Enabled       : True
Enforced      : False
Order         : 8
Target        : OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : testGPOX
GpoId         : 8487e30d-c3c7-4f18-be5c-715288125801
Enabled       : True
Enforced      : False
Order         : 8
Target        : OU=Domain Users,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : testGPOX
GpoId         : 8487e30d-c3c7-4f18-be5c-715288125801
Enabled       : True
Enforced      : False
Order         : 5
Target        : OU=Domain Users Extra,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal



    NOTE - You may need to RE-OPEN Group Policy Management to 
    refresh the new GPO and associated links.



PSPath            : Microsoft.PowerShell.Core\FileSystem::
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\testGPOX
PSChildName       : testGPOX
PSDrive           : C
PSProvider        : Microsoft.PowerShell.Core\FileSystem
PSIsContainer     : True
Name              : testGPOX
FullName          : 
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\testGPOX
Parent            : GPOSettingsReports
Exists            : True
Root              : C:\
Extension         :
CreationTime      : 7/28/2021 9:45:45 AM
CreationTimeUtc   : 7/28/2021 1:45:45 PM
LastAccessTime    : 7/28/2021 9:45:45 AM
LastAccessTimeUtc : 7/28/2021 1:45:45 PM
LastWriteTime     : 7/28/2021 9:45:45 AM
LastWriteTimeUtc  : 7/28/2021 1:45:45 PM
Attributes        : Directory
Mode              : d-----
BaseName          : testGPOX
Target            : {}
LinkType          :


WARNING:
GPO:   'testGPOX'
Settings Results Saved to:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\testGPOX
") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 5.2

    } ElseIf ($section -eq "5.3") {
   
Write-Host -ForegroundColor Yellow ("
Section 5.3 - Create a New GPO, from a GPO Copy. 

This is just taking an existing GPO and replicating that 
`(policies, preferences, links`) into a new GPO, with a new name.")
Pause # Let user read summary, then display the example.


Write-Host("
EXAMPLE:
WidgetLLC2.Internal : List of Current GPO Display Names:
----------------

    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox
---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to copy FROM
Number 1 - 10: 2


Chosen GPO name:  'Default Domain Policy'
Is this existing GPO correct?
(y/n): y


WARNING:
New GPO name must be different than all existing GPO names.
Importing From:
GPO:  'Default Domain Policy'


Enter  0  To Return to Previous Menu
Enter a new GPO name
::: testGPO2
testGPO2


Is this name correct:   'testGPO2'
(y/n): y


Enter a descriptor comment for testGPOx2 : test test test comment2
------
------
------
DisplayName      : testGPO2
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 5a89e8c3-3e53-41d9-b36d-d4a78e5e0d6a
GpoStatus        : AllSettingsEnabled
Description      : Created by:  
Set-CreateGPOFrmBackup.ps1; Settings Imported from: Default Domain Policy. 
UserComment: test test test comment2
CreationTime     : 7/28/2021 10:34:33 AM
ModificationTime : 7/28/2021 10:34:33 AM
UserVersion      : AD Version: 0, SysVol Version: 0
ComputerVersion  : AD Version: 0, SysVol Version: 0
WmiFilter        :
PSPath            : Microsoft.PowerShell.Core\FileSystem::
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\
Default Domain Policy\2021-07-28-103433
PSChildName       : 2021-07-28-103433
PSDrive           : C
PSProvider        : Microsoft.PowerShell.Core\FileSystem
PSIsContainer     : True
Name              : 2021-07-28-103433
FullName          : 
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\
Default DomainPolicy\2021-07-28-103433
Parent            : Default Domain Policy
Exists            : True
Root              : C:\
Extension         :
CreationTime      : 7/28/2021 10:34:33 AM
CreationTimeUtc   : 7/28/2021 2:34:33 PM
LastAccessTime    : 7/28/2021 10:34:33 AM
LastAccessTimeUtc : 7/28/2021 2:34:33 PM
LastWriteTime     : 7/28/2021 10:34:33 AM
LastWriteTimeUtc  : 7/28/2021 2:34:33 PM
Attributes        : Directory
Mode              : d-----
BaseName          : 2021-07-28-103433
Target            : {}
LinkType          :
DisplayName     : Default Domain Policy
GpoId           : 31b2f340-016d-11d2-945f-00c04fb984f9
Id              : 27699c3c-ef88-4e92-9178-1aad9a17b501
BackupDirectory : C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\
Default Domain Policy\2021-07-28-103433

CreationTime    : 7/28/2021 10:34:33 AM
DomainName      : WidgetLLC2.Internal
Comment         :
LastWriteTime : 7/28/2021 10:34:33 AM
Length        : 0
Name          : targetOUs.txt



GPO backup 'Default Domain Policy', '2021-07-28-103433' was completed with no encryption.
DisplayName      : testGPO2
DomainName       : WidgetLLC2.Internal
Owner            : WIDGETLLC2\Domain Admins
Id               : 5a89e8c3-3e53-41d9-b36d-d4a78e5e0d6a
GpoStatus        : AllSettingsEnabled
Description      : Created by:  Set-CreateGPOFrmBackup.ps1; Settings Imported from: Default Domain Policy. User Comment: test test test comment2

CreationTime     : 7/28/2021 10:34:33 AM
ModificationTime : 7/28/2021 10:34:34 AM
UserVersion      : AD Version: 1, SysVol Version: 1
ComputerVersion  : AD Version: 1, SysVol Version: 1
WmiFilter        :



GPO Desciption above is also imported from Default Domain Policy.
Now adjusted to:
Created by:  Get-ImportGPOSettings.ps1; Settings Imported from: Default Domain Policy
WARNING: Overwrite OUs of GPO 'testGPO2' with OUs from GPO 'Default Domain Policy'


    NOTE - You may need to RE-OPEN Group Policy Management to refresh 
    the new GPO and associated links.

    Backups created through Get-ImportGPOSingle.ps1 are just for imports.

    Temporary backup for 'Default Domain Policy, '2021-07-28-103433' was deleted.

    Created by:  Get-ImportGPOSettings.ps1; Settings Imported from: Default Domain Policy



PSPath            : Microsoft.PowerShell.Core\FileSystem::
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\testGPO2



PSChildName       : testGPO2
PSDrive           : C
PSProvider        : Microsoft.PowerShell.Core\FileSystem
PSIsContainer     : True
Name              : testGPO2
FullName          : 
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\testGPO2
Parent            : GPOSettingsReports
Exists            : True
Root              : C:\
Extension         :
CreationTime      : 7/28/2021 10:34:34 AM
CreationTimeUtc   : 7/28/2021 2:34:34 PM
LastAccessTime    : 7/28/2021 10:34:34 AM
LastAccessTimeUtc : 7/28/2021 2:34:34 PM
LastWriteTime     : 7/28/2021 10:34:34 AM
LastWriteTimeUtc  : 7/28/2021 2:34:34 PM
Attributes        : Directory
Mode              : d-----
BaseName          : testGPO2
Target            : {}
LinkType          :


WARNING:
GPO:   'testGPO2'
Settings Results Saved to:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\TestGPO2LinkedToOU

") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 5.3

    } ElseIf ($section -eq "5.4") {

Write-Host -ForegroundColor Yellow ("Section 5.4 - Overwrite GPO1 with Existing GPO2")
Pause # Let user read summary, then display the example.

Write-Host("EXAMPLE:`nWidgetLLC2.Internal : List of Current GPO Display Names:
----------------

    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox
---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to copy FROM
Number 1 - 10: 8


Chosen GPO name:  'Install 7zip'
Is this existing GPO correct?
(y/n): y


    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) fakeGPOwChangesDefault
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox
---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to copy INTO
Number 1 - 10: 3


Chosen GPO name:  'FakeGPOOverwriteCheck'
Is this existing GPO correct?
(y/n): y


WARNING: Final GPO Confirmation
Source GPO:  'Install 7zip'
Is this GPO correct to copy FROM? (y/n): y


Destination GPO:  'FakeGPOOverwriteCheck'
Is this GPO correct to copy INTO? (y/n): y



Compare linked Organizational Units between GPOs, 'xInstall 7zip' and 'FakeGPOOverwriteCheck'
Green - OU is in both GPOs
Red - OU is only in the target GPO
----------------------------

OUs linked to GPO: xInstall 7zip

Target                                                           DisplayName   
------                                                           -----------   
ou=serveracademy,dc=widgetllc2,dc=internal                       xInstall 7zip
ou=domain groups,ou=serveracademy,dc=widgetllc2,dc=internal      xInstall 7zip
ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal       xInstall 7zip
ou=domain computers,ou=serveracademy,dc=widgetllc2,dc=internal   xInstall 7zip
ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal xInstall 7zip 

----------------------------

OUs linked to GPO: FakeGPOOverwriteCheck

None

-----------------------
WARNING:
Do you want to:
    1) Overwrite existing OU links in GPO 'FakeGPOOverwriteCheck'
    2) Add GPO 'xInstall 7zip's OU links to existing OU links in GPO 'FakeGPOOverwriteCheck'
    3) Keep GPO 'FakeGPOOverwriteCheck's OU Links without any change

1, 2 or 3
Choice = : 1



------------------------------
DisplayName     : xInstall 7zip
GpoId           : c60ee346-00ac-426c-b8da-62790b446c59
Id              : 9789e559-0598-402a-98bd-9d8a9c6bacbf
BackupDirectory : C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\
xInstall7zip\2021-07-28-104547

CreationTime    : 7/28/2021 10:45:47 AM
DomainName      : WidgetLLC2.Internal
Comment         :


Id               : 04bcb7d3-e4e4-4846-a1cd-101f7fed4a40
DisplayName      : FakeGPOOverwriteCheck
Path             : cn={04BCB7D3-E4E4-4846-A1CD-101F7FED4A40},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal
Owner            : WIDGETLLC2\Domain Admins
DomainName       : WidgetLLC2.Internal
CreationTime     : 7/27/2021 2:33:48 PM
ModificationTime : 7/28/2021 10:45:51 AM
User             : Microsoft.GroupPolicy.UserConfiguration
Computer         : Microsoft.GroupPolicy.ComputerConfiguration
GpoStatus        : AllSettingsEnabled
WmiFilter        :
Description      : Created by:  Get-ImportGPOSettings.ps1; Settings Imported from: fakeGPOwEverything


GPO Desciption above is also imported from xInstall 7zip. Now adjusted to:
Created by:  Get-ImportGPOSettings.ps1; Settings Imported from: xInstall 7zip



WARNING: 
Overwrite OUs of GPO 'FakeGPOOverwriteCheck' with OUs from GPO 'xInstall 7zip'
-------------------------------------------------

DisplayName   : FakeGPOOverwriteCheck
GpoId         : 04bcb7d3-e4e4-4846-a1cd-101f7fed4a40
Enabled       : True
Enforced      : False
Order         : 9
Target        : OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : FakeGPOOverwriteCheck
GpoId         : 04bcb7d3-e4e4-4846-a1cd-101f7fed4a40
Enabled       : True
Enforced      : False
Order         : 5
Target        : OU=Domain Groups,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : FakeGPOOverwriteCheck
GpoId         : 04bcb7d3-e4e4-4846-a1cd-101f7fed4a40
Enabled       : True
Enforced      : False
Order         : 9
Target        : OU=Domain Users,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : FakeGPOOverwriteCheck
GpoId         : 04bcb7d3-e4e4-4846-a1cd-101f7fed4a40
Enabled       : True
Enforced      : False
Order         : 9
Target        : OU=Domain Computers,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : FakeGPOOverwriteCheck
GpoId         : 04bcb7d3-e4e4-4846-a1cd-101f7fed4a40
Enabled       : True
Enforced      : False
Order         : 6
Target        : OU=Domain Users Extra,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal



    NOTE - You may need to RE-OPEN Group Policy Management to refresh
    the new GPO and associated links.
    Backups created through Get-ImportGPOSingle.ps1 are just for imports.
    Temporary backup for 'xInstall 7zip, '2021-07-28-104547' was deleted.



GPO:   'FakeGPOOverwriteCheck'
Settings Results Saved to:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\FakeGPOOverwriteCheck
") # End Write-Host-------------------------------



Write-Host -ForegroundColor Yellow ("
We have just taken all of the settings from the GPO 'Install 7zip' 
(policies, preferences, links) and imported/overwrote those in the 
existing GPO 'FakeGPOOverwriteCheck'") # End Write-Host
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 5.4

    } ElseIf ($section -eq "5.5") {
        
Write-Host -ForegroundColor Yellow ("
Section 5.5 - Open Group Policy Management Console 
Simply opens the gpmc console for the user to view the current GPO setup.") # End Write-Host

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 5.5

    } ElseIf ($section -eq "5.6") {
        
Write-Host -ForegroundColor Yellow ("
Section 5.6 - WARNING: Delete a GPO")
Write-Host("
WARNING:
WARNING!
WARNING!
DELETE GPO
Deleting the wrong GPO can cause significant problems.
Press Enter to continue...:



EXAMPLE:`nWidgetLLC2.Internal : List of Current GPO Display Names:
----------------
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) testGPO2
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to DELETE
Number 1 - 10: 4



Chosen GPO name:  'testGPO2'
Is this existing GPO correct?
(y/n): y



WARNING:
A full GPOReport for 'testGPO2' Must be viewed prior to deleting.
Press Enter to continue...:
") # End Write-Host-------------------------------



Write-Host -ForegroundColor Yellow ("Now a full settings report will be brought up by the program for the user to view before the GPO deletion process can continue.")



Write-Host ("
WARNING: Do you want to create a safety backup of GPO:
testGPO2
(yes/no): no



WARNING: User did not confirm backup of testGPO2 with 'yes'
WARNING: Are you sure that you want to delete GPO:
testGPO2
(yes/no): yes
") # End Write-Host-------------------------------


Write-Host -ForegroundColor Yellow ("GPO 'testGPO2' was deleted.")


    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 5.6

    } ElseIf ($section -eq "6.1") {
        
Write-Host -ForegroundColor Yellow ("
Section 6.1 - Back-up a Single GPO")
Write-Host("
EXAMPLE:
WidgetLLC2.Internal : List of Current GPO Display Names:
----------------
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) testGPO2
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to BACKUP
Number 1 - 10: 2



Chosen GPO name:  'Default Domain Policy'
Is this existing GPO correct?
(y/n): y



WARNING:
--------
Are you sure that you want to back-up Default Domain Policy?
(y/n): y

Do you want the backups to be Administrator Encrypted?
(y/n): y



    DisplayName     : Default Domain Policy
    GpoId           : 31b2f340-016d-11d2-945f-00c04fb984f9
    Id              : 64475e40-9a05-4030-aebd-44b2b5067f46
    BackupDirectory : 
    C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\
    Default DomainPolicy\2021-07-28-112114

    CreationTime    : 7/28/2021 11:21:15 AM
    DomainName      : WidgetLLC2.Internal



GPO backup 'Default Domain Policy', '2021-07-28-112114' was admin encrypted.
Only the user that created this backup, will have future access to it.
") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 6.1

    } ElseIf ($section -eq "6.2") {
    
Write-Host -ForegroundColor Yellow ("
Section 6.2 - View Info for a Target GPO Backup")
Pause # Let user read summary, then display the example.

Write-Host("
EXAMPLE:
WidgetLLC2.Internal : List of Current GPO Display Names:
----------------
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) testGPO2
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to BACKUP
Number 1 - 10: 5



Chosen GPO name:  'fakeGPOwEverything'
Is this existing GPO correct?
(y/n): y



GPO:   fakeGPOwEverything
List of Backups, Newest down to Oldest:
---
    1) 2021-07-27-142517
    2) 2021-07-26-134449
    3) 2021-07-26-134212
    4) 2021-07-26-133519


The most recent backup is:  2021-07-27-142517
---
Enter: 0  To Return to Prior Menu
---
Pick Which Existing GPO Backup to View:
Number: 1 - 4: 2



Chosen GPO Backup for:  fakeGPOwEverything
Is the Backup  2021-07-26-134449  correct? (y/n) : y



WARNING: GPO  `"BackupInfo_for__fakeGPOwEverything__from__2021-07-26-134449`"
Created to gather full diagnostic information on the backup for GPO 
fakeGPOwEverything, 2021-07-26-134449.
GPO will be deleted immediately after data is collected.



Id               : 42150fb0-b946-46d0-abce-fe92f1f2de56
DisplayName      : BackupInfo_for__fakeGPOwEverything__from__2021-07-26-134449
Path             : cn={42150FB0-B946-46D0-ABCE-FE92F1F2DE56},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal
Owner            : WIDGETLLC2\Domain Admins
DomainName       : WidgetLLC2.Internal
CreationTime     : 7/28/2021 11:25:22 AM
ModificationTime : 7/28/2021 11:25:25 AM
User             : Microsoft.GroupPolicy.UserConfiguration
Computer         : Microsoft.GroupPolicy.ComputerConfiguration
GpoStatus        : AllSettingsEnabled
WmiFilter        :
Description      : Created by:  
Get-ImportAllGPOBackups.ps1; All new GPOs with Settings Imported from previous GPOBackups.



-----
Organizational Units Linked to fakeGPOwEverything on backup 2021-07-26-134449
---------------------------------------------------------------------------
DisplayName   : BackupInfo_for__fakeGPOwEverything__from__2021-07-26-134449
GpoId         : 42150fb0-b946-46d0-abce-fe92f1f2de56
Enabled       : True
Enforced      : False
Order         : 10
Target        : OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : BackupInfo_for__fakeGPOwEverything__from__2021-07-26-134449
GpoId         : 42150fb0-b946-46d0-abce-fe92f1f2de56
Enabled       : True
Enforced      : False
Order         : 10
Target        : OU=Domain Users,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : BackupInfo_for__fakeGPOwEverything__from__2021-07-26-134449
GpoId         : 42150fb0-b946-46d0-abce-fe92f1f2de56
Enabled       : True
Enforced      : False
Order         : 7
Target        : OU=Domain Users Extra,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal
-------------------


Directory: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\
BackupInfo_for__fakeGPOwEverything__from__2021-07-26-134449


WARNING: 
GPO:   'BackupInfo_for__fakeGPOwEverything__from__2021-07-26-134449'

Settings Results Saved to:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\
BackupInfo_for__fakeGPOwEverything__from__2021-07-26-134449


WARNING: Tempory GPO:  
BackupInfo_for__fakeGPOwEverything__from__2021-07-26-134449  was deleted.
") # End Write-Host-------------------------------


Write-Host -ForegroundColor Yellow ("
The program will check if a settings report was created for the target 
GPO when the backup was created. If the settings report was NOT created 
at the time of the backup, then for full analysis details of a backup 
to be viewed, a tempory GPO is created,  analyzed, and then deleted.") # End Write-Host

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 6.2

    } ElseIf ($section -eq "6.3") {
        
Write-Host -ForegroundColor Yellow ("
Section 6.3 - Back-up All GPOs 

All active GPOs are backed up along with their links to Organizational Units.

A full Settings Report of that target GPO is also created. This report can be 
viewed if an import of said backup is being considered.

Backups are saved by default to:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups

These backups are sectioned off by GPO name, and then sub-sections of the timestamp
of when the GPO was backed up to allow the user to see a sequential backup list.")
    
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 6.3

    } ElseIf ($section -eq "6.4") {
        
Write-Host -ForegroundColor Yellow ("
GPO Backup Directory:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOFullBackup

Note: Not all active GPOs may have been backed up yet.
Names of current GPO Backups:
-----------------------------
1) 2021-08-26-075443
2) 2021-08-26-075900
3) 2021-08-27-080335
4) 2021-08-27-080647


---
Enter: 0  To Return to Prior Menu
---
Pick Which Existing GPO Backup View:
Number 1 - 4: 1


Chosen GPO Backup name:  2021-08-26-075443
Is the Backup GPO correct?
(y/n): y


GPO:   2021-08-26-075443
List of Backups, Newest down to Oldest:
---
1) xUser Default Wallpaper
2) xTestNCTGPO
3) xPreferenceCreateFolder
4) xInstall Firefox
5) xInstall Chrome
6) xInstall 7zip
7) Secure_computer



The most recent backup is:  xUser Default Wallpaper
---
Enter: 0  To Return to Prior Menu
---
Pick Which Existing GPO Backup to View:
Number: 1 - 7: 6

Chosen GPO Backup for:  2021-08-26-075443
Is the Backup  xInstall 7zip  correct?
(y/n): y


Directory: C:\Program
Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOFullBackup\2021-08-26-075443\xInstall 7zip


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        8/26/2021   7:55 AM                {F877B296-8015-47D1-ADD4-578CCB873051}
-a----        8/26/2021   7:55 AM         203896 2021-08-26-075505_htmlReport.html
-a----        8/26/2021   7:55 AM            295 targetOUs.txt

The settings report for GPO '2021-08-26-075443', backup from 'xInstall 7zip'
Can be found at:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOFullBackup\2021-08-26-075443\xInstall 7zip

")
    
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 6.4

    } ElseIf ($section -eq "6.5") {
        
Write-Host -ForegroundColor Yellow ("
GPO Backup Directory:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\

This simply opens the GPOData directory, used for GPOProgram Backups and GPO data captures.
The GPOProgram also allows the user to view these through PowerShell, but the direct access
through `'explorer.exe'` is preferred at times.


")
        
        #----------
        #----------
        #----------
        #----------
        #----------
        #----------
        #----------
        #----------
        #----------
        #----------
        #----------
        #----------
        # End of Section 6.5

    } ElseIf ($section -eq "7.1") {
    
Write-Host -ForegroundColor Yellow ("
Section 7.1 - COPY: GPO1 Exists; Create GPO2 
Then copy settings from GPO1 into GPO2")
Pause # Let user read summary, then display the example.

Write-Host("
EXAMPLE:
WidgetLLC2.Internal : List of Current GPO Display Names:
----------------
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) testGPO2
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to BACKUP
Number 1 - 10: 5


Chosen GPO name:  'fakeGPOwEverything'
Is this existing GPO correct?
(y/n): y


---
Enter  0  To Quit and Return to Previous Menu
WARNING: New GPO name must be different that all existing GPO names.
Enter a new GPO name: testGPOcopy1


New GPO name: testGPOcopy1
Is the new GPO name correct? (y/n) : y



---------------
DisplayName     : fakeGPOwEverything
GpoId           : 7eb126a7-86ba-4253-ae5c-0b045e3deb95
Id              : 075a6ff7-7ff2-4b74-b93d-4c8e1f03c30f
BackupDirectory : 
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\
fakeGPOwEverything\2021-07-28-140531
CreationTime    : 7/28/2021 2:05:31 PM
DomainName      : WidgetLLC2.Internal
Comment         :



GPO backup 'fakeGPOwEverything', '2021-07-28-140531' was completed with no encryption.



Id               : 1b0c89fd-faf6-4777-aa76-b037f672190e
DisplayName      : testGPOcopy1
Path             : cn={1B0C89FD-FAF6-4777-AA76-B037F672190E},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal
Owner            : WIDGETLLC2\Domain Admins
DomainName       : WidgetLLC2.Internal
CreationTime     : 7/28/2021 2:05:34 PM
ModificationTime : 7/28/2021 2:05:34 PM
User             : Microsoft.GroupPolicy.UserConfiguration
Computer         : Microsoft.GroupPolicy.ComputerConfiguration
GpoStatus        : AllSettingsEnabled
WmiFilter        :
Description      : Created by:  Get-ImportGPOSettings.ps1; Settings Imported from: fakeGPOwEverything


Id               : 1b0c89fd-faf6-4777-aa76-b037f672190e
DisplayName      : testGPOcopy1
Path             : cn={1B0C89FD-FAF6-4777-AA76-B037F672190E},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal
Owner            : WIDGETLLC2\Domain Admins
DomainName       : WidgetLLC2.Internal
CreationTime     : 7/28/2021 2:05:34 PM
ModificationTime : 7/28/2021 2:05:37 PM
User             : Microsoft.GroupPolicy.UserConfiguration
Computer         : Microsoft.GroupPolicy.ComputerConfiguration
GpoStatus        : AllSettingsEnabled
WmiFilter        :
Description      : Created by:  Get-ImportAllGPOBackups.ps1; 
All new GPOs with Settings Imported from previous GPO Backups.




GPO Desciption above is also imported from fakeGPOwEverything.
Now adjusted to:
Created by:  Get-ImportGPOSettings.ps1; Settings Imported from: fakeGPOwEverything




WARNING: Overwrite OUs of GPO 'testGPOcopy1' with OUs from GPO 'fakeGPOwEverything'
---------------------------------------------------------
DisplayName   : testGPOcopy1
GpoId         : 1b0c89fd-faf6-4777-aa76-b037f672190e
Enabled       : True
Enforced      : False
Order         : 10
Target        : OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : testGPOcopy1
GpoId         : 1b0c89fd-faf6-4777-aa76-b037f672190e
Enabled       : True
Enforced      : False
Order         : 10
Target        : OU=Domain Users,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : testGPOcopy1
GpoId         : 1b0c89fd-faf6-4777-aa76-b037f672190e
Enabled       : True
Enforced      : False
Order         : 7
Target        : OU=Domain Users Extra,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal




NOTE - You may need to RE-OPEN Group Policy Management to refresh 
the new GPO and associated links.
Backups created through Get-ImportGPOSingle.ps1 are just for imports.
Temporary backup for 'fakeGPOwEverything, '2021-07-28-140531' was deleted.




WARNING:
GPO:   'testGPOcopy1'
Settings Results Saved to:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\testGPOcopy1
") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 7.1

    } ElseIf ($section -eq "7.2") {
    
Write-Host -ForegroundColor Yellow ("
Section 7.2 - MERGE: GPO1 exists; GPO2 Exists 
Then merge settings from GPO1 into GPO2") # End Write-Host

Pause # Let user read summary, then display the example.

Write-Host("
EXAMPLE:
WidgetLLC2.Internal : List of Current GPO Display Names:
----------------
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) testGPO2
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to BACKUP
Number 1 - 10: 5


Chosen GPO name:  'fakeGPOwEverything'
Is this existing GPO correct?
(y/n): y



WidgetLLC2.Internal : List of Current GPO Display Names:
----------------
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) testGPO2
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to import INTO
Number 1 - 10: 4



Chosen GPO name:  'testGPOx2'
Is this existing GPO correct?
(y/n): y



WARNING: Final GPO Confirmation

Chosen GPO name:  fakeGPOwEverything
Is this GPO correct to import FROM? (y/n): y


Chosen GPO name:  testGPOx2
Is this GPO correct to import INTO? (y/n) : y
") # End Write-Host-------------------------------


Write-Host ("Compare linked Organizational Units between GPOs, 'fakeGPOwEverything' and 'testGPOx2'")
Write-Host -ForegroundColor Green ("Green")
Write-Host ("OU is in both GPOs")
Write-Host -ForegroundColor Red ("Red")
Write-Host ("OU is only in the target GPO
----------------------------

OUs linked to GPO: fakeGPOwEverything


Target                                                           DisplayName        
------                                                           -----------        
ou=serveracademy,dc=widgetllc2,dc=internal                       fakeGPOwEverything 
ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal       fakeGPOwEverything 
ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal fakeGPOwEverything 
") # End Write-Host-------------------------------

Write-Host -ForegroundColor Red ("ou=serveracademy,dc=widgetllc2,dc=internal")
Write-Host -ForegroundColor Red ("ou=domain users,ou=serveracademy,dc=widgetllc2,dc=internal")
Write-Host -ForegroundColor Red ("ou=domain users extra,ou=serveracademy,dc=widgetllc2,dc=internal") # End Write-Host
Write-Host ("
----------------------------

OUs linked to GPO: testGPOx2") # End Write-Host
Write-Host -ForegroundColor Red ("None")

Write-Host ("
-----------------------

Press Enter to continue...:
WARNING:
Do you want to:
    1) Overwrite existing OU links in GPO 'testGPOx2'
    2) Add GPO 'fakeGPOwEverything's OU links to existing OU links in GPO 'testGPOx2'
    3) Keep GPO 'testGPOx2's OU Links without any change
-----------`n(1, 2 or 3)
Choice = : 1



DisplayName     : fakeGPOwEverything
GpoId           : 7eb126a7-86ba-4253-ae5c-0b045e3deb95
Id              : 1e347467-5880-4382-94e5-7d42b5f363ab
BackupDirectory : C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\fakeGPOwEverything\2
                  021-07-30-102113
CreationTime    : 7/30/2021 10:21:13 AM
DomainName      : WidgetLLC2.Internal
Comment         :


GPO backup 'fakeGPOwEverything', '2021-07-30-102113' was completed with no encryption.



Id               : a71d137a-6ed9-4184-9d6d-6894e3114db2
DisplayName      : testGPOx2
Path             : cn={A71D137A-6ED9-4184-9D6D-6894E3114DB2},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal
Owner            : WIDGETLLC2\Domain Admins
DomainName       : WidgetLLC2.Internal
CreationTime     : 7/28/2021 10:31:14 AM
ModificationTime : 7/30/2021 10:21:19 AM
User             : Microsoft.GroupPolicy.UserConfiguration
Computer         : Microsoft.GroupPolicy.ComputerConfiguration
GpoStatus        : AllSettingsEnabled
WmiFilter        :
Description      : Created by:  Get-ImportAllGPOBackups.ps1; All new GPOs with Settings Imported from previous GPO Backups.




GPO Desciption above is also imported from fakeGPOwEverything.
Now adjusted to:
Created by:  Get-ImportGPOSettings.ps1; Settings Imported from: fakeGPOwEverything


WARNING: Overwrite OUs of GPO 'testGPOx2' with OUs from GPO 'fakeGPOwEverything'
-------------------------------------------------------
DisplayName   : testGPOx2
GpoId         : a71d137a-6ed9-4184-9d6d-6894e3114db2
Enabled       : True
Enforced      : False
Order         : 11
Target        : OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : testGPOx2
GpoId         : a71d137a-6ed9-4184-9d6d-6894e3114db2
Enabled       : True
Enforced      : False
Order         : 11
Target        : OU=Domain Users,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : testGPOx2
GpoId         : a71d137a-6ed9-4184-9d6d-6894e3114db2
Enabled       : True
Enforced      : False
Order         : 8
Target        : OU=Domain Users Extra,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal



NOTE - You may need to RE-OPEN Group Policy Management to refresh the new GPO and associated links.


Backups created through Get-ImportGPOSingle.ps1 are just for imports.
Temporary backup for 'fakeGPOwEverything, '2021-07-30-102113' was deleted.



GPO:   'testGPOx2'
Settings Results Saved to:
 C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\testGPOx2

") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 7.2

    } ElseIf ($section -eq "7.3") {
    
Write-Host -ForegroundColor Yellow ("
Section 7.3 - IMPORT: GPO1 Exists; Backup Exists 
Then import settings from backup into GPO1") # End Write-Host
Pause # Let user read summary, then display the example.  

Write-Host("
GPO Backup Directory:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups
Names of GPO Backups:
---
1) Default Domain Controllers Policy
2) Default Domain Policy
3) deletemeAddOU
4) deletemeKeepOU
5) deletemeOverWriteOU
6) FakeGPOOverwriteCheck
7) fakeGPOwChangesDefault
8) fakeGPOwEverything
9) fakeGPOwEverythingIMPORTED
10) newTESTGPO

---
Enter: 0  To Return to Prior Menu
Pick Which Existing GPO Backup to Import From: 1 - 10
::: 8


Chosen GPO Backup name:  fakeGPOwEverything
Is the Backup GPO correct? (y/n) : y



GPO:   fakeGPOwEverything
List of Backups, Newest down to Oldest:
---
1) 2021-07-30-102610
2) 2021-07-29-102557
3) 2021-07-38-081429

The most recent backup is:  2021-07-30-102610


---
Enter: 0  To Return to Prior Menu
Pick Which Existing GPO Backup to Import From: Number 1 - 3: 1



Chosen GPO Backup for:  fakeGPOwEverything
Is the Backup  2021-07-30-102610  correct? (y/n) : y



WidgetLLC2.Internal : List of Current GPO Display Names:
----------------
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) testGPO2
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
Enter: 0 to Return to Prior Menu
Pick Which existing GPO to Import settings INTO, FROM a Backup GPO 'fakeGPOwEverything'
Number 1 - 10:  4



Chosen GPO name:  'testGPO2'
Is this existing GPO correct?
(y/n): y
    


Is the backup 'fakeGPOwEverything' from '2021-07-30-102610' correct?
(y/n): y


Is the target GPO 'testGPO2' correct?
(y/n): y



Id               : a71d137a-6ed9-4184-9d6d-6894e3114db2
DisplayName      : testGPO2
Path             : cn={A71D137A-6ED9-4184-9D6D-6894E3114DB2},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal
Owner            : WIDGETLLC2\Domain Admins
DomainName       : WidgetLLC2.Internal
CreationTime     : 7/28/2021 10:31:14 AM
ModificationTime : 7/30/2021 10:32:08 AM
User             : Microsoft.GroupPolicy.UserConfiguration
Computer         : Microsoft.GroupPolicy.ComputerConfiguration
GpoStatus        : AllSettingsEnabled
WmiFilter        :
Description      : Created by:  Get-ImportAllGPOBackups.ps1; All new GPOs with Settings Imported from previous GPO Backups.


NOTE - You may need to RE-OPEN Group Policy Management to refresh the new GPO and associated links.

WARNING:
GPO:   'testGPO2'
Settings Results Saved to:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\testGPO2
") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 7.3

    } ElseIf ($section -eq "7.4") {
    
Write-Host -ForegroundColor Yellow ("
Section 7.4 - CREATE a new GPO from a backup 
New GPO name must be unique ") # End Write-Host
Pause # Let user read summary, then display the example.


Write-Host("
GPO Backup Directory:
C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups
Names of GPO Backups:
---
1) Default Domain Controllers Policy
2) Default Domain Policy
3) deletemeAddOU
4) deletemeKeepOU
5) deletemeOverWriteOU
6) FakeGPOOverwriteCheck
7) fakeGPOwChangesDefault
8) fakeGPOwEverything
9) fakeGPOwEverythingIMPORTED
10) newTESTGPO

---
Enter: 0  To Return to Prior Menu
Pick Which Existing GPO Backup to Import From: 1 - 10
::: 8


Chosen GPO Backup name:  fakeGPOwEverything
Is the Backup GPO correct? (y/n) : y



GPO:   fakeGPOwEverything
List of Backups, Newest down to Oldest:
---
1) 2021-07-30-102610
2) 2021-07-30-102557
3) 2021-07-30-081429

The most recent backup is:  2021-07-30-102610


---
Enter: 0  To Return to Prior Menu
Pick Which Existing GPO Backup to Import From: Number 1 - 3: 1



Chosen GPO Backup for:  fakeGPOwEverything
Is the Backup  2021-07-30-102610  correct? (y/n) : y



WidgetLLC2.Internal : List of Current GPO Display Names:
----------------
    1) Default Domain Controllers Policy
    2) Default Domain Policy
    3) FakeGPOOverwriteCheck
    4) testGPO2
    5) fakeGPOwEverything
    6) fakeGPOwEverythingIMPORTED
    7) Secure_computer
    8) Install 7zip
    9) Install Chrome
    10) Install Firefox

---
WARNING:

New GPO name must be different than all existing GPO names.
Importing From:
GPO:      fakeGPOwEverything
Backup:   2021-07-30-102610
---
Enter  0  To Return to Previous Menu
Enter a new GPO name: newGPOX2


Is this name correct:   newGPOX2
(y/n): y


Enter a descriptor comment for newGPOX2 : test comment



Id               : b5aa5ecc-8fcb-4582-a07c-c984cf96de91
DisplayName      : newGPOX2
Path             : cn={B5AA5ECC-8FCB-4582-A07C-C984CF96DE91},cn=policies,cn=system,DC=WidgetLLC2,DC=Internal
Owner            : WIDGETLLC2\Domain Admins
DomainName       : WidgetLLC2.Internal
CreationTime     : 7/30/2021 10:37:05 AM
ModificationTime : 7/30/2021 10:37:05 AM
User             : Microsoft.GroupPolicy.UserConfiguration
Computer         : Microsoft.GroupPolicy.ComputerConfiguration
GpoStatus        : AllSettingsEnabled
WmiFilter        :
Description      : Created by:  Set-CreateGPOFrmBackup.ps1; Settings Imported from: fakeGPOwEverything,
                   2021-07-30-102610 --- User Comment: test comment




Created by:  Get-ImportAllGPOBackups.ps1; All new GPOs with Settings Imported from previous GPO Backups.
-----------------------------------------------------------------------
DisplayName   : newGPOX2
GpoId         : b5aa5ecc-8fcb-4582-a07c-c984cf96de91
Enabled       : True
Enforced      : False
Order         : 12
Target        : OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : newGPOX2
GpoId         : b5aa5ecc-8fcb-4582-a07c-c984cf96de91
Enabled       : True
Enforced      : False
Order         : 12
Target        : OU=Domain Users,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal


DisplayName   : newGPOX2
GpoId         : b5aa5ecc-8fcb-4582-a07c-c984cf96de91
Enabled       : True
Enforced      : False
Order         : 9
Target        : OU=Domain Users Extra,OU=serveracademy,DC=WidgetLLC2,DC=Internal
GpoDomainName : WidgetLLC2.Internal




NOTE - You may need to RE-OPEN Group Policy Management to refresh the new GPO and associated links.

Directory: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\newGPOX2


WARNING:
GPO:   'newGPOX2'
Settings Results Saved to:
 C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOSettingsReports\newGPOX2
") # End Write-Host-------------------------------

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 7.4

    } ElseIf ($section -eq "7.5") {
    
Write-Host -ForegroundColor Yellow ("
Section 7.5 - Create/Overwrite GPOs from every backup

{Create / Overwrite} if GPO backup name {DNE / Exists}.") # End Write-Host


Write-Host ("
WARNING:
--------
This will create new GPOs for any GPO backup name that is not active,
and will also overwrite any active GPO with the same name as a backup.

This is dangerous.
We recommend doing a full GPO backup first, so that the current settings
can be brought back in, if this full import affects your system.

Would you like a full GPO Backup to be called from here?
Enter 0 to exit
(y/n): n


Final confirmation.
This will NOT create a timestamped backup of the current GPOs.
Then, after a user selection of a prior GPO backup set, from that set,
it will create new GPOs for any GPO backup name that is not active,
and it will also overwrite any active GPO with the same name.
Can you confirm, DO NOT do a full GPO safety backup, and then do a full GPO backup import?

Enter 0 to exit
(y/n): y



Dates of Full System GPO Backups:
--------------------
1) 2021-08-10-073720
2) 2021-08-10-073847
3) 2021-08-10-074130
----------
Enter 0 to exit
Which date of full GPO backups do you want to view?
(1 - 3): 2



GPOs from '2021-08-10-073847' backup.
----------
> Default Domain Controllers Policy
> Default Domain Policy
> Secure_computer
> secure_computerxxx
> xInstall 7zip
> xInstall Chrome
> xInstall Firefox
> xUser Default Wallpaper
----------
Is the GPO Backup set from '2021-08-10-073847' your choice to import from?
(y/n): y



Importing Backups...
Progress:
[oooooooooooooooooooo             ]


____________________________
WARNING: NOTE - You may need to RE-OPEN Group Policy Management to refresh the new GPO and associated links.
Press Enter to continue...:
") # End Write-Host-------------------------------


Write-Host -ForegroundColor Yellow("
Depending on a systems GPOs, and backups, this process can take several minutes.")

    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    # End of Section 7.5
       
    } # End If/ElseIf-------------------------------
        
} # End  function Get-GPOFunctionsModuleHelp
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------
    #----------

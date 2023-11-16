#-------------------------------------------------
# Function to show the GPOFunctions as a list and a summary of each.
# When caled individually, these can be viewed in PowerShell by:
#   > Get-Help <functionName> -Full
#   < Get-Help "Get-GPOsBackups" -Examples
#
# But 'Get-Help' can cause issues when called from GPOProgram
# This is a sub-function that displays the help/explanations for GPOFunctionsModule functions inside GPOProgram.

function Get-GPOFunctionsSummary {
#=================
Param(
    [Parameter(Mandatory = $true)]
    [string]
    $function
) # End Param-------------------------------
        
        Write-Host -ForegroundColor Yellow ("
    |======================================================================|
    |============--- GPOFunctionsModule Functions Summary  ---=============|
    |======================================================================|`n")
        
        If ($function -eq "Find-AllGPOSettings") {
# PowerShell Formatting - Leave Indentations alone.
    Write-Host -ForegroundColor Yellow (" 
    Function Find-AllGPOSettings {`n`n
    .SYNOPSIS
    View all settings, policies, preferences, and links in a single GPO


    .DESCRIPTION
    Input the name of an active GPO. (`$sourceGPOParam) This is a mandatory parameter.
    This collects all settings from that GPO both Policies and Preferences
    Exports this settings to an HTML that can be viewed in any browser.


    .EXAMPLE
    # Get full settings report for a specific GPO. Files will be saved, and displayed.
    #-------------------------------------------------
    > Find-AllGPOSettings -sourceGPOParam `"gpoName`"


    .EXAMPLE
    # Get full settings report for a specific GPO. Files will be saved, and displayed.
    # HTML settings report will also be returned to the caller.
    #------------------------------------------------------------------------
    > Find-AllGPOSettings -sourceGPOParam `"Install 7zip`" -returnfile `$true

    
    Param(
        [Parameter(Mandatory = `$true)]
        [String] 
        `$sourceGPOParam,

        [Parameter()]
        [bool[]]
        `$returnfile

    ) #End Param-------------------------------`n`n")

        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Find-AllGPOSetting
        #-----
        #========================================
        If ($function -eq "Get-AllGPOs") {
# PowerShell Formatting - Leave Indentations alone.            
    Write-Host -ForegroundColor Yellow ("
    Function Get-AllGPOs {


    .SYNOPSIS
    From the Domain Controller, this collects summary info for the associated Group Policy Objects



    .Example
    # Results printed to terminal
    #------------------------------
    > Get-AllGPOs -gridview `$false
    


    .Example
    # Results printed to gridview
    #-----------------------------
    > Get-AllGPOs -gridview `$true
    


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


    
    Param(
        [Parameter(Mandatory = `$true)]
        [bool] `$gridview
    ) #End Param-------------------------------`n`n")

        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-AllGPO
        #-----
        #========================================
        If ($function -eq "Get-AllGPOsNames") {
# PowerShell Formatting - Leave Indentations alone.            
    Write-Host -ForegroundColor Yellow ("
    Function Get-AllGPOsNames
    
    .SYNOPSIS
    From the Domain Controller, this collects the associated Group Policy Objects names


    .DESCRIPTION
    No Parameters. Simply returns a list of the names of all GPOS


    .Example
    > Get-AllGPOsNames


    .Example
    > Get-AllGPOsNames | Out-Gridview


    .OUTPUTS
    (SAMPLE List)
    abc_GPO123
    def_GPO456
    ghi_GPO789

    
    There are no Parameters
    -------------------------------
    ")
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-AllGPOsName
        #-----
        #========================================
        If ($function -eq "Get-AllGPOsNamesNumbered") {
# PowerShell Formatting - Leave Indentations alone.            
    Write-Host -ForegroundColor Yellow ("
    Function Get-AllGPOsNamesNumbered {


    .SYNOPSIS
    From the Domain Controller, this collects the associated Group Policy Objects names


    .DESCRIPTION
    No Parameters. Simply returns a list of the names of all GPOS, but numbered in alphabetical order.


    .Example
    > Get-AllGPOsNamesNumbered


    .Example
    > Get-AllGPOsNamesNumbered | Out-Gridview


    .OUTPUTS
    (SAMPLE List)
    1) abc_GPO123
    2) def_GPO456
    3) ghi_GPO789
    -------------------------------
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-AllGPOsNamesNumbered
        #-----
        #========================================

    If ($function -eq "Get-AllGPOsSummary") {
# PowerShell Formatting - Leave Indentations alone.            
    Write-Host -ForegroundColor Yellow ("
    Function Get-AllGPOsSummary {


    .SYNOPSIS
    From the Domain Controller, this collects summary info for the associated Group Policy Objects
    Nearly the same as Get-AllGPOs but does not return a hash table.



    .Example
    # Results printed to terminal
    #------------------------------
    > Get-AllGPOsSummary -gridview `$false
    


    .Example
    # Results printed to gridview
    #-----------------------------
    > Get-AllGPOsSummary -gridview `$true
    


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


    
    Param(
        [Parameter(Mandatory = `$true)]
        [bool] `$gridview
    ) #End Param-------------------------------`n`n")

        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-AllGPO
        #-----
        #========================================

        If ($function -eq "Get-CompareTwoGPOsOUs") {
# PowerShell Formatting - Leave Indentations alone. 
    Write-Host -ForegroundColor Yellow ("
    Function Get-CompareTwoGPOsOUs {


    .SYNOPSIS
    This is a simple function to visually compare the Organizational Unts of 2 GPOs



    .Example
    # Pick 2 GPOs from list of active GPOs. These are mandatory for a comparison
    #----------------------------------------------------------------------
    > Get-CompareTwoGPOsOUs -sourceGPOParam `"gpo1A`" -destGPOParam `"gpo2B`"
    



    .OUTPUTS
    OUs from GPO: gpo1A
    Target                                               DisplayName    Enabled Order GpoId
    ------                                              -----------    ------- ----- -----
    ou=serv1, dc=xTool2, dc=internal                        gpo1A          True    1     fef09f10-a67f...
    ou=domain users, ou=serv1, dc=xTool2, dc=internal       gpo1A          True    1     fef09f10-a67f...
    ou=domain users extra, ou=serv1, dc=xTool2, dc=internal gpo1A          True    1     fef09f10-a67f...


    OUs from GPO: gpo2B
    Target                                              DisplayName      Enabled Order GpoId
    ------                                              -----------      ------- ----- -----
    ou=domain groups, ou=serv1, dc=xTool2, dc=internal      gpo2B           True    3     ddbaa7fb-ef27...
    ou=domain computers, ou=serv1, dc=xTool2, dc=internal   gpo2B           True    7     ddbaa7fb-ef27...



    Param(
        [Parameter(Mandatory = `$true)]
        [String] `$sourceGPOParam,

        [Parameter(Mandatory = `$true)] 
        [String] `$destGPOParam 
    ) #End Param-------------------------------
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-CompareTwoGPOsOU
        #-----
        #========================================
        If ($function -eq "Get-GPOFunctionsModuleHelp") {
# PowerShell Formatting - Leave Indentations alone. 
    Write-Host -ForegroundColor Yellow ("
    This function was created specifically to help display help, and summaries for GPOProgram Sections.
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-GPOFunctionsModuleHelp
        #-----
        #========================================
        If ($function -eq "Get-GPOFunctionsSummary") {
# PowerShell Formatting - Leave Indentations alone. 
    Write-Host -ForegroundColor Yellow ("
    This function was created specifically to help display help, 
    and summaries for GPOFunctionsModule functions.

    The standard PowerShell 'get-help' command, is fully active, and can be applied 
    towards GPOFunctionsModule functions, but those help sections lose data when the 'get-help' is
    called through the GPOProgram. This function was built to display primary 'get-help' information
    for each function, while in the GPOProgram.

    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-GPOFunctionsSummary
        #-----
        #========================================
        If ($function -eq "Get-GPOsBackups") {
# PowerShell Formatting - Leave Indentations alone. 
    Write-Host -ForegroundColor Yellow ("
    Function Get-GPOsBackups {


    .SYNOPSIS
    Simple module to display list of current GPO backups, and sub-backups.
    Upon the selection of a target backup, if the target backup was created using the GPOFunctionsModule,
    there there will also be a GPO Summary document that was also created to view everything that this
    backup contains. If that does not exist in this target backup, then a new one will be created upon the
    selection.


    .EXAMPLE
    > Get-GPOsBackups


    .EXAMPLE
    > Get-GPOsBackups -fullBackupParam `$true
    # If param is true, this will view the full backup sets, not the individul backups.

    
    .OUTPUT
    GPO Backup Directory:
    C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups

    Note: Not all active GPOs may have been backed up yet.
    Names of current GPO Backups:
    -----------------------------
    1) Default Domain Policy
    2) fakeGPOwEverything



    GPO:   Default Domain Policy
    List of Backups, Newest down to Oldest:
    ---
    1) 2021-08-16-132749
    2) 2021-08-14-142749
    3) 2021-08-12-122749

    -------------------------------

    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-GPOsBackups
        #-----
        #========================================
        If ($function -eq "Get-GPOsDomain") {
# PowerShell Formatting - Leave Indentations alone. 
    Write-Host -ForegroundColor Yellow ("
    Function Get-GPOsDomain {  


    .SYNOPSIS
    Gather the primary domain holding this machine.


    .DESCRIPTION
    No Parameters. Simply returns the local domain.


    .Example
    > Get-GPOsDomain


    .Example
    # Will return the domain to a function, and write the domain in terminal.
    ----------------------------------
    > Get-GPOsDomain `$writehost `$true
    

    .Example
    # Will return the domain to a function, and WILL NOT write the domain in terminal.
    ---------------------------------
    > Get-GPOsDomain `$writehost `$false


    .OUTPUTS
     Domain:     WidgetLLC.Internal


    Param(
        [Parameter()]
        [bool[]]
        `$writehost = `$true # Don't want to writeout if called by other function
    ) # End Param-------------------------------`n`n
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-GPOsDomain
        #-----
        #========================================
        If ($function -eq "Get-GPOsDomainController") {
# PowerShell Formatting - Leave Indentations alone. 
    Write-Host -ForegroundColor Yellow ("
    Function Get-GPOsDomainController {


    .SYNOPSIS
    Gather the primary domain controller holding this machine.


    .DESCRIPTION
    No Parameters. Simply returns the local domain controller.


    .Example
    Get-GPOsDomainController


    .Example
    # Will return the domain controller to a function, and write the domain controller in terminal.
    #------------------------------------------
    > Get-GPOsDomainController `$writehost `$true
    

    .Example
    # Will return the domain controller to a function, and WILL NOT write the domain controller in terminal.
    ---------------------------------------------
    > Get-GPOsDomainController `$writehost `$false
    

    .OUTPUTS
    Return Domain Example:     DC02.WidgetLLC.Internal


    [CmdletBinding()]
    Param(
        [Parameter()]
        [bool[]]
        `$writehost = `$true #Don't want to writeout if called by other function
    ) # End Param-------------------------------`n`n
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-GPOsDomainController
        #-----
        #========================================
        If ($function -eq "Get-GPOsHashTable") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-GPOsHashTable {
    

    .SYNOPSIS
    Create a hash table for fast GPO lookups later in the report. Only used as a sub-function


    .DESCRIPTION
    No Parameters. Simply returns all GPOS in a hash form
    This is not usable to be returned without pre-hashtable code waiting for it.


    .Example
    > Get-GPOsHashTable


    .OUTPUTS
    No viewable returns. This function is used to return function data.

    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-GPOsHashTable
        #-----
        #========================================
        If ($function -eq "Get-GPOsLinks") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-GPOsLinks {


    .SYNOPSIS
    SOM: Scope of Management: Any location where a GPO is linked to such as a domain, or OU


    .DESCRIPTION
    No Mandatory Parameters. Simply returns GPO links


    .EXAMPLE
    > Get-GPOLinks


    .EXAMPLE
    > Get-GPOLinks | Out-Gridview


    .EXAMPLE
    # A target address can be sent, otherwise it will cycle through all potential OU addresses
    -----------------------------------------------------------------
    > Get-GPOLinks -Path `"OU=serveracademy,DC=WidgetLLC2,DC=Internal`"
    


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
    DC=WidgetLLC2, DC=Internal                    
    OU=Domain Controllers, DC=WidgetLLC2, DC=Internal         
    OU=serveracademy, DC=WidgetLLC2, DC=Internal        
    OU=Domain Groups, OU=serveracademy, DC=WidgetLLC2 DC=Internal                                                                         
    OU=SubGroups, OU=Domain Groups, OU=serveracademy, DC=WidgetLLC2 DC=Internal                                                             
    
    gPLink                                               
    ------                                               
    [LDAP://CN={31B2F340-016D-11D2-945F-00C04FB984F9},...
    [LDAP://CN={6AC1786C-016F-11D2-945F-00C04fB984F9},...
    [LDAP://cn={835e8b34-0d44-4b8e-9014-44f54f6f153f},...
    [LDAP://cn={F09D30FD-81AE-4F7B-9F5C-8343D98975BB},...
    [LDAP://cn={B85E5983-8FED-4BA1-94E5-46537516EF0B},...


    Param(
        [Parameter()]
        [string]
        `$Path
    ) # End Param-------------------------------`n`n
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-GPOsLinks
        #-----
        #========================================
        If ($function -eq "Get-GPOsRegistryValues") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-GPOsRegistryValues {


    .SYNOPSIS
    Find the Registry values i.e. policy keys associated with a GPO. 
    This will progress through any key-path given, and will also return error messages for all sub-paths 
    that do not hold a registry key.


    .DESCRIPTION
    Simply returns registry values from a target registry path.
    This can be set in a loop to cover all registry paths, or all GPOs for a target keypath.


    .Example
    > Get-GPOsRegistryValues -gpoNameParam Secure_computer -keyParam 'HKCU\Software'


    .Example
    > Get-GPOsRegistryValues -gpoNameParam `"Secure_computer`" -keyParam
    `"HKCU\Software\Microsoft\Windows\CurrentVersion\Policies`"


    .Example
    > Get-GPOsRegistryValues -gpoNameParam Secure_computer -keyParam 'HKCU\Software' | Out-Gridview



    .OUTPUTS
    SAMPLE ERROR - Powershell red-text with this comment below, indcates that there is no 
    registry value in that location.

    Get-GPRegistryValue : The following Group Policy registry setting was not found: 
    `"HKEY_CURRENT_USER\Software\Policies\Microsoft\SystemCertificates\Trust\Certificates`"
    Parameter name: keyPath
        

            
    Param(
        [Parameter()]
        [string] `$gpoNameParam,

        [Parameter()]
        [string] `$keyParam
    ) # End Param-------------------------------
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-GPOsRegistryValues
        #-----
        #========================================
        If ($function -eq "Get-GPOsScopeOfManagement") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-GPOsScopeOfManagement {


    .SYNOPSIS
    SOM: Scope of Management: Any location where a GPO is linked to such as a domain, or OU


    .DESCRIPTION
    If No Parameters, simply returns full scope of management information for GPO links


    .EXAMPLE
    > Get-GPOScopeOfManagement


    .EXAMPLE
    > Get-GPOScopeOfManagement -Path `"OU=Domain Computers, OU=serveracademy,DC=WidgetLLC2,DC=Internal`"


    .EXAMPLE
    > Get-GPOScopeOfManagement | Out-Gridview


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


    Param(
        [Parameter()]
        [string]
        `$Path
    ) # End Param-------------------------------`n`n
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-GPOsScopeOfManagement
        #-----
        #========================================
        If ($function -eq "Get-ImportGPOsAllBackups") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-ImportGPOsAllBackups {


    .SYNOPSIS
    Import all GPO backups from a full backup set.
    This will only gather GPO backups from the GPOFullBackup directory. 
    A full import can only be done using a full backup.
    > This will create a new GPO if the backup name does not currently exist.
    > This will overwrite settings in an existing GPO if the name matches a backup. 
    > This is to replicate all GPO backups in a new system.
    > This will NOT delete GPOs that are not associated with a backup. They will remain.
    

    .DESCRIPTION
    Set of GPOs exists already, and were all backed up, by default to:
    C:\Program Files\WindowsPowerShell\GPOFullBackups\
    Full backups are timestamped, which the user will choose from.
    This will overwrite existing GPOs, so a safety backup param is mandatory. `$true/`$false



    .EXAMPLE
    # Creates a full GPO safety backup before the full GPO import
    #---------------------------------------------
    > Get-ImportAllGPOBackups -safetyBackup `$true
    


    .EXAMPLE
    # DANGEROUS - Does not create a full GPO backup. Overwritten GPOs will not be saved.
    --------------------------------------------
    > Get-ImportAllGPOBackups -safetyBackup `$false
    
    

    .EXAMPLE
    # If a full GPO backup has been moved to the non-default location, and a backup is wanted.
    ---------------------------------------------------------------------------
    > Get-ImportAllGPOBackups -gpoBackupPath `"C:\gpobackups\`" -safetyBackup `$false
    



    Param(
        [Parameter(Mandatory = `$false)]
        [String] `$gpoBackupPath = "", #If backup path is not sent in.
        
        [Parameter(Mandatory = `$true)]
        [bool] `$safetyBackup
    ) #End Param-------------------------------`n`n
    
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-ImportGPOsAllBackups
        #-----
        #========================================
        If ($function -eq "Get-ImportGPOSingle") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-ImportGPOSingle {


    .SYNOPSIS
    This takes 2 GPOs. You can take an existing GPO, and create a new one; 
    or just use 2 existing GPOs. This then creates a backup of the source GPO
    and then imports all polices/preferences into the destination GPO. 
    The Parameters include the names of the 2 GPOs, if you want one of those 
    GPOs to be created here, and if you want to overwrite or combine the 
    Organizational Unit links of the first GPO, in the second GPO.


    .DESCRIPTION
    All Parameters are mandatory.
    GPO1 exists already, and will be backed up here.
    GPO2 has not been created: `$createNewGPO will be set to `$true when called. 
    GPO2 has already been created, `$createNewGPO will be set to `$false when called.
    Then the policy/preferences are imported from the GPO1 backup.
    

    .EXAMPLE
    # Target GPO that will be imported into, has already been created, 
      and we will add the old OUs to the new OUs.
    ---------------------------------------------------------------
    > Get-ImportGPOSingle -sourceGPOParam GPO1name -destGPOParam GPO2name -createNewGPO `$false -ouOverwrite `$false


    .EXAMPLE
    # Target GPO will be created here, and then backup settings will be 
      imported into the new GPO, and all OU's will be overwritten. Technically 
      in this example, the new GPO is empty, but this would apply if we import 
      into an existing GPO that has existing OUs already.
    ---------------------------------------------------------
    > Get-ImportGPOSingle -sourceGPOParam oldGPO -destGPOParam targetGPO -createNewGPO `$true -ouOverwrite `$true
    
    
    .EXAMPLE
    # Target GPO that will be imported into, has already been created, 
    `$null = Nothing will change with the OUs.
    -----------------------------------------------
    > Get-ImportGPOSingle -sourceGPOParam oldGPO -destGPOParam targetGPO -createNewGPO `$false -ouOverwrite `$null


    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = `$true)]
        [String] `$sourceGPOParam,
        
        [Parameter(Mandatory = `$true)] 
        [String] `$destGPOParam, # The name of existing destination GPO, or name-to-be

        [Parameter(Mandatory = `$true)] 
        [bool[]] `$createNewGPO, # Default to false, to not create a new GPO

        [Parameter(Mandatory = `$true)]
        [String] `$ouOverwrite
    ) #End Param-----------------------------------`n`n
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-ImportGPOSingle
        #-----
        #========================================
        If ($function -eq "Get-LinkedGPOs") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-LinkedGPOs {

    
    .SYNOPSIS
    Choose a target Organizational Unit, and view all linked GPOs to this OU


    .EXAMPLE
    Get-LinkedGPOs



    .EXAMPLE
    # View linked GPOs in terminal. This function will always default to terminal
    -------------------------------
    Get-LinkedGPOs -gridview `$false
    


    .EXAMPLE
    # View linked GPOs in gridview
    --------------------------------
    Get-LinkedGPOs -gridview `$true
    



    .OUTPUTS

    Target - ou=serveracademy,dc=widgetllc2,dc=internal
    #-----------------------------------------
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


    Param(
        [Parameter()]
        [bool]
        `$gridview
    ) # End Param-----------------------------------
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-LinkedGPOs
        #-----
        #========================================
        If ($function -eq "Get-LinkedOUsAll") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-LinkedOUsAll {


    .SYNOPSIS
    Find all Linked Organizational Units, and list the GPOs linked to them.


    .DESCRIPTION
    Returns only the Organizational Units with GPO Links.


    .EXAMPLE
    # Default module results displayed in Gridview
    -----------------
    > Get-LinkedOUsAll
    


    .EXAMPLE
    # Results only displayed on terminal.
    --------------------------------------
    > Get-LinkedOUsAll -gridview `$false


    .EXAMPLE
    # Results displayed in gridview and on terminal.
    ---------------------------------
    > Get-LinkedOUsAll -gridview `$true
    


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


    
    Param(
        [Parameter()]
        [bool]
        `$gridview # Defaults to terminal
    ) # End Param-----------------------------------
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-LinkedOUsAll
        #-----
        #========================================
        If ($function -eq "Get-LinkedOUsSpecific") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-LinkedOUsSpecific {


    .SYNOPSIS
    Find Linked Organizational Units, for a specific GPO
    The target gpo, -gpoName Parameter is mandatory. 


    .EXAMPLE
    # OU links for a target GPO displayed in gridview
    ----------------------------------------------------------------------
    > Get-LinkedOUsSpecific  -gridview `$true -gpoName `"fakeGPOwEverything`"
    


    .EXAMPLE
    # OU links for a target GPO displayed in terminal
    ------------------------------------------------------------------------
    > Get-LinkedOUsSpecific  -gridview `$false -gpoName `"fakeGPOwEverything`"
    


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


    Param(
        [Parameter()]
        [bool]
        `$gridview = `$true, #Default to gridview

        [Parameter(Mandatory = `$true)]
        [string]
        `$gpoName
    ) # End Param-----------------------------------
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-LinkedOUsSpecific
        #-----
        #========================================
        If ($function -eq "Get-SingleGPOname") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-SingleGPOname {


    .SYNOPSIS
    Many options need the user to choose a GPO(name) This is a single function to do that.

    .DESCRIPTION
    Simply returns a name of a chosen GPO to be used for other functions.
    Parameter is used to tell user what we are chosing the name for.

    .Example
    > Get-SingleGPOname -gpoUseStatement `"MERGE`"
    # Output:  Pick Which existing GPO to MERGE
    # This can be any string.


    .OUTPUTS
    abc_GPO123


    Param(
        [Parameter(Mandatory = `$true)]
        [string] 
        `$gpoUseStatement # String to print what the intention of the info request is for.
    ) # End Param-----------------------------------
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-SingleGPOname
        #-----
        #========================================
        If ($function -eq "Get-UnlinkedGPOs") {
    Write-Host -ForegroundColor Yellow ("
    Function Get-UnlinkedGPOs {

    
    .SYNOPSIS
    Discover all GPO policies, and indicate it the GPO has a linked status.
    
    
    .DESCRIPTION
    No Parameters. Simply returns GPO list and indicates the linked status
    
    
    .EXAMPLE
    > Get-UnlinkedGPOs
    
    
    .EXAMPLE
    > Get-UnlinkedGPOs | Out-Gridview
    
    
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
    
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Get-UnlinkedGPOs
        #-----
        #========================================
        If ($function -eq "Set-BackupAllGPOs") {
    Write-Host -ForegroundColor Yellow ("
    Function Set-BackupAllGPOs {


    .SYNOPSIS
    Create backups of all GPOs.
    The -encrypt Parameter is mandatory.


    .DESCRIPTION
    Uses default WindowsPowerShell Directory: C:\Program Files\WindowsPowerShell\
    Creates \GPOBackups directories in this location if they do not exist.
    User calls this function.
    GPO backups saved to: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\



    .EXAMPLE
    # All backups are Administrator encrypted
    -------------------------------
    > Set-BackupAllGPOs -encrypt `$true
    


    .EXAMPLE
    # All backups are not encrypted
    ---------------------------------
    > Set-BackupAllGPOs -encrypt `$false
    


    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = `$true)]
        [bool]
        `$encrypt
    ) #End Param-----------------------------------
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Set-BackupAllGPOs
        #-----
        #========================================
        If ($function -eq "Set-BackupSingleGPO") {
    Write-Host -ForegroundColor Yellow ("
    Function Set-BackupSingleGPO {


    .SYNOPSIS
    Create a backup of a single GPO.
    Includes both GPO policies and preferences, however if there are Domain 
    shared items such as files, they will not be copied automatically if this 
    import is targeted at an external GPO.


    .DESCRIPTION
    Uses default WindowsPowerShell Directory: C:\Program Files\WindowsPowerShell\
    Creates a \GPOdata\GPOBackups directory in this location if it does not exist.
    User calls this function and provides the name of the target GPO
    GPO backup saved to: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups\


    .EXAMPLE
    # Back up GPO xInstall 7zip and Administrator encrypt the backup
    ------------------------------------------------------------------
    > Set-BackupSingleGPO -sourceGPOParam `"xInstall 7zip`" -encrypt `$true
    

    

    Param(
        [Parameter(Mandatory = `$true)]
        [String]
        `$sourceGPOParam,

        [Parameter()]
        [String]
        `$timestampParam,

        [Parameter()]
        [bool]
        `$encrypt, 

        [Parameter()]
        [bool]
        `$fullBackup
    ) #End Param
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Set-BackupSingleGPO
        #-----
        #========================================
        If ($function -eq "Set-CreateGPOFromBackup") {
    Write-Host -ForegroundColor Yellow ("
    Function Set-CreateGPOFromBackup {


    .SYNOPSIS
    Similar to Get-ImportGPOSingle but this allows for GPOs that were imported and do not exist currently.
    Create a new GPO from a prior backup.
    This is an interactive function. Requires user input.
    GPO1 has been backed up, it either may exist currently, or just remain as a backup.
    This backup can be imported into GPO2, which is created here.
    GPO2 will have all of the policies, preferences, and links (if they exist)


    .DESCRIPTION
    Chose name of prior GPO backup from list.
    Create a new GPO Name, import that backup into new GPO
    All actions are done through the function, not a prior menu.


    .EXAMPLE
    > Set-CreateGPOFromBackup


    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Set-CreateGPOFromBackup
        #-----
        #========================================
        If ($function -eq "Set-DeleteSingleGPO") {
    Write-Host -ForegroundColor Yellow ("
    Function Set-DeleteSingleGPO {

    .SYNOPSIS
    This is an interactive function that requires user input
    This is just to delete a single GPO with prior information and warnings.
    GPO deletion is easy, but this includes safety to prevent unwanted deletion.


    .EXAMPLE
    # All actions, confirmations done through the function
    ----------------------
    > Set-DeleteSingleGPO
    

    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Set-DeleteSingleGPO
        #-----
        #========================================
        If ($function -eq "Set-GPOsCopy") {
    Write-Host -ForegroundColor Yellow ("
    Function Set-GPOsCopy {

        
    .SYNOPSIS
    Create a new GPO as a copy of an existing GPO
    GPO1 exists, and a backup of GPO1 will be created.
    Create GPO2, import all setting from GPO1 into GPO2
    GPO2 will have all of the policies, preferences, and links (if they exist)


    .DESCRIPTION
    Chose name of current GPO from list.
    Create a new GPO Name, import that backup into new GPO



    .EXAMPLE
    # Confirmation and choices can be done through the function.
    ------------------
    > Set-GPOsCopy
    


    .EXAMPLE
    # Add source and destination GPOs will bypass asking in the function.
    -------------------------------------------------------------
    > Set-GPOsCopy -sourceGPOparam `"gpo1A`" -destGPOparam `"gpo2B`"
    


    Param(
        [Parameter(Mandatory = `$false)]
        [String]
        `$sourceGPOparam,
        [Parameter(Mandatory = `$false)]
        [String]
        `$destGPOparam
    ) # End Param--------------------------------------
    
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Set-GPOsCopy
        #-----
        #========================================
        If ($function -eq "Set-GPOsOverwrite") {
    Write-Host -ForegroundColor Yellow ("
    Function Set-GPOsOverwrite {


    .SYNOPSIS
    Select an existing source GPO1 to copy full GPO config from.
    Select an exsiting destination GPO2 to overwrite the full GPO config with GPO1 


    .EXAMPLE
    # Choose target active GPOs directly through the module.
    --------------------
    > Set-GPOsOverwrite
    

    .EXAMPLE
    # State the target active GPOs through the function call. 
    ----------------------------------------------------------
    > Set-GPOsOverwrite -sourceGPOparam `"gpo1A`" -destGPOparam `"gpo2B`"
    

        
    Param(
        [Parameter(Mandatory = `$false)]
        [String]
        `$sourceGPOparam,

        [Parameter(Mandatory = `$false)]
        [String]
        `$destGPOparam
    ) # End Param--------------------------------------
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Set-GPOsOverwrite
        #-----
        #========================================
        If ($function -eq "Set-MergeGPOFromBackup") {
    Write-Host -ForegroundColor Yellow ("
    Function Set-MergeGPOFromBackup {

        
    .SYNOPSIS
    This is an interactive function, that requires user input.
    Similar to Get-ImportGPOSingle but this allows for GPO backups that were imported 
    and do not exist currently and it will create a new GPO from a prior backup.
    - GPO Backups should be placed here:
    `"C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups`"

    This also allows the user to pick a single GPO from a full backup set.
    This requires a `$true in the function's parameter

    GPO1 has been backed up, it either may exist currently, or just remain as a backup.
    This backup can be imported into GPO2, which is created here.
    GPO2 will have all of the policies, preferences, and links (if they exist)


    .DESCRIPTION
    Choose name of prior GPO backup from list.
    Choose existing GPO Name, import the backup into existing GPO


    .EXAMPLE
    > Set-MergeGPOFromBackup


    .EXAMPLE
    # Grab a single gpo, from a full backup
    --------------------------------------
    > Set-MergeGPOFromBackup -fullBackupParam `$true
    


    #===============================
    [CmdletBinding()]
    Param(
        # Indicate to import a single gpo, from the full backup set
        [Parameter()]
        [bool] `$fullBackupParam
    ) #End Param-------------------------------





    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Set-MergeGPOFromBackup
        #-----
        #========================================
        If ($function -eq "Set-NewEmptyGPO") {
    Write-Host -ForegroundColor Yellow ("
    Function Set-NewEmptyGPO {

        
    .SYNOPSIS
    Create a new GPO with no initial settings, with a user provided name and comment.


    .DESCRIPTION
    Input the name of a GPO
    This collects all settings from that GPO both Policies and Preferences
    Exports this settings to an HTML that can be viewed in any browser.


    .EXAMPLE
    # This will need user input in the function for GPO name etc.
    --------------------------
    > Set-NewEmptyGPO


    .EXAMPLE
    # This will create a new empty gpo with that name, assuming that name does not already exist as a GPO
    ------------------------------------------
    > Set-NewEmptyGPO -nameParam `"newGPOnameX`"
    


    Param(
        [Parameter()]
        [string]
        `$nameParam
    ) #End Param-----------------------------------
    
    ") # End Write-Host
        } # End If
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        #-----
        # End section Set-NewEmptyGPO
        #-----


} # End function Get-GPOFunctionsSummary

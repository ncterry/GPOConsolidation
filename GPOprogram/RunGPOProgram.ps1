<###########################################################################
# This script, "RunGPOProgram.ps1" depends on if "InstallGPOFunctionsModule.ps1" has been run first.
# If "InstallGPOFunctionsModule.ps1" has been executed, just that first time, you can then execute
#     "RunGPOProgram.ps1" any time after that.
#
# From PowerShell 
#     > .\RunGPOProgram.ps1
#
# Or right click on "RunGPOProgram.ps1" and click:
#     "Run with PowerShell"
#
# ALSO - once "InstallGPOFunctionsModule.ps1" has been run, and GPOFunctionsModule has been 
# installed in the PowerShell cache, you can then copy the "RunGPOProgram - Shortcut" anywhere
# on the machine. For example, once "GPOFunctionsModule" has been installed, 
#     Right click on "RunGPOProgram - Shortcut"
#     Click:  "Pin to Taskbar"
# 
#     Now if you click on this Taskbar icon, the GPOFunctionsModule will run anytime.
# 
# 
# Within the 'GPOFunctionsModule' directory, the 'GPOProgram' can be run from 
# any location on the machine; however, regardless of where it is executed from, 
# the default location that the 'GPOProgram' will always use for data, reports, 
# backups etc., is the 'WindowsPowerShell' location that the program copies 
# itself to during execution:
# 
#   'C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule'
# ###########################################################################
#
#
# This GPOprogram is directly tied to the GPOFunctionsModule
# Inside the GPOFunctionsModule directory is the "GPOFunctionsModule.psm1"
# This only works once the GPOFunctionsModule has been placed=copied=installed into a PowerShell Directory
# If the Copy-Item above does not work, such as user has no admin privs, it cant import then.
# Import uses the instructions on that local "GPOFunctionsModule.psm1"
#>
Import-Module GPOFunctionsModule -Force -Verbose


function Set-MainMenu
{
    Write-Host("
|======================================================================|
|==================--- Group Policy Consolidation ---==================|
|======================================================================|") # END WRITE-HOST
    #
    Write-Host("`n Selections:
------------------------------------------------------------------------`n")
    #
    Write-Host -ForegroundColor Yellow ("   1) System\Domain Info `t`t`t`tEnter: 1`n")
    Write-Host -ForegroundColor Yellow ("   2) Active GPO Info `t`t`t`t`tEnter: 2`n")
    Write-Host -ForegroundColor Yellow ("   3) Active GPO Org. Unit Links  `t`t`tEnter: 3`n")
    Write-Host -ForegroundColor Yellow ("   4) Active GPO Registry Values `t`t`tEnter: 4`n")
    Write-Host -ForegroundColor Yellow ("   5) Create GPOs `t`t`t`t`tEnter: 5`n")
    Write-Host -ForegroundColor Yellow ("   6) Backup GPOs `t`t`t`t`tEnter: 6`n")
    Write-Host -ForegroundColor Yellow ("   7) Import GPOs `t`t`t`t`tEnter: 7`n")
    Write-Host -ForegroundColor Yellow ("   8) View GPOFunctionsModule Functions `t`tEnter: 8`n")
     #
    Write-Host("------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   README - Program Summary `t`t`t`tEnter: `'readme`'`n")
    Write-Host("------------------------------------------------------------------------")
    Write-Host -ForegroundColor Yellow ("`n   HELP   - Enter the number + h  (1h, 2h, 3h...) `tEnter: `'#h`'`n")
    Write-Host -ForegroundColor Red ("   QUIT   - End the GPO Program `t`t`tEnter: `'quit`'`n") 
    Write-Host("------------------------------------------------------------------------")
} # End function Set-MainMenu


#--------------------------
# Continuing do loop unless user quits
# Other menus/functions will resort back here when they are completed.
$Global:quit = ""   # Var allows for a full session quit from sub menus.
do
{
    If ($Global:quit -eq "quit") {break}
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host        # Clear terminal 
    Set-MainMenu      # Call local function. Print menu to screen
    $choice = Read-Host "`nEnter Choice"  #Ask user for menu choice
    Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # The screen can leave residual text. This overwrites before clear
    Clear-Host
    $choice = $choice -replace '\s', ''   #In case user enters spaces
    $choice = $choice.ToLower()           #In case user uses any capitol letters.

    switch ($choice)  # If menu options are chosen correctly.
    {
        # Option 1 - System\Domain Information-------------
        '1' 
        {
            Write-Host "1) You chose To view the System\Domain Information"
            # Assumes execution of .\RunGPOProgram.ps1 was done from inside \GPOProgam
            .\Menu\1_GPOsDomainMenu.ps1    # Execute GPO Search Menu script.
            If ($Global:quit -eq "quit") {break}
            

        }#END option 1-------------------------------------
        #--------------------------------------------------
        '1h' # Help/Information for 1
        {
# Write-Host ==> Pressed left for formatting; Leave on the left.
Write-Host -ForegroundColor Yellow ("
----------
1) System\Domain Information
----------
Several options that gather basic information such as the Domain,  
Domain Controller, and network tests related to the System and 
Domain that contain the Group Policy Objects that are targeted 
in this GPOFunctionModule") # END WRITE-HOST

            Pause

        } # End 1h-----------------------------------------
        #--------------------------------------------------
        # Option 2 - Current GPOs--------------------------
        '2' 
        {
            Write-Host "1) You chose To view the current GPOs"
            # Assumes execution of .\RunGPOProgram.ps1 was done from inside \GPOProgam
            .\Menu\2_GPOsInfoMenu.ps1 #Execute GPO Search Menu script.
            If ($Global:quit -eq "quit") {break}


        }#END option 2-----------------------------------------------
        #--------------------------------------------------
        '2h' # Help/Information for 2
        {
# Write-Host ==> Pressed left for formatting; Leave on the left.         
Write-Host -ForegroundColor Yellow ("
----------
2) Information on Current GPOs
----------
This section allows the user to gather and view information about 
local Group Policy Objects such as a list of all GPOs, the summary 
information for each GPO, and an in-depth, full GPO analysis for 
target GPO's selected by the user.") # END WRITE-HOST

            Pause
        } # End 2h-----------------------------------------
        #--------------------------------------------------
        # Option 3 - Organizational Units Linked to GPOs-------------
        '3' 
        {
            # Assumes execution of .\RunGPOProgram.ps1 was done from inside \GPOProgam
            .\Menu\3_GPOs_OULinksMenu.ps1
            If ($Global:quit -eq "quit") {break}
            

        }#END option 3------------------------------------- 
        #--------------------------------------------------
        '3h' # Help/Information for 3
        {
# Write-Host ==> Pressed left for formatting; Leave on the left.
Write-Host -ForegroundColor Yellow ("
----------
3) Organizational Units and GPO Links
----------
Standard Information About Local GPOs and assocated links to 
Organizational Units in the Domain.

The options offer the results in both terminal, and gridview displays.
----------

`t1) View a collection of all Organizational Units, and their sequentially 
`t   linked Group Policy Objects to each OU.

`t2) View all Organizational Units that are linked to a user selected GPO `n`n`n") # END WRITE-HOST

            Pause
        } # End 3h-----------------------------------------
        #--------------------------------------------------
        # Option 4 - GPO Registry Values-------------------
        '4' 
        {
            Write-Host ("n`nGather Registry Values for a Target GPO") # END WRITE-HOST
            # Assumes execution of .\RunGPOProgram.ps1 was done from inside \GPOProgam
            .\Menu\4_GPOsRegistryValuesMenu.ps1
            If ($Global:quit -eq "quit") {break}


        }#END option 4-------------------------------------   
        #--------------------------------------------------
        '4h' # Help/Information for 4
        {
# Write-Host ==> Pressed left for formatting; Leave on the left.
Write-Host -ForegroundColor Yellow ("
----------
4) Gather Registry Values for a GPO
----------
Gather Registry Values for a Target GPO. These can be a full collection 
of the target GPO's registry, or more selective values in targeted 
registry address that are associated with this GPO.") # END WRITE-HOST

            Pause
        } # End 4h   -----------------------------------------  
        #--------------------------------------------------
        # Option 5 - Create New GPOs-----------------------
        '5' 
        {
            # Assumes execution of .\RunGPOProgram.ps1 was done from inside \GPOProgam
            .\Menu\5_GPOsCreateMenu.ps1
            If ($Global:quit -eq "quit") {break}


        }#END option 5-------------------------------------
        #--------------------------------------------------
        '5h' # Help/Information for 5
        {
# Write-Host ==> Pressed left for formatting; Leave on the left.
Write-Host -ForegroundColor Yellow ("
----------
5) Create GPOs
----------
Several options to create Group Policy Objects. Ranging from a new, 
blank GPO; creating a copy of an existing GPO; and creating a copy of a GPO 
based on importing the settings from a prior backup. 

If a new GPO is based on another, either existing or backup, all settings 
of the new GPO such as Policies, Preferences, and Organizational Unit links 
will all be imported. This is a focus of this module, as many existing 
options for GPO copies/imports will not capture the GPO's preferences, and
links. This full GPO import does require that the prior backup was done through 
the GPOFunctionsModule functions, as stated, default Windows\PowerShell GPO backups 
and imports do not fully account for GPO preferences, and links. 

This section also offers an opening of the Group Policy Management Console, 
and the option to safely delete a GPO.") # END WRITE-HOST

            Pause
        } # End 5h-----------------------------------------
        #--------------------------------------------------
        # Option 6 - Backup GPOs---------------------------
        '6' 
        {
            # Assumes execution of .\RunGPOProgram.ps1 was done from inside \GPOProgam
            .\Menu\6_GPOsBackupMenu.ps1
            If ($Global:quit -eq "quit") {break}


        }#END option 6-------------------------------------
        #--------------------------------------------------
        '6h' # Help/Information for 6
        {
# Write-Host ==> Pressed left for formatting Leave on the left.
Write-Host -ForegroundColor Yellow ("
----------
6) Back-up GPOs
----------
This section offers the ability to fully back up an existing GPO, or all GPOs.
These backups will save the GPO's Polices, Preferences, and Organizational Unit 
links, where a standard Windows GPO backup will not save the OU links. 

Using the backups created through the GPOFunctionsModule, any future import, 
also using the GPOFunctionsModule, will bring back a GPOs policies, 
preferences, and OU links.

Backups done through the GPOFunctionsModule will also save a full HTML settings report
next to the backup which can be viewed for future inquiries of a previous GPO backup.
All backups are time-stamped. 

There are two sub-directories associated with this module that are created in real-time
when an administrator first creates these GPO backups with the GPOFunctionsModule:

> C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOBackups
> C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\GPOdata\GPOFullBackup

Individual GPO backups are stored in \GPOBackups, while a full system GPO backup (every-gpo)
is stored in \GPOFullBackup. This is to maintain system segregation if a full GPO import
is to be done, it must come from a timestamped, full prior backup, while specific GPOs can 
be backed-up and imported individually.


An option also exists here to view all backups that have been created through the
GPOFunctions Module.") # END WRITE-HOST

            Pause
        } # End 6h-----------------------------------------
        #--------------------------------------------------
        # Option 7 - Merge GPO Policies/Preferences with another-----------------------
        '7' 
        {
            # Assumes execution of .\RunGPOProgram.ps1 was done from inside \GPOProgam
            .\Menu\7_GPOsImportMenu.ps1
            If ($Global:quit -eq "quit") {break}


        }#END option 7-------------------------------------
        #--------------------------------------------------
        '7h' # Help/Information for 7
        {
# Write-Host ==> Pressed left for formatting; Leave on the left.
Write-Host -ForegroundColor Yellow ("
----------
7) Import GPOs
----------
This section offers the ability to copy an existing GPO; overwrite an existing GPO
with another existing GPO; import settings from a backup GPO into an existing GPO; and
create a new GPO by importing settings from a backup.

This also offers an option to take the full GPOFunctionsModule backup repository, and 
import them all. This will only import from a GPO's most recent backup. If a GPO exists
currently, the program will overwrite with the most recent backup, and if a GPO does not
exist, the system will create a new GPO. ") # END WRITE-HOST

            Pause
        } # End 7h-----------------------------------------
        #--------------------------------------------------
        # Option 8 - View all functions created for GPOFunctionsModule-----------------------
        '8' 
        {
            # Assumes execution of .\RunGPOProgram.ps1 was done from inside \GPOProgam
            $functionPath = "C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule"
            $functionList = Get-ChildItem "$functionPath\functions\" -Force -Name
            do {
              $pick, $choiceName = ""
              Write-Host("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n") # Terminal leaves residual text. This overwrites before clear
              Clear-Host


              do {
                  $count=0
                  Clear-Host
                  Write-Host -ForegroundColor Yellow ("-------------`nGPOFunctionsModule Functions `n-------------`nThese functions are built to be used by the GPOProgram, but nearly all can be used independantly. `nBy running this GPOProgram, these functions have been imported into the WindowsPowerShell module/memory cache. `nThis section is to provide details on what actions are being taken, while in the GPOProgram:`n-------------")
                  ForEach ($function in $functionList) {
                    $count++
                    # TrimEnd() ends up trimming too much, we need to be very selective
                    $function = $function.Substring(0, ($function).IndexOf(".ps1"))
                    Write-Host("$count`) $function")
                  } # End ForEach-------------------------------
      
                  
                  Write-Host -ForegroundColor Yellow ("-------------`nEnter 0 to Return the Prior Menu `nPick which GPOFunctionModule function to view the help-summary on:")
                  $pick = Read-Host("`(1 - $count`)")
                  If ($pick -eq 0) {break}
              } until($pick -in 1..$count)
              

              If ($Global:quit -eq "quit") {break}
              If ($pick -eq 0) {
                Clear-Host
                break
              # Account for a single value list (not possible, but safety)
              } ElseIf (($pick -eq 1) -AND ($count -eq 1)) {
                $choiceName = $functionList
                $choiceName = $choiceName.Substring(0, ($choiceName).IndexOf(".ps1"))
              } ElseIf (($pick -in 1..$count) -AND ($count -gt 1)) {
                $choiceName = $functionList[$pick - 1]
                $choiceName = $choiceName.Substring(0, ($choiceName).IndexOf(".ps1"))
              } # End If/ElseIf


              Clear-Host
              Get-GPOFunctionsSummary -function $choiceName
              Pause
          } until($pick -eq 0)
            
        }#END option 8-------------------------------------
        #--------------------------------------------------
        '8h' # Help/Information for 8
        {
# Write-Host ==> Pressed left for formatting; Leave on the left.
Write-Host -ForegroundColor Yellow ("
----------
8) Get-Help GPOFunctionsModule Functions
----------
This section offers the ability to view the individual functions help sections. These 
functions have been imported into the WindowsPowerShell cache, and outside of this 
GPOProgram, their help sections can be viewed with the standard PowerShell help:

    > Get-Help <functionName> -Full
    > Get-Help <functionName> -Synopsis
    > Get-Help <functionName> -Examples
    
However, while using the GPOProgram in real-time, these PowerShell Get-Help functions
can overwrite, and simply be messy in the terminal. This section has just re-created the
Get-Help sections for each GPOFunctionsModule function, which can then be individually
searched for, and displayed while still using the GPOProgram.
    ") # END WRITE-HOST

            Pause
        } # End 8h-----------------------------------------
        #--------------------------------------------------
        'readme' # Help/Information for main
        {
# Write-Host ==> Pressed left for formatting; Leave on the left.
Write-Host -ForegroundColor Yellow ("
-------------------------------------------------
README - GPOFunctionsModule and GPOProgam Summary
-------------------------------------------------

  This is a built around a PowerShell Module implementation.
  The 'GPOProgram' focuses on local Group Policy Objects, with the primary goal 
  to create/merge/import GPOs with full settings. 


  The standard Windows backup/import etc., functions associated with 
  PowerShell, will backup/import GPO Policies, but not GPO Preferences. Prior 
  Windows GPO backups/imports will also not re-link new GPOs to the 
  Organizational Units associated with the original GPO. This program, and 
  associated module was built to fully re-create all aspects of a Group Policy Object.


  ------------------------------------------------------------------
  The 'GPOFunctionsModule' was built to accomplish all of this, and most of the 
  associated functions can be run independantly once they are imported. 
  These all have related instructions that can be viewed with:

    > Get-Help <function name> -full


  Step1: 
  Install the GPOFunctionsModule
  Once downloaded, or cloned, then move to the downloaded `"GPOFunctionsModule`" directory.
  From PowerShell:    
  	  > .\InstallGPOFunctionsModule.ps1
  

  This is the installation file for the entire module.
  Run this and the entire GPOFunctionsModule will be installed as a PowerShell module.
  You can also right-click on `"InstallGPOFunctionsModule.ps1`" and click:
    `"Run with Powershell`"


  You only need to run this once, and it will be installed. 
  Once installed, you can run functions individually or run the `"GPOProgram`".



  All functions associated were built to be run primarily from the 'GPOProgram'.
  Once `"InstallGPOFunctionsModule.ps1`" has been installed,
  From the directory location:       .....\GPOFunctionsModule\GPOProgram\
  From PowerShell:
      > .\RunGPOProgram.ps1

      Or you can right click on `"RunGPOProgram.ps1`" and click `"Run with PowerShell`"


  ALSO - once `"InstallGPOFunctionsModule.ps1`" has been run, and GPOFunctionsModule has been 
  installed in the PowerShell cache, you can then copy the `"RunGPOProgram - Shortcut`" anywhere
  on the machine. For example, once `"GPOFunctionsModule`" has been installed, 
      Right click on  `"RunGPOProgram - Shortcut`"
      Click:  `"Pin to Taskbar`"


  Now if you click on this Taskbar icon, the GPOFunctionsModule will run anytime.
  However, regardless of where it is executed from, the default location that 
  the 'GPOProgram' will always use for data, reports, backups etc., is the 
  'WindowsPowerShell' location that the program copies itself to during execution:

    'C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule'



  ------------------------------------------------------------------
  This Module setup can be done automatically by running the 'InstallGPOFunctionsModule.ps1'.
  As an Administrator in PowerShell:


	1) Move to where the directory was downloaded to 'cd ....\GPOFunctionsModule\'
	2) Once at the \GPOFunctionsModule location, from PowerShell Terminal run:

	  > .\InstallGPOFunctionsModule.ps1

  Or you can right click on `"InstallGPOFunctionsModule.ps1`" and click `"Run with PowerShell`"


	3) This will automatically:
		a) Copy the 'GPOFunctionsModule' into 'C:\Program Files\WindowsPowerShell\Modules'
		b) Import the modules into the PowerShell memory cache.
		c) This only needs to be done 1-time, when you first download GPOFunctionsModule



  As stated, the 'GPFunctionsModule' was built to be used through the 'GPOProgram'; but 
  most of these functions can be run individually IF they have been installed/imported into 
  the PowerShell Module cache. This can be done in two ways:

  1) Easiest is to follow the instructions above.


  OR


  2) Standard PowerShell Module Installation:
  ------------------------------------------------------------------
  2a) First action is to copy the 'GPOFunctionsModule' directory to:

    'C:\Program Files\WindowsPowerShell\Modules'




  2b) This can be done through PowerShell.
      First, move TO the downloaded \GPOFunctionsModule location such as, 
      \Desktop, \Downloads, etc., then copy the directory to the target:

    > Copy-Item .\GPOFunctionsModule\ -Destination `"C:\Program Files\WindowsPowerShell\Modules`" -Force -Recurse




  2c) Then from PowerShell, execute the target module import:

    > Import-Module -Name `"GPOFunctionsModule`"




  Now all 'GPOFunctionsModule' functions will be active.
  It is still recommended to operate 'GPOFunctionsModule' through the:

    > .\RunGPOProgram.ps1






  To Remove the GPOFunctionsModule:
  ------------------------------------------------------------------
  NOTE - There may be an error in PowerShell if you have this directory open 
  in Windows Finder while you try to execute this Remove-Item:

    > Remove-Item -Path `"C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\`" -Force -Recurse




  Once you have removed the directory, then remove the module from the memory cache: 

    > Remove-Module -Name `"GPOFunctionsModule`"
 ") # END WRITE-HOST

            Pause
        } # End readme-----------------------------------------
        #--------------------------------------------------
        #------------------------  
        'quit' 
        {
            $Global:quit = "quit"
            $choice = "q"
        } # End quit       
    }# END Switch

    Set-MainMenu #Refresh main menu

} until (($choice -eq '0')) #END do Loop

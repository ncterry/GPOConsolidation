--------------------------
README - GPOProgam Summary
--------------------------

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



  All functions associated were built to be run primarily from the 'GPOProgram'.
  From the directory location:       ..\GPOFunctionsModule\GPOProgram\
  The program can be run by:

    > .\RunGPOProgram.ps1



  Within the 'GPOFunctionsModule' directory, the 'GPOProgram' can be run from 
  any location on the machine; however, regardless of where it is executed from, 
  the default location that the 'GPOProgram' will always use for data, reports, 
  backups etc., is the 'WindowsPowerShell' location that the program copies 
  itself to during execution:

    'C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule'



  ------------------------------------------------------------------
  This Module setup can be done automatically by running the 'GPOprogram'.
  As an Administrator in PowerShell:

	1) Move to where the directory was downloaded to 'cd ..\GPOFunctionsModule\GPOprogram\'
	2) Once at the \GPOProgram location, from PowerShell Terminal run:

	> .\RunGPOProgram.ps1



	3) This will automatically:
		a) Copy the 'GPOFunctionsModule' into 'C:\Program Files\WindowsPowerShell\Modules'
		b) Import the modules into the PowerShell memory cache.
		c) Execute the 'GPOProgram' as it was intended.





  As stated, the 'GPFunctionsModule' was built to be used through the 'GPOProgram'; but 
  most of these functions can be run individually if they have been installed/imported into 
  the PowerShell Module cache. This can be done in two ways:

  1) Easiest is to follow the instructions above to execute the 'GPOProgram'
     This will bring all functions into operation, and also run the GPOProgram.




  2) Standard PowerShell Module Installation:
  ------------------------------------------------------------------
  2a) First action is to copy the 'GPOFunctionsModule' directory to:

    'C:\Program Files\WindowsPowerShell\Modules'




  2b) This can be done through PowerShell.
      First, move TO the downloaded \GPOFunctionsModule location such as, 
      \Desktop, \Downloads, etc., then copy the directory to the target:

    > Copy-Item .\GPOFunctionsModule\ -Destination "C:\Program Files\WindowsPowerShell\Modules" -Force -Recurse




  2c) Then from PowerShell, execute the target module import:

    > Import-Module -Name "GPOFunctionsModule"




  Now all 'GPOFunctionsModule' functions will be active.
  It is still recommended to operate 'GPOFunctionsModule' through the:

    > .\RunGPOProgram.ps1






  To Remove the GPOFunctionsModule:
  ------------------------------------------------------------------
  NOTE - There may be an error in PowerShell if you have this directory open 
  in Windows Finder while you try to execute this Remove-Item:

    > Remove-Item -Path "C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\" -Force -Recurse





  Once you have removed the directory, then remove the module from the memory cache: 

    > $Module = Get-Module GPOFunctionsModule

    > Remove-Module $Module.Name

    > Remove-Item $Module.ModuleBase -Recurse -Force

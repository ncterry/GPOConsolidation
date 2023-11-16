
#-----------------------------------------------------------------------------
<#
.AUTHOR
    Nate Terry

.SYNOPSIS
    A module used for Group Policy Object consolidation, focused on backups, copies, and merging. 
    Standard Group Policy functions and commands associated with PowerShell will not do a full 
    copy of GPOs. The GPO's policies, preferences, and Organizational Links from an original GPO 
    cannot all be saved and moved to another GPO without tedious, and extensive PowerShell commands. 
    This GPOFunctionsModule has many related functions that were built for the 
    subdirectory/program "GPOProgram". This PSM1 file allows for the functions in GPOFunctionsModule 
    to be imported into the PowerShell memory for module-based, independant use.

.DESCRIPTION
    When this module is imported, the functions are loaded using dot sourcing below. 
    Primary Module imports are done here to apply to all related sub-functions. 
    This  .psm1(module) cannot be executed directly as a script, it will only be called 
    when importing this module.


    1) Find local module pathways:  
        > $env: $PSModulePath


    2) Move this "\GPOFunctionsModule" to one of those module pathways.
        By default, .\RunGPOProgram will create\move the program, and data will always be saved to:
        C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule


    3) Now Import the module:  
        > Import-Module "GPOFunctionsModule" -Force -Verbose


    This can be done seperately, but is built to be called just by executing the "GPOprogram"
        > .\InstallGPOFunctionsModule.ps1


    Calling .\RunGPOProgram.ps1 from the \GPOProgram directory will then run the GPOProgram,
	but only once the GPOFunctionsModule has been installed. 
#>


#-----------------------------------------------------------------------------
# Needed for other sub-functions, so imported here from the .psm1 
Import-Module GroupPolicy       #Remote Server Administration Tools must have be installed
Import-Module ActiveDirectory   #Remote Server Administration Tools must have be installed


# Get the path to the function files. $PSScriptRoot = Script path
# $PSScriptRoot only works by executing the script. Selective execution(F8) will not be successful.
# This is built to be an imported Windows PowerShell script.
# The default location will be in: C:\Program Files\WindowsPowerShell\Modules\GPOFunctionsModule\
# This .psm1 should be in the GPOFunctionsModule directory.
# Used next to import the sub-functions
$functionPath = $PSScriptRoot + "\functions\"


# Get a list of all the function file names
$functionList = Get-ChildItem -Path $functionPath -Name


# Loop over all of the files and dot source them into system memory
# dot in for loop = keep everything found in memory i.e. dot-sourcing
ForEach ($function in $functionList) {
    . ($functionPath + $function)
}#End ForEach

#-----------------------------------------------------------------------------

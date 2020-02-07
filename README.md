# Introduction 
This is a Template project to create new CDS/D365 Solution leveraging a lighweight framework and CI/CD

# Getting Started
1.	Right click on Start and select Windows PowerShell (Admin)
1.	Copy and Paste the following lines of code into the PowerShell window :   
*Set-ExecutionPolicy Unrestricted -Force*  
*(Invoke-WebRequest https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/master/Provision.ps1 -UseBasicParsing:$true).Content | Out-File .\Provision.ps1*  
*.\Provision.ps1*
1.	Follow the Instructions


[For more details go through the Getting started guide](https://github.com/dylanhaskins/PowerPlatformCICD/wiki/)

# Optional Steps
1.  Update Plugins and Workflows Projects Namespace and Assembly Names in Properties
1.	Update Assembly names in Solutions/map.xml to match above change
1.	Build Solution
1.  Commit and Sync

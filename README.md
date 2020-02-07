# Introduction 
This is a Template project to create new CDS/D365 Solution leveraging a lighweight framework and CI/CD

# Getting Started
1.  Download  the [Provision.ps1](https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/master/Provision.ps1) PowerShell Script (Right-Click -> Save Link As / Save Target As)
1.	Open Windows Explorer to the location you downloaded Provision.ps1
1.	Right Click on Provision.ps1 and select Properties
1.	Tick the "Unblock" tickbox and click OK
1.	Right click on Start and select Windows PowerShell (Admin)
1.	Type "Set-ExecutionPolicy Unrestricted -Force" and press Enter
1.	Navigate to the location where you downloaded Provision.ps1 and type .\Provision.ps1 and press Enter
1.	Follow the Instructions


[For more details go through the Getting started guide](https://github.com/dylanhaskins/PowerPlatformCICD/wiki/)

# Optional Steps
1.  Update Plugins and Workflows Projects Namespace and Assembly Names in Properties
1.	Update Assembly names in Solutions/map.xml to match above change
1.	Build Solution
1.  Commit and Sync

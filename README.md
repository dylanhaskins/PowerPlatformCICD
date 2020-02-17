# PowerPlatformCICD 
This is a Template project to create new CDS/D365 Solution leveraging a lighweight framework and CI/CD


## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 


## Installation
1.	Right click on Start and select Windows PowerShell (Admin)
1.	Copy and Paste the following lines of code into the PowerShell window :   
*Set-ExecutionPolicy Unrestricted -Force*  
*(Invoke-WebRequest https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/master/Provision.ps1 -UseBasicParsing:$true).Content | Out-File .\Provision.ps1*  
*.\Provision.ps1*
1.	Press Enter
1.	Follow the Instructions


## Optional Steps
1.  Update Plugins and Workflows Projects Namespace and Assembly Names in Properties
1.	Update Assembly names in Solutions/map.xml to match above change
1.	Build Solution
1.  Commit and Sync


## Usage

[For more details go through the Getting started guide](https://github.com/dylanhaskins/PowerPlatformCICD/wiki/)


# Contributing
1. Fork it!
1. Create your feature branch: git checkout -b my-new-feature
1. Commit your changes: git commit -am 'Add some feature'
1. Push to the branch: git push origin my-new-feature
1. Submit a pull request


## Authors

* [Dylan Haskins](https://github.com/dylanhaskins)
* [Eugene van Staden](https://github.com/eugenevanstaaden)

See also the list of [contributors](https://github.com/dylanhaskins/PowerPlatformCICD/graphs/contributors) who participated in this project.







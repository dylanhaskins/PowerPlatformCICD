# Introduction 
This is a Template project to create new CDS/D365 Solution leveraging a lighweight framework and CI/CD

# Getting Started
1.  Download and **Run** the [Provision.ps1](https://github.com/dylanhaskins/PowerPlatformCICD/raw/master/Provision.ps1) PowerShell Script (Right-Click -> Save Link As)

# Provisioning Steps

>Before you start ensure you have the following set up:
>1. You will also need to have an Azure DevOps organisation to use, if you don't have one, please create one at https://dev.azure.com
>1. You will need a Power Platform tenant, if you don't have one, please create one at https://powerapps.microsoft.com/


To kick start this process, just run the Provision.ps1 script

`PS C:\dev> .\Provision.ps1`

![Step 1](https://github.com/dylanhaskins/PowerPlatformCICD/tree/master/readme/step1.png)

This script will install all the Pre-Requisites (git and Azure CLI)

Once this is done you need to add the name of your Azure DevOps instance

`Enter the name of your Azure DevOps Organization (https://dev.azure.com/<Name>):  `

![Login](https://github.com/dylanhaskins/PowerPlatformCICD/tree/master/readme/login.png)

After logging in and the script picks up your details you can select or create a new project.

`Would you like to [C]reate a new Project or [S]elect and existing one (Default [S]):`  

We will create a new one called **demo1**
`Would you like to [C]reate a new Project or [S]elect and existing one (Default [S]): C`

`Please enter the Name of the Project you wish to Create: demo1   `

Our project is now set up

![demo project](https://github.com/dylanhaskins/PowerPlatformCICD/tree/master/readme/project.png)

and the next step we will set the name of our repo, which we will call **demorepo**

`Enter the name for the Repository you wish to Create: demorepo` 

The script creates the new repo and clone the latest version of this template

![repo](https://github.com/dylanhaskins/PowerPlatformCICD/tree/master/readme/repo.png)

Now things are getting exciting. In the next step we will connect to our CDS/365 instance:

`Press Enter to Connect to your CDS / D365 Tenant or [Q]uit:`

![login-d365](https://github.com/dylanhaskins/PowerPlatformCICD/tree/master/readme/login-365.png)

Once connected you need to select the instance you want to connet to

`Select CRM Organization by index number:`


And now you can select either an existing solution in this instance, or create a new one. We will now create a new one called **Demo1**

`---- Please Select you Development Environment ------ `


![dev instance](https://github.com/dylanhaskins/PowerPlatformCICD/tree/master/readme/dev-instance.png)


Then select your staging environment:

`---- Please Select your Deployment Staging (CI/CD) Environment ------`

Once this is done the following happens:
1. The new solution gets created in your dev environment
1. The solution is exported and extracted into your local source and a commit is made to your repo
1. A default build is created

![dev instance](https://github.com/dylanhaskins/PowerPlatformCICD/tree/master/readme/build.png)

1. A default release definition is created
1. Library set per environment, Dev and Staging

![library](https://github.com/dylanhaskins/PowerPlatformCICD/tree/master/readme/library.png)



# Tools used
1. [spkl task runner](https://github.com/scottdurow/SparkleXrm/wiki/spkl) - just becasue its the best thing to have in a project 
1. [XrmContext](https://github.com/delegateas/XrmContext) for earlybound -.net classes  
1. [XrmDefinitelyTypes](https://github.com/delegateas/XrmDefinitelyTyped) to generate TypeScript declaration files 
1. [Microsoft.Xrm.DevOps.Data](https://github.com/abvogel/Microsoft.Xrm.DevOps.Data) - generate filtered data compatible with the Configuration Data Migration Tool and perfect to automate your Power Apps Portals deployments


# Optional Steps
1.  Update Plugins and Workflows Projects Namespace and Assembly Names in Properties
1.	Update Assembly names in Solutions/map.xml to match above change
1.  Configure spkl.json mapping for Plugins and Webresources
1.	Build Solution
1.  Commit and Sync


Set-ArmOutput.ps1
Execute after a ARM deployment step

Provide a name for the variable for the output variable which will contain the outputs section of the current deployment object in string format
eg. armoutputs

and then passing it as argument
-ARMOutput '$(armoutputs)'

sample from ARM deployment logs:
2020-06-17T01:48:57.4675714Z Deployment name is azuredeploy-20200617-014853-025e
2020-06-17T01:49:40.3663056Z Updated output variable 'armoutputs', which contains the outputs section of the current deployment object in string format.

sample from this script logs:
2020-06-17T01:49:41.6249068Z Added Azure DevOps variable 'functionAppResourceId' ('string') with value '/subscriptions/adc4ec0b-47ca-4206-be81-88c98f12fd76/resourceGroups/SampleResourceGroupName/providers/Microsoft.Web/sites/azurefunctionappname'
2020-06-17T01:49:41.6264399Z Added Azure DevOps variable 'functionAppHostname' ('string') with value 'azurefunctionappname.azurewebsites.net'
2020-06-17T01:49:41.6277533Z Added Azure DevOps variable 'functionAppName' ('string') with value 'azurefunctionappname'
2020-06-17T01:49:41.6291923Z Added Azure DevOps variable 'functionPrincipalId' ('string') with value '494f9d45-b75d-4866-a755-9238b0767b9a'

Variables to be used in follow up tasks


for more information
https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/AzureResourceManagerTemplateDeploymentV3#deployment-outputs


GetAccessToken.bat
1. Setup Service Principal for the pipeline as a new Application User in the target Dynamics instance
2. Assign System Admin role to this new Application User.
3. Ensure this Service Principal (registered as Enterprise Application in Azure AD) and that required Permissions have been assigned, ie. 
Windows Azure Active Directory with Read/Write permissions

This script will retrieve an Access Token against the target Dynamics instance
This Access Token is used in subsequent script.

sample from logs:
2020-06-17T01:56:19.5909680Z D:\a\r1\a\_MyProject\drop\ARM>set resource=https://MyOrgName.crm6.dynamics.com 
2020-06-17T01:56:19.5912696Z D:\a\r1\a\_MyProject\drop\ARM>set tokenName=d365AccessToken 

GetFunctionHostKey.bat
This script takes the Azure Resource Id for Azure Function and return the default host key
This key is used to update the webhook address and host key for a registered Service Endpoint

sample from logs:
2020-06-17T01:55:41.0381633Z D:\a\r1\a>FOR /F "tokens=* USEBACKQ" %F IN (`CALL az rest --method post --uri "https://management.azure.com/subscriptions/adc4ec0b-47ca-4206-be81-88c98f12fd76/resourceGroups/SampleResourceGroupName/providers/Microsoft.Web/sites/azurefunctionappname/functions/AccountWebhook/listkeys ?api-version=2018-02-01" --output tsv`) DO (SET apikey=%F ) 
2020-06-17T01:55:45.5677136Z D:\a\r1\a>(SET apikey=LuoAzyaV51u2vyddZjgAzvmO3zaKb1cwd4cr5hnad8vl4fMbosBsCQ== ) 

Set-WebhookConfig.ps1
Update registered Service Endpoint in the target environment with new API Key and WebhookURL.

Set-D365ApplicationUser.ps1
Service Principals for Webhook, Logic Apps and Companion App are registered as Application Users in Dynamics and assigned specific security roles.
Depending on Identity of above Azure resources, either User or System Identified which allow for Managed Identity in the Azure resources.
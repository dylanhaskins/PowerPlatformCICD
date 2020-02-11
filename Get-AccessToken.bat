set resource=%1
set tokenName=%2
for /f "tokens=* USEBACKQ" %%F IN (`call az account get-access-token --resource %resource% --query accessToken --output tsv`) DO (
echo ##vso[task.setvariable variable=%tokenName%;issecret=true]%%F
)
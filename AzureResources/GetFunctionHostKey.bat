FOR /F "tokens=* USEBACKQ" %%F IN (`CALL az rest --method post --uri "https://management.azure.com$(functionAppResourceId)/functions/AccountWebhook/listkeys ?api-version=2018-02-01"  --output tsv`) DO (
SET apikey=%%F
)
echo ##vso[task.setvariable variable=functionKey;]%apikey%



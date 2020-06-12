######################## SETUP 
$ProgressPreference = 'SilentlyContinue'
. (Join-Path $PSScriptRoot "DeploymentFunctions.ps1")


    #Uninstall Default Solutions
    Remove-DefaultSolutions -Conn $CRMConn
		
    #Set system settings
    Set-SystemSettings -Conn $CRMConn
		
    #Disable OOTB views
    Disable-DefaultViews -Conn $CRMConn
		
    #Disable default activity feeds
    Disable-DefaultActivityFeeds -Conn $CRMConn
		
    #updating the name of root business unit
    Update-RootBU -Conn $CRMConn
		
    #Disbale default document templates
    Disable-DefaultDocumentTemplates -Conn $CRMConn
		
    #Disable Mailboxes
    Disable-Mailboxes -Conn $CRMConn
		
    #Deleting OOTB option set values
    Update-DefaultOptionSets -Conn $CRMConn

    #Disabling default processes
    Disable-DefaultProcesses -Conn $CRMConn

	#Remove Deprecated PluginSteps
	Remove-DeprecatedSDKSteps -Conn $CRMConn
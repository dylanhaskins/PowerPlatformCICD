@echo off
set package_root=..\..\..\
REM Find Microsoft.Xrm.Tooling.PackageDeployment.CrmPackageExtentionBase.dll in the package folder (irrespective of version)
For /R %package_root% %%G IN (Microsoft.Xrm.Tooling.PackageDeployment.CrmPackageExtentionBase.dll) do (
	IF EXIST "%%G" (set xrm_path=%%G
	goto :continue)
	)

:continue
@echo Using '%xrm_path%' 
roslyn\csc.exe /target:library ..\..\Deployment\FeatureTemplatePackage.cs /r:"%xrm_path%" /r:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.6.2\System.ComponentModel.Composition.dll"

xcopy Deployment\. ..\..\..\PackageDeployer\bin\Release\. /s/e/y/i
xcopy FeatureTemplatePackage.dll ..\..\..\PackageDeployer\bin\Release\.

if errorlevel 1 (
echo Error Code=%errorlevel%
exit /b %errorlevel%
)
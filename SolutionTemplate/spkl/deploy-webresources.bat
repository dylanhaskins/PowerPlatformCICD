@echo off
set package_root=%userprofile%\.nuget\packages\
REM Find the spkl in the package folder (irrespective of version)
for /f %%G in ('dir %package_root%\spkl.exe /s/b/o:-d') do ( 
	IF EXIST "%%G" (set spkl_path=%%G
	)
	)

:continue
@echo Using '%spkl_path%' 
REM spkl webresources [path] [connection-string]
"%spkl_path%" webresources "%cd%" %*

if errorlevel 1 (
echo Error Code=%errorlevel%
exit /b %errorlevel%
)

pause
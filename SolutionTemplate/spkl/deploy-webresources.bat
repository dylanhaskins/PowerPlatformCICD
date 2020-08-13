@echo off
call npm run dist
call :_sub_Short_Path "%userprofile%"
set "package_root=%_s_Short_Path%\.nuget\packages\"
REM Find the spkl in the package folder (irrespective of version)
for /f %%G in ('dir %package_root%\spkl.exe /s/b/o:-d') do ( 
	IF EXIST "%%G" (set spkl_path="%%G"
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
goto EOF

:_sub_Short_Path
set _s_Short_Path=%~s1
EXIT /b

:EOF
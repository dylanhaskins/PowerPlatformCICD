@echo off
call :_sub_Short_Path "%userprofile%"
set "package_root=%_s_Short_Path%\.nuget\packages\"
REM Find the spkl in the package folder (irrespective of version)
for /f %%G in ('dir %package_root%\spkl.exe /s/b/o:-d') do ( 
	IF EXIST "%%G" (set spkl_path=%%G
	)
	)

:continue
@echo Using '%spkl_path%' 
REM spkl plugins [path] [connection-string] [/p:release]
"%spkl_path%" plugins "%cd%" %*

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
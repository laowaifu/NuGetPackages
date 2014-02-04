@echo off

if "%1"=="publish" goto publish
if "%1"=="restore" set target=CheckPrerequisites
if "%1"=="" ( set target=default ) else ( set target=%1 )

%WINDIR%\Microsoft.NET\Framework\v4.0.30319\msbuild.exe NuGetPackages.msbuild /nologo /v:m /t:%target%
goto :eof

:publish
powershell.exe -noprofile publish-nuget-packages.ps1

goto :eof

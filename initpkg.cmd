@echo off

set packagename=%1
if not defined packagename (
    echo Please provide a package name as first parameter.
    goto end
)

set nugetpath=
if not defined nugetpath (
    if exist "%~dp0.nuget\nuget.exe" (
        set "nugetpath=%~dp0.nuget"
    )
)

if defined nugetpath (
    if exist %packagename% ( echo Error: The package already exists. && set errorlevel=1 && goto end )
    mkdir %packagename%
    pushd %packagename%
    "%nugetpath%\nuget.exe" spec %packagename%
    popd
	set errorlevel=0
	xcopy /y /i "Package.msbuild.template" "%packagename%\%packagename%.msbuild*" >NUL
	if %errorlevel% neq 0 ( echo Error: Unable to create '%packagename%.msbuild'. && goto end )
    echo Created '%packagename%.msbuild' successfully.
) else (
    echo Error: Unable to locate NuGet. Please restore the .nuget folder using 'build.cmd restore'.
)

:end
if %errorlevel% equ 0 ( echo Finished. ) else ( echo Finished with errors. )
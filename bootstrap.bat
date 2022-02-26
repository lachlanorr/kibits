:: Run this first on a clean system to prepare kibits build.

@ECHO OFF
SETLOCAL

:: Change to root dir
CD /d %~dp0

:: Pull down our submodules
::git submodule init
::git submodule update --init --recursive

:: Write root directory to main KIBITS_ROOT env var
FOR /f "tokens=1" %%B in ('CHDIR') do set KIBITS_ROOT=%%B

if "%1"=="" (
    SET PLAT=win64
)
if "%1"=="win64" (
    SET PLAT=win64
)
if "%1"=="win32" (
    SET PLAT=win32
)
if "%PLAT%"=="" (
    echo Invalid platform type "%1", must be win32 or win64
    exit /b 1
)

set BUILD_DIR=%KIBITS_ROOT%\build\%PLAT%

if not exist "%BUILD_DIR%" (
   mkdir "%BUILD_DIR%"
   if %errorlevel% neq 0 exit /b %errorlevel%
)

:: Issue cmake command
cd %BUILD_DIR%
if "%PLAT%"=="win64" (
    cmake -G "Visual Studio 16" -A x64 %KIBITS_ROOT%
    if %errorlevel% neq 0 exit /b %errorlevel%
)
if "%PLAT%"=="win32" (
    cmake -G "Visual Studio 16" -A Win32 %KIBITS_ROOT%
    if %errorlevel% neq 0 exit /b %errorlevel%
)

echo.
echo Bootstrapping complete.
echo Visual Studio solution: %BUILD_DIR%\kibits.sln
echo.

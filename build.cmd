@echo off
setlocal

rem ===========================================================================
rem  build.cmd - GameList Editor build script
rem  Builds GameListEditor (exe) and the Windows Media Player package using
rem  msbuild. rsvars.bat must be available on PATH (or set via RSVARS).
rem  Run this from the project directory.
rem
rem  Usage:
rem    build.cmd                 - Build Release / Win64
rem    build.cmd Debug Win32      - Build Debug / Win32
rem    build.cmd Release Win64
rem ===========================================================================

set "PROJECT_DIR=%~dp0"
cd /d "%PROJECT_DIR%"

rem ---------------------------------------------------------------------------
rem  Initialise the Delphi environment (BDS, PATH, msbuild) via rsvars.bat.
rem  Use the explicitly provided RSVARS path if set, otherwise rely on
rem  rsvars.bat being on PATH.
rem ---------------------------------------------------------------------------
if defined RSVARS (
    call "%RSVARS%"
) else (
    call rsvars.bat
)

if errorlevel 1 (
    echo [ERROR] Failed to run rsvars.bat.
    exit /b 1
)

rem ---------------------------------------------------------------------------
rem  Resolve build config/platform AFTER rsvars.bat so its environment cannot
rem  overwrite our values. Use distinct names to avoid clashing with any
rem  environment PLATFORM variable.
rem ---------------------------------------------------------------------------
if "%~1"=="" ( set "BUILD_CONFIG=Release" ) else ( set "BUILD_CONFIG=%~1" )
if "%~2"=="" ( set "BUILD_PLATFORM=Win64" ) else ( set "BUILD_PLATFORM=%~2" )

echo Building GameListEditor  Config=%BUILD_CONFIG%  Platform=%BUILD_PLATFORM%

rem ---------------------------------------------------------------------------
rem  Build the main application. The WMP package is Win32-only, so it is built
rem  separately (see below) and not as part of the platform build.
rem ---------------------------------------------------------------------------
msbuild GameListEditor.dproj /t:Build /p:Config=%BUILD_CONFIG% /p:Platform=%BUILD_PLATFORM% /maxcpucount /verbosity:minimal
if errorlevel 1 (
    echo.
    echo [ERROR] Build failed. See messages above.
    exit /b %errorlevel%
)

rem ---------------------------------------------------------------------------
rem  Build the Windows Media Player package for Win32 (it does not support
rem  Win64). This is only attempted when the platform is not Win64, to avoid a
rem  conflict on 64-bit builds.
rem ---------------------------------------------------------------------------
if /i "%BUILD_PLATFORM%"=="Win64" (
    echo Skipping Win32-only package pkg_windowsmediaplayer on Win64 build.
) else (
    msbuild pkg_windowsmediaplayer.dproj /t:Build /p:Config=%BUILD_CONFIG% /p:Platform=Win32 /maxcpucount /verbosity:minimal
    if errorlevel 1 (
        echo.
        echo [ERROR] Package build failed. See messages above.
        exit /b %errorlevel%
    )
)

echo.
echo Build completed successfully.
exit /b 0
@echo off
setlocal enabledelayedexpansion

REM -- Roblox place info
set "UNIVERSE_ID=1234"
set "PLACE_ID=1234"

REM -- Path to Roblox versions
set "ROBLOX_VERSIONS=%localappdata%\Roblox\Versions"

REM -- Find the most recent version folder with Roblox Studio
set "STUDIO_EXE="
for /f "delims=" %%i in ('dir "%ROBLOX_VERSIONS%\version-*" /ad /b /o-d') do (
    set "VERSION_PATH=%ROBLOX_VERSIONS%\%%i"
    for %%f in ("!VERSION_PATH!\*Studio*.exe") do (
        if exist "%%~f" (
            set "STUDIO_EXE=%%~f"
            set "LATEST_VERSION=%%i"
            goto launch
        )
    )
)

echo ❌ No usable Roblox Studio executable found in any version folder.
pause
exit /b

:launch
echo ✅ Found Studio executable: !STUDIO_EXE!
echo ✅ In version: !LATEST_VERSION!

start "" "!STUDIO_EXE!" -startEvent www.roblox.com/robloxQTStudioStartedEvent -task EditPlace -universeId %UNIVERSE_ID% -placeId %PLACE_ID%

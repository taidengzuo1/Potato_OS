@echo off
REM Push PotatoOS to GitHub

echo ========================================
echo Pushing PotatoOS to GitHub
echo ========================================
echo.

echo Repository: https://github.com/taidengzuo1/Potato_OS
echo Branch: main
echo.

echo Pushing...
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo Push successful!
    echo ========================================
    echo.
    echo Visit your repository:
    echo https://github.com/taidengzuo1/Potato_OS
) else (
    echo.
    echo ========================================
    echo Push failed!
    echo ========================================
    echo.
    echo Please check your git credentials
)

echo.
pause

@echo off
REM Setup SSH to use port 443 for GitHub

echo ========================================
echo Configuring SSH for GitHub (Port 443)
echo ========================================
echo.

set SSH_DIR=%USERPROFILE%\.ssh
set SSH_CONFIG=%SSH_DIR%\config

if not exist "%SSH_DIR%" (
    echo Creating .ssh directory...
    mkdir "%SSH_DIR%"
)

echo Adding GitHub SSH configuration (port 443)...

echo >> "%SSH_CONFIG%"
echo Host github.com >> "%SSH_CONFIG%"
echo     Hostname ssh.github.com >> "%SSH_CONFIG%"
echo     Port 443 >> "%SSH_CONFIG%"
echo     User git >> "%SSH_CONFIG%"

echo.
echo Configuration added!
echo.

echo Testing SSH connection...
ssh -T git@github.com

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo SSH setup successful!
    echo ========================================
) else (
    echo.
    echo ========================================
    echo SSH test failed!
    echo ========================================
    echo.
    echo Please check:
    echo 1. Firewall settings
    echo 2. Network connection
    echo 3. GitHub SSH keys added
)

echo.
pause

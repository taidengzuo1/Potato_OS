@echo off
REM SimpleOS VirtualBox VM 创建脚本

set VM_NAME=SimpleOS
set OS_IMAGE=g:\codebuddy_projects\os\os.img

echo ========================================
echo Creating SimpleOS VM in VirtualBox
echo ========================================
echo.

REM 检查 VirtualBox 是否安装
where VBoxManage >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] VirtualBox is not installed!
    echo Please download from: https://www.virtualbox.org/
    pause
    exit /b 1
)

REM 检查 os.img 是否存在
if not exist "%OS_IMAGE%" (
    echo [ERROR] os.img not found at: %OS_IMAGE%
    echo Please build the OS first by running: build.bat
    pause
    exit /b 1
)

echo [1/5] Creating virtual machine...
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" createvm --name %VM_NAME% --register
if %errorlevel% neq 0 (
    echo [ERROR] Failed to create VM
    pause
    exit /b 1
)

echo [2/5] Configuring VM settings (32MB RAM, 1 CPU)...
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm %VM_NAME% --memory 32 --cpus 1 --vram 1
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm %VM_NAME% --ostype Other32

echo [3/5] Adding floppy controller...
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" storagectl %VM_NAME% --name "Floppy Controller" --add floppy

echo [4/5] attaching OS image...
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" storageattach %VM_NAME% --storagectl "Floppy Controller" --port 0 --device 0 --type fdd --medium "%OS_IMAGE%"

echo [5/5] Setting boot order...
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm %VM_NAME% --boot1 floppy

echo.
echo ========================================
echo VirtualBox VM created successfully!
echo ========================================
echo.
echo Starting VM now...
echo.

REM 启动虚拟机
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm %VM_NAME%

echo.
echo VM is running. To start it manually later:
echo   1. Open VirtualBox
echo   2. Select "%VM_NAME%"
echo   3. Click "Start"
echo.
echo To delete this VM:
echo   VBoxManage unregistervm %VM_NAME% --delete
echo.
pause

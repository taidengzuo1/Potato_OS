@echo off
REM Quick setup check for SimpleOS
chcp 65001 >nul

echo ========================================
echo SimpleOS Environment Check
echo ========================================
echo.

echo [1/3] Checking NASM...
where nasm >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] NASM is installed
    nasm -version
) else (
    echo [X] NASM is not installed
    echo Please download from: https://www.nasm.us/
)
echo.

echo [2/3] Checking GCC...
where gcc >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] GCC is installed
    gcc --version | findstr /r "gcc"
) else (
    echo [X] GCC is not installed
    echo Please install TDM-GCC from: https://jmeubank.github.io/tdm-gcc/download/
)
echo.

echo [3/3] Checking QEMU...
where qemu-system-i386 >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] QEMU is installed
    qemu-system-i386 --version | findstr /r "QEMU"
) else (
    echo [X] QEMU is not installed
    echo Please download from: https://www.qemu.org/
)
echo.

echo ========================================
echo Check Complete
echo ========================================
echo.
echo If all tools are installed, run: build.bat
echo Otherwise, please install the required tools first.
echo.
pause

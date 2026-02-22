@echo off
REM SimpleOS Windows 构建脚本

echo Building SimpleOS...

REM 检查必要的工具
echo Checking for required tools...

where nasm >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误: 未找到 nasm 汇编器
    echo 请使用 Chocolatey 安装: choco install nasm
    pause
    exit /b 1
)

where gcc >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误: 未找到 gcc
    echo 请安装 MinGW-w64
    pause
    exit /b 1
)

where qemu-system-i386 >nul 2>nul
if %errorlevel% neq 0 (
    echo 警告: 未找到 QEMU,无法运行系统
    echo 请从 https://www.qemu.org/ 下载安装
)

REM 清理旧的文件
echo Cleaning old files...
del /Q boot.bin kernel.bin os.img kernel.o kernel_asm.o 2>nul

REM 编译引导程序
echo Compiling bootloader...
nasm -f bin boot\boot.asm -o boot.bin

if %errorlevel% neq 0 (
    echo 错误: 引导程序编译失败
    pause
    exit /b 1
)

REM 编译内核
echo Compiling kernel...
gcc -m32 -ffreestanding -O2 -Wall -Wextra -nostdlib -fno-builtin -c kernel\kernel.c -o kernel.o
if %errorlevel% neq 0 (
    echo 错误: 内核C代码编译失败
    pause
    exit /b 1
)

nasm -f elf32 kernel\kernel.asm -o kernel_asm.o
if %errorlevel% neq 0 (
    echo 错误: 内核汇编代码编译失败
    pause
    exit /b 1
)

ld -m elf_i386 -T linker.ld -o kernel.bin kernel.o kernel_asm.o
if %errorlevel% neq 0 (
    echo 错误: 内核链接失败
    pause
    exit /b 1
)

REM 创建磁盘镜像
echo Creating disk image...
fsutil file createnew os.img 1474560 >nul
copy /b boot.bin + os.img os_temp.img >nul
move /y os_temp.img os.img >nul

REM Windows下使用更简单的方法追加内核
echo Appending kernel...
python -c "with open('kernel.bin','rb') as f1, open('os.img','rb') as f2, open('os_final.img','wb') as f3: f3.write(f2.read()); f3.seek(512); f3.write(f1.read())" 2>nul
if exist os_final.img move /y os_final.img os.img >nul

echo.
echo ================================
echo 构建成功! os.img 已创建
echo ================================
echo.
echo 运行系统: qemu-system-i386 -drive format=raw,file=os.img
echo.
pause

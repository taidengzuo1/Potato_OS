# SimpleOS - 一个简单的x86操作系统

SimpleOS是一个教学性质的简单操作系统,展示操作系统开发的基本概念。它可以在QEMU虚拟机中运行。

## 系统特性

- **Bootloader**: 自定义启动引导程序,支持加载内核到内存
- **内核**: 32位x86内核,实现基本功能
- **VGA显示**: 80x25文本模式显示系统
- **内存管理**: 基础内存信息显示
- **命令行界面**: 简单的命令行系统

## 项目结构

```
os/
├── boot/
│   └── boot.asm          # 启动引导程序
├── kernel/
│   ├── kernel.asm        # 内核汇编启动代码
│   └── kernel.c          # 内核C代码
├── linker.ld             # 链接器脚本
├── Makefile              # Make构建文件
├── build.sh              # Linux构建脚本
├── build.bat             # Windows构建脚本
└── README.md             # 本文件
```

## 前置要求

### Windows用户

1. **NASM 汇编器**
   - 使用Chocolatey安装: `choco install nasm`
   - 或从 https://www.nasm.us/ 下载

2. **MinGW-w64 (GCC)**
   - 安装32位交叉编译器
   - 下载地址: https://www.mingw-w64.org/

3. **QEMU**
   - 从 https://www.qemu.org/ 下载并安装
   - 添加到系统PATH

### Linux用户

```bash
# 安装必要工具
sudo apt-get update
sudo apt-get install nasm gcc build-essential qemu-system-x86

# 或者安装32位交叉编译工具
sudo apt-get install gcc-multilib nasm qemu-system-i386
```

## 构建方法

### Windows

```batch
# 使用批处理脚本
build.bat

# 或手动构建
nasm -f bin boot\boot.asm -o boot.bin
gcc -m32 -ffreestanding -O2 -Wall -Wextra -nostdlib -fno-builtin -c kernel\kernel.c -o kernel.o
nasm -f elf32 kernel\kernel.asm -o kernel_asm.o
ld -m elf_i386 -T linker.ld -o kernel.bin kernel.o kernel_asm.o
```

### Linux

```bash
# 使用构建脚本
chmod +x build.sh
./build.sh

# 或使用Makefile
make

# 或手动构建
nasm -f bin boot/boot.asm -o boot.bin
i686-elf-gcc -ffreestanding -O2 -Wall -Wextra -nostdlib -fno-builtin -c kernel/kernel.c -o kernel.o
nasm -f elf32 kernel/kernel.asm -o kernel_asm.o
i686-elf-ld -T linker.ld -o kernel.bin kernel.o kernel_asm.o
```

## 运行系统

### Windows

```batch
qemu-system-i386 -drive format=raw,file=os.img
```

### Linux

```bash
qemu-system-i386 -drive format=raw,file=os.img
```

或使用Makefile:
```bash
make run
```

## 系统功能

当前版本支持:

1. **系统信息显示**
   - 内核版本
   - 架构信息
   - 内存使用情况

2. **VGA文本显示**
   - 80x25字符显示
   - 支持基本颜色
   - 自动滚动

3. **基础命令**
   - `help` - 显示帮助信息
   - `info` - 显示系统信息
   - `clear` - 清屏

## 技术细节

### 内存布局

```
0x7C00 - Bootloader
0x10000 - Kernel (64KB)
0x90000 - 栈
```

### 系统启动流程

1. BIOS加载Bootloader到0x7C00
2. Bootloader加载内核到0x10000
3. 切换到保护模式
4. 跳转到内核
5. 初始化VGA显示
6. 显示系统信息
7. 进入主循环

## 未来改进

- [ ] 键盘输入处理
- [ ] 完整的命令行解释器
- [ ] 文件系统支持
- [ ] 多任务处理
- [ ] 中断处理
- [ ] 内存分配器
- [ ] 系统调用接口
- [ ] 图形界面

## 学习资源

- [OSDev Wiki](https://wiki.osdev.org/)
- [Developing Your Own 32-Bit Operating System](https://www.youtube.com/playlist?list=PLxN0UwT2w5jv2vBZg8DfO2Zr0c8c7vZf0)
- [Writing a Simple Operating System from Scratch](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)

## 许可证

MIT License - 自由使用和学习

## 贡献

欢迎提交问题和改进建议!

## 注意事项

- 这是一个教学项目,不适合生产环境
- 仅在QEMU中测试,在真实硬件上运行可能有风险
- 代码可能包含bug,仅用于学习目的

## 联系方式

如有问题或建议,欢迎交流!

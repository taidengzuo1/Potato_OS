# PotatoOS Makefile

ASSEMBLER = nasm
CC = i686-elf-gcc
LD = i686-elf-ld

ASFLAGS = -f bin
CFLAGS = -ffreestanding -O2 -Wall -Wextra -nostdlib -fno-builtin -I./include
LDFLAGS = -T linker.ld -o kernel.bin

# 源文件
BOOT_SRC = boot/boot.asm
KERNEL_ASM = kernel/kernel.asm
KERNEL_C = kernel/kernel.c
VERSION_C = kernel/version.c

# 输出文件
BOOT_BIN = boot.bin
KERNEL_BIN = kernel.bin
OS_IMAGE = os.img

.PHONY: all clean run

all: $(OS_IMAGE)

$(BOOT_BIN): $(BOOT_SRC)
	$(ASSEMBLER) $(ASFLAGS) $< -o $@

kernel.o: $(KERNEL_C) include/version.h include/kernel.h
	$(CC) $(CFLAGS) -c $< -o $@

version.o: $(VERSION_C) include/version.h include/kernel.h
	$(CC) $(CFLAGS) -c $< -o $@

kernel_asm.o: $(KERNEL_ASM)
	$(ASSEMBLER) -f elf32 $< -o $@

$(KERNEL_BIN): kernel.o version.o kernel_asm.o linker.ld
	$(LD) $(LDFLAGS) kernel.o version.o kernel_asm.o

$(OS_IMAGE): $(BOOT_BIN) $(KERNEL_BIN)
	dd if=/dev/zero of=$(OS_IMAGE) bs=512 count=2880
	dd if=$(BOOT_BIN) of=$(OS_IMAGE) conv=notrunc
	dd if=$(KERNEL_BIN) of=$(OS_IMAGE) seek=1 conv=notrunc

clean:
	rm -f $(BOOT_BIN) $(KERNEL_BIN) kernel.o version.o kernel_asm.o $(OS_IMAGE)

run: $(OS_IMAGE)
	qemu-system-i386 -drive format=raw,file=$(OS_IMAGE)

debug: $(OS_IMAGE)
	qemu-system-i386 -drive format=raw,file=$(OS_IMAGE) -s -S

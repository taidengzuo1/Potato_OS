; Bootloader - 简单的启动加载器
; 使用NASM语法

[bits 16]
[org 0x7c00]

start:
    ; 清屏
    mov ax, 0x0003
    int 0x10
    
    ; 显示启动消息
    mov si, boot_msg
    call print_string
    
    ; 加载内核
    mov ax, 0x1000      ; 内核将加载到0x10000
    mov es, ax
    mov bx, 0x0000
    
    mov ah, 0x02        ; BIOS读取扇区功能
    mov al, 0x10        ; 读取16个扇区(8KB)
    mov ch, 0x00        ; 柱面0
    mov cl, 0x02        ; 从扇区2开始
    mov dh, 0x00        ; 磁头0
    mov dl, 0x80        ; 第一个硬盘
    
    int 0x13
    
    jc disk_error       ; 如果出错则跳转
    
    ; 跳转到保护模式
    call enable_protected_mode
    
    ; 跳转到内核
    jmp 0x1000:0x0000

enable_protected_mode:
    ; 加载GDT
    lgdt [gdt_descriptor]
    
    ; 设置CR0的PE位
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    
    ; 远跳转到32位代码
    jmp CODE_SEG:init_pm

[bits 32]
init_pm:
    ; 设置数据段
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    ; 设置栈
    mov ebp, 0x90000
    mov esp, ebp
    
    ; 跳转到内核
    jmp 0x10000

[bits 16]
print_string:
    lodsb
    or al, al
    jz done
    mov ah, 0x0E
    int 0x10
    jmp print_string
done:
    ret

disk_error:
    mov si, error_msg
    call print_string
    jmp $

; GDT
gdt_start:
gdt_null:
    dd 0x0
    dd 0x0

gdt_code:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00

gdt_data:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

boot_msg db 'SimpleOS Bootloader v1.0', 0x0D, 0x0A, 'Loading kernel...', 0x0D, 0x0A, 0
error_msg db 'Disk read error!', 0x0D, 0x0A, 0

times 510-($-$$) db 0
dw 0xAA55

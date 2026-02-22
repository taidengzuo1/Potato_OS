; 内核汇编启动代码
[bits 32]

[extern kernel_main]

call kernel_main
jmp $

; 简单的 halt
cli
hlt
jmp $

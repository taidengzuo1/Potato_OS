/* 链接器脚本 */
ENTRY(_start)

SECTIONS
{
    /* 内核从1MB开始加载 */
    . = 0x10000;
    
    /* 代码段 */
    .text ALIGN(4) : {
        *(.text)
        *(.text*)
    }
    
    /* 只读数据段 */
    .rodata ALIGN(4) : {
        *(.rodata)
        *(.rodata*)
    }
    
    /* 数据段 */
    .data ALIGN(4) : {
        *(.data)
        *(.data*)
    }
    
    /* BSS段 */
    .bss ALIGN(4) : {
        *(.COMMON)
        *(.bss)
        *(.bss*)
    }
    
    /* 栈区域 */
    .stack ALIGN(4) : {
        . = . + 0x1000;  /* 4KB栈 */
    }
}

#include <stdint.h>
#include "version.h"

// VGA文本模式显示
#define VGA_MEMORY 0xB8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 25

// 颜色定义
#define VGA_COLOR_BLACK 0
#define VGA_COLOR_WHITE 15

// 屏幕游标位置
static int cursor_x = 0;
static int cursor_y = 0;

// 内存大小 (128MB)
#define MEMORY_SIZE (128 * 1024 * 1024)
#define MEMORY_END 0x8000000

// 设置颜色
static inline uint8_t vga_entry_color(uint8_t fg, uint8_t bg) {
    return fg | (bg << 4);
}

// 创建VGA条目
static inline uint16_t vga_entry(unsigned char uc, uint8_t color) {
    return (uint16_t)uc | (uint16_t)color << 8;
}

// 初始化VGA显示
void vga_init() {
    uint16_t* buffer = (uint16_t*)VGA_MEMORY;
    uint8_t color = vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
    
    for (int i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++) {
        buffer[i] = vga_entry(' ', color);
    }
    
    cursor_x = 0;
    cursor_y = 0;
}

// 滚动屏幕
void vga_scroll() {
    uint16_t* buffer = (uint16_t*)VGA_MEMORY;
    
    // 上移一行
    for (int i = 0; i < (VGA_HEIGHT - 1) * VGA_WIDTH; i++) {
        buffer[i] = buffer[i + VGA_WIDTH];
    }
    
    // 清除最后一行
    uint8_t color = vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
    for (int i = (VGA_HEIGHT - 1) * VGA_WIDTH; i < VGA_HEIGHT * VGA_WIDTH; i++) {
        buffer[i] = vga_entry(' ', color);
    }
    
    cursor_y--;
}

// 打印单个字符
void vga_putchar(char c) {
    uint16_t* buffer = (uint16_t*)VGA_MEMORY;
    uint8_t color = vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
    
    if (c == '\n') {
        cursor_x = 0;
        cursor_y++;
        if (cursor_y >= VGA_HEIGHT) {
            vga_scroll();
        }
        return;
    }
    
    if (c == '\r') {
        cursor_x = 0;
        return;
    }
    
    if (c == '\t') {
        cursor_x = (cursor_x + 4) & ~3;
        if (cursor_x >= VGA_WIDTH) {
            cursor_x = 0;
            cursor_y++;
        }
        return;
    }
    
    int index = cursor_y * VGA_WIDTH + cursor_x;
    buffer[index] = vga_entry(c, color);
    
    cursor_x++;
    if (cursor_x >= VGA_WIDTH) {
        cursor_x = 0;
        cursor_y++;
        if (cursor_y >= VGA_HEIGHT) {
            vga_scroll();
        }
    }
}

// 打印字符串
void vga_print(const char* str) {
    while (*str) {
        vga_putchar(*str);
        str++;
    }
}

// 打印数字
void vga_print_dec(int value) {
    if (value == 0) {
        vga_putchar('0');
        return;
    }
    
    char buffer[32];
    int i = 0;
    
    if (value < 0) {
        vga_putchar('-');
        value = -value;
    }
    
    while (value > 0) {
        buffer[i++] = '0' + (value % 10);
        value /= 10;
    }
    
    while (i > 0) {
        vga_putchar(buffer[--i]);
    }
}

// 打印十六进制数
void vga_print_hex(uint32_t value) {
    const char hex_chars[] = "0123456789ABCDEF";
    vga_print("0x");
    
    for (int i = 28; i >= 0; i -= 4) {
        vga_putchar(hex_chars[(value >> i) & 0xF]);
    }
}

// 内存信息结构
typedef struct {
    uint32_t total_memory;
    uint32_t free_memory;
    uint32_t used_memory;
} memory_info_t;

// 获取内存信息
void get_memory_info(memory_info_t* info) {
    info->total_memory = MEMORY_SIZE;
    info->used_memory = 0;
    info->free_memory = MEMORY_SIZE;
}

// 显示版本信息
void print_version() {
    vga_print("Version: ");
    vga_print(VERSION_STRING);
    vga_print("\n");
}

// 显示详细版本信息
void print_version_detailed() {
    const version_t* ver = get_version();
    
    vga_print("\n========================================\n");
    vga_print("         Version Information\n");
    vga_print("========================================\n\n");
    
    vga_print(OS_NAME);
    vga_print(" ");
    vga_print(VERSION_STRING);
    vga_print("\n\n");
    
    vga_print("Version Details:\n");
    vga_print("  Major: ");
    vga_print_dec(ver->major);
    vga_print("\n");
    vga_print("  Minor: ");
    vga_print_dec(ver->minor);
    vga_print("\n");
    vga_print("  Patch: ");
    vga_print_dec(ver->patch);
    vga_print("\n");
    vga_print("  Build: ");
    vga_print_dec(ver->build);
    vga_print("\n");
    vga_print("  Stage: ");
    vga_print(ver->stage);
    vga_print("\n\n");
    
    vga_print("System Information:\n");
    vga_print("  Architecture: ");
    vga_print(OS_ARCHITECTURE);
    vga_print("\n");
    vga_print("  Author: ");
    vga_print(OS_AUTHOR);
    vga_print("\n");
    vga_print("  License: ");
    vga_print(OS_LICENSE);
    vga_print("\n");
    vga_print("  Compiler: ");
    vga_print(COMPILER_NAME);
    vga_print("\n");
    vga_print("  Build Date: ");
    vga_print(BUILD_DATE);
    vga_print("\n\n");
}

// 显示系统信息
void show_system_info() {
    vga_print("========================================\n");
    vga_print("       Potato_OS \n");
    vga_print("========================================\n\n");
    
    vga_print("Kernel: Potato_OS ");
    vga_print(VERSION_STRING);
    vga_print("\n");
    vga_print("Architecture: ");
    vga_print(OS_ARCHITECTURE);
    vga_print("\n");
    vga_print("Developer: taidengzuo's AI Assistant\n\n");
    
    memory_info_t mem_info;
    get_memory_info(&mem_info);
    
    vga_print("Memory Information:\n");
    vga_print("  Total: ");
    vga_print_dec(mem_info.total_memory / (1024 * 1024));
    vga_print(" MB\n");
    vga_print("  Free:  ");
    vga_print_dec(mem_info.free_memory / (1024 * 1024));
    vga_print(" MB\n\n");
    
    vga_print("Features:\n");
    vga_print("  - VGA Text Mode Display\n");
    vga_print("  - Basic Memory Management\n");
    vga_print("  - System Information Display\n");
    vga_print("  - Simple Kernel Interface\n");
    vga_print("  - Version Management System\n\n");
}

// 内核入口点
void kernel_main() {
    // 初始化显示
    vga_init();
    
    // 显示系统信息
    show_system_info();
    
    vga_print("Kernel initialized successfully!\n");
    vga_print("System is running...\n\n");
    
    vga_print("Commands available:\n");
    vga_print("  help     - Show this help\n");
    vga_print("  info     - Display system information\n");
    vga_print("  version  - Display version information\n");
    vga_print("  ver      - Display detailed version info\n");
    vga_print("  clear    - Clear the screen\n\n");
    
    vga_print("Ready for commands...\n");
    
    // 简单的命令行循环
    const char* input = "";
    
    // 在真实系统中,这里会有键盘输入处理
    // 现在只是显示欢迎信息
    
    // 内核主循环
    while (1) {
        // 在真实系统中,这里会等待用户输入
        // 现在只是保持内核运行
        __asm__ __volatile__("hlt");
    }
}

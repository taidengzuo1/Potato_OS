// 内核函数声明

// VGA 显示函数
void vga_init(void);
void vga_putchar(char c);
void vga_print(const char* str);
void vga_print_dec(int value);
void vga_print_hex(uint32_t value);
void vga_scroll(void);

// 系统信息函数
void show_system_info(void);
void print_version(void);
void print_version_detailed(void);

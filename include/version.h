#ifndef VERSION_H
#define VERSION_H

// 版本信息结构
typedef struct {
    uint8_t major;      // 主版本号
    uint8_t minor;      // 次版本号
    uint8_t patch;      // 补丁版本号
    uint8_t build;      // 构建号
    const char* stage;  // 开发阶段
} version_t;

// 当前版本信息
#define VERSION_MAJOR 0
#define VERSION_MINOR 0
#define VERSION_PATCH 0
#define VERSION_BUILD 0
#define VERSION_STAGE "alpha"

// 版本字符串
#define VERSION_STRING "0.0.0-alpha.0"

// 系统信息
#define OS_NAME "PotatoOS"
#define OS_ARCHITECTURE "x86 (32-bit)"
#define OS_AUTHOR "TiMoon's AI Assistant"
#define OS_LICENSE "MIT"
#define OS_HOMEPAGE "https://github.com/potatoos/os"

// 编译信息
#define COMPILER_NAME "GCC"
#define BUILD_DATE "2026-02-22"

// 版本比较结果
typedef enum {
    VERSION_EQUAL = 0,
    VERSION_OLDER = -1,
    VERSION_NEWER = 1
} version_compare_t;

// 版本函数声明
const version_t* get_version(void);
void print_version(void);
void print_version_detailed(void);
version_compare_t compare_versions(const version_t* v1, const version_t* v2);
const char* version_to_string(const version_t* version);
int check_version_compatibility(uint8_t required_major, uint8_t required_minor);

#endif // VERSION_H

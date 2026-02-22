#include "version.h"
#include "kernel.h"

// 版本信息实例
static version_t current_version = {
    VERSION_MAJOR,
    VERSION_MINOR,
    VERSION_PATCH,
    VERSION_BUILD,
    VERSION_STAGE
};

// 获取当前版本
const version_t* get_version(void) {
    return &current_version;
}

// 转换版本为字符串
const char* version_to_string(const version_t* version) {
    static char version_str[32];
    
    if (!version) {
        return "Unknown";
    }
    
    // 简单的版本字符串生成 (不使用 sprintf)
    // 格式: MAJOR.MINOR.PATCH-STAGE.BUILD
    return VERSION_STRING;
}

// 比较两个版本
version_compare_t compare_versions(const version_t* v1, const version_t* v2) {
    if (!v1 || !v2) {
        return VERSION_EQUAL;
    }
    
    // 比较主版本号
    if (v1->major < v2->major) return VERSION_OLDER;
    if (v1->major > v2->major) return VERSION_NEWER;
    
    // 比较次版本号
    if (v1->minor < v2->minor) return VERSION_OLDER;
    if (v1->minor > v2->minor) return VERSION_NEWER;
    
    // 比较补丁版本号
    if (v1->patch < v2->patch) return VERSION_OLDER;
    if (v1->patch > v2->patch) return VERSION_NEWER;
    
    // 比较构建号
    if (v1->build < v2->build) return VERSION_OLDER;
    if (v1->build > v2->build) return VERSION_NEWER;
    
    return VERSION_EQUAL;
}

// 检查版本兼容性
int check_version_compatibility(uint8_t required_major, uint8_t required_minor) {
    const version_t* current = get_version();
    
    // 主版本号必须完全匹配
    if (current->major != required_major) {
        return 0;
    }
    
    // 当前版本必须 >= 要求的版本
    if (current->minor < required_minor) {
        return 0;
    }
    
    return 1;
}

# PotatoOS 版本管理文档

## 版本号格式

PotatoOS 使用语义化版本控制 (Semantic Versioning) 格式:

```
MAJOR.MINOR.PATCH-STAGE.BUILD
```

示例: `0.0.0-alpha.0`

### 版本号说明

- **MAJOR (主版本号)**: 不兼容的API修改
- **MINOR (次版本号)**: 向下兼容的功能性新增
- **PATCH (补丁版本号)**: 向下兼容的问题修正
- **STAGE (开发阶段)**:
  - `alpha` - 内部测试版
  - `beta` - 公开测试版
  - `rc` - 候选发布版
  - `release` - 正式发布版
- **BUILD (构建号)**: 构建序列号

## 当前版本

**版本**: 0.0.0-alpha.0

**说明**: 初始开发版本,包含基础功能

## 版本更新规则

### 更新 MAJOR 版本号

当进行以下更改时:
- 破坏性的API变更
- 内核架构重大重构
- 不兼容的系统调用接口变更

### 更新 MINOR 版本号

当进行以下更改时:
- 新增重要功能
- 系统接口扩展(保持向后兼容)
- 新增驱动或子系统

### 更新 PATCH 版本号

当进行以下更改时:
- Bug修复
- 性能优化
- 文档更新

### 更新 STAGE

版本阶段 progression:
```
alpha -> beta -> rc -> release
```

### 更新 BUILD

每次编译时自动递增

## 版本文件说明

### include/version.h

定义版本宏和函数声明:
```c
#define VERSION_MAJOR 0
#define VERSION_MINOR 0
#define VERSION_PATCH 0
#define VERSION_BUILD 0
#define VERSION_STAGE "alpha"
#define VERSION_STRING "0.0.0-alpha.0"
```

### kernel/version.c

实现版本相关功能:
- `get_version()` - 获取当前版本
- `compare_versions()` - 比较版本
- `check_version_compatibility()` - 检查兼容性
- `version_to_string()` - 版本转字符串

## 使用示例

### 在代码中使用版本信息

```c
#include "version.h"

// 获取版本
const version_t* ver = get_version();

// 检查兼容性
if (check_version_compatibility(0, 0)) {
    // 版本兼容
}

// 比较版本
version_compare_t result = compare_versions(ver, &required_version);
```

### 显示版本信息

```c
// 显示简单版本
print_version();          // Version: 0.0.0-alpha.0

// 显示详细版本
print_version_detailed();
```

## 版本管理最佳实践

1. **更新版本前**:
   - 更新 CHANGELOG.md
   - 记录所有更改
   - 测试所有功能

2. **发布新版本**:
   - 更新 include/version.h 中的宏
   - 提交到版本控制
   - 创建 Git 标签
   - 编写发布说明

3. **版本兼容性**:
   - 保持API向后兼容
   - 废弃的功能至少保留一个主版本
   - 提供迁移指南

## 版本历史

### v0.0.0-alpha.0 (2026-02-22)

**初始版本**
- ✅ Bootloader 实现
- ✅ 基础内核
- ✅ VGA文本显示
- ✅ 内存信息显示
- ✅ 版本管理系统

## 未来版本规划

### v0.1.0-alpha.0 (计划中)

- 键盘输入处理
- 命令行解释器
- 基本命令实现

### v0.2.0-alpha.0 (计划中)

- 中断处理
- 定时器
- 简单的任务调度

### v0.3.0-alpha.0 (计划中)

- 文件系统 (FAT12/16)
- 内存分配器
- 动态内存管理

### v1.0.0-release (远期目标)

- 完整的多任务支持
- 网络协议栈
- 图形用户界面

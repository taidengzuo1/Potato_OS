# GitHub 推送替代方案

## 方案一: 配置代理

如果您使用 VPN 或代理软件:

```batch
# 查看代理端口(通常在 7890, 1080 等)
# 设置 Git 代理
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890

# 重新推送
git push -u origin main

# 完成后取消代理(可选)
git config --global --unset http.proxy
git config --global --unset https.proxy
```

## 方案二: 使用 GitHub 镜像站

### 使用 Gitee 作为中转

```batch
# 1. 在 Gitee 创建新仓库: https://gitee.com/
# 2. 添加 Gitee 远程仓库
git remote add gitee https://gitee.com/taidengzuo1/PotatoOS.git

# 3. 推送到 Gitee
git push -u gitee main

# 4. 在 Gitee 设置中配置"从 GitHub 导入"到您的 GitHub 仓库
```

### 使用 GitHub 镜像

某些网络可以使用以下镜像地址:
```batch
# 修改远程仓库为镜像
git remote set-url origin https://github.com.cnpmjs.org/taidengzuo1/Potato_OS.git

# 推送
git push -u origin main
```

## 方案三: 稍后重试

等待网络稳定后重试:
```batch
git push -u origin main
```

## 方案四: 使用 SSH 方式

如果 HTTPS 不稳定,可以尝试 SSH:

```batch
# 1. 生成 SSH 密钥(如果还没有)
ssh-keygen -t ed25519 -C "taidengzuo1"

# 2. 复制公钥
type %USERPROFILE%\.ssh\id_ed25519.pub

# 3. 添加到 GitHub: Settings → SSH and GPG keys → New SSH key

# 4. 切换到 SSH URL
git remote set-url origin git@github.com:taidengzuo1/Potato_OS.git

# 5. 推送
git push -u origin main
```

## 方案五: 使用 GitHub Desktop

1. 下载 GitHub Desktop: https://desktop.github.com/
2. 登录您的 GitHub 账号
3. 克隆或添加本地仓库
4. 通过界面推送

## 方案六: 导出代码包

如果网络问题持续:

```batch
# 打包代码
git archive --format=zip --output=PotatoOS.zip main

# 或手动压缩文件夹
```

然后手动上传到 GitHub:
1. 访问: https://github.com/taidengzuo1/Potato_OS
2. 点击 "Upload files"
3. 上传压缩包
4. 写提交说明

## 诊断网络问题

### 检查 GitHub 连接
```batch
# 测试 DNS
nslookup github.com

# 测试连接
telnet github.com 443

# 查看路由
tracert github.com
```

### 常见网络问题
- 🔒 防火墙阻止
- 🌐 公司网络限制
- 📍 地理位置限制
- 📡 网络供应商问题

## 临时解决方案

如果需要立即保存代码:

1. **代码已在本地 Git 仓库中**,不会丢失
2. 定期 `git commit` 保存更改
3. 等网络恢复后再推送

本地提交历史:
```batch
git log --oneline
```

## 建议

优先尝试:
1. **方案一**: 配置代理(如果您有)
2. **方案二**: 稍后重试
3. **方案六**: 手动上传代码包

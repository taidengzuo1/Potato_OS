# 推送代码到 GitHub

## 当前状态

✅ Git 仓库已初始化
✅ 代码已提交
✅ 远程仓库已配置: https://github.com/taidengzuo1/Potato_OS.git

## 推送步骤

### 方法一: 使用 Personal Access Token (推荐)

1. **创建 GitHub Personal Access Token**:
   - 访问: https://github.com/settings/tokens
   - 点击 "Generate new token" → "Generate new token (classic)"
   - 勾选以下权限:
     - `repo` (完整仓库访问权限)
     - `workflow` (工作流权限,可选)
   - 设置有效期,点击 "Generate token"
   - **重要**: 复制生成的 token(只显示一次!)

2. **推送代码**:
   ```batch
   cd g:\codebuddy_projects\os

   git push -u origin main
   ```

   当提示输入用户名和密码时:
   - Username: `taidengzuo1`
   - Password: 粘贴刚才生成的 Personal Access Token

### 方法二: 使用 GitHub CLI (gh)

如果您已安装 GitHub CLI:

```batch
gh auth login
# 按提示选择 GitHub.com,选择 HTTPS 方式
git push -u origin main
```

### 方法三: 使用 SSH 密钥

1. 生成 SSH 密钥:
   ```batch
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. 添加到 GitHub:
   - 复制公钥: `type %USERPROFILE%\.ssh\id_ed25519.pub`
   - 访问: https://github.com/settings/keys
   - 点击 "New SSH key",粘贴公钥

3. 修改远程仓库为 SSH:
   ```batch
   git remote set-url origin git@github.com:taidengzuo1/Potato_OS.git
   git push -u origin main
   ```

## 常见问题

### Q: 推送时提示 "authentication failed"
A: 确保使用正确的 token 或 SSH 密钥,密码已失效

### Q: 提示 "repository not found"
A: 确保已在 GitHub 上创建了 Potato_OS 仓库

### Q: 提示 "remote origin already exists"
A: 可以先删除再重新添加:
```batch
git remote remove origin
git remote add origin https://github.com/taidengzuo1/Potato_OS.git
```

## 提交后的操作

推送成功后,您可以:

1. 访问您的仓库: https://github.com/taidengzuo1/Potato_OS
2. 启用 GitHub Pages (可选)
3. 设置仓库描述和主题
4. 添加 README 图片
5. 创建 Releases 标记版本

## 未来更新

每次修改代码后:

```batch
git add .
git commit -m "描述您的更改"
git push
```

## 当前提交信息

- 提交哈希: `bddb2e1`
- 分支: `main`
- 文件数: 14
- 总行数: 1222
- 版本: PotatoOS v0.0.0-alpha.0

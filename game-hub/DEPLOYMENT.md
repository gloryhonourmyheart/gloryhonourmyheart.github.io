# 游戏中心部署指南

## 项目概述
这是一个基于 Vue 3 + Vite 的多游戏中心项目，包含 2048 游戏、是或否游戏等功能，采用护眼清新绿风格设计。

## 部署到 Vercel（推荐）

### 方法一：通过 GitHub 部署（推荐）

1. **将项目上传到 GitHub**
   - 在 GitHub 创建新仓库
   - 将项目文件推送到仓库

2. **在 Vercel 部署**
   - 访问 [Vercel](https://vercel.com)
   - 使用 GitHub 账号登录
   - 点击 "New Project"
   - 选择你的游戏中心仓库
   - 保持默认设置，点击 "Deploy"

3. **获取访问链接**
   - 部署完成后，Vercel 会提供类似 `https://your-project-name.vercel.app` 的链接
   - 这个链接可以分享给任何人访问

### 方法二：通过 Vercel CLI 部署

1. **安装 Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **登录 Vercel**
   ```bash
   vercel login
   ```

3. **部署项目**
   ```bash
   cd e:\files\gameshows\filesgameshows\game-hub
   vercel --prod
   ```

## 部署到 Netlify（备选方案）

1. **访问 [Netlify](https://netlify.com)**
2. **拖拽 dist 文件夹到部署区域**
3. **或连接 GitHub 仓库自动部署**

## 本地构建测试

项目已经配置好构建脚本，可以本地测试：

```bash
# 进入项目目录
cd e:\files\gameshows\filesgameshows\game-hub

# 安装依赖（如果未安装）
npm install

# 构建项目
npm run build

# 预览构建结果
npm run preview
```

## 部署配置说明

- **vercel.json**: Vercel 部署配置文件
- **dist/**: 构建输出目录
- **package.json**: 包含构建脚本和依赖

## 访问链接示例

部署成功后，你将获得类似以下的访问链接：
- `https://game-hub-abc123.vercel.app`
- `https://your-custom-domain.com`（可配置自定义域名）

## 注意事项

1. **免费额度**: Vercel 和 Netlify 都提供免费额度，足够个人项目使用
2. **自动部署**: 连接 GitHub 后，每次代码推送都会自动重新部署
3. **HTTPS**: 所有部署都自动启用 HTTPS
4. **全球 CDN**: 项目会部署到全球 CDN，访问速度快

## 技术支持

如果部署过程中遇到问题，可以：
1. 检查控制台错误信息
2. 查看 Vercel/Netlify 的部署日志
3. 确保所有依赖正确安装
4. 验证构建过程无错误

---

**现在你可以将项目部署到 Vercel，获得一个可以分享的在线链接！**
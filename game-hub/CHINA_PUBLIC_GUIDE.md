# Game Hub - China Public Deployment Guide

This guide provides solutions for deploying your game hub to China-accessible public networks, allowing friends in China to access your games directly via public links.

## Quick Start

1. **Double-click** `deploy-china.bat`
2. **Choose Option 1** (Tencent Cloud Webify - Recommended)
3. Follow the step-by-step instructions
4. Get your public link: `https://your-app-xxx.tcloudbaseapp.com`

## Deployment Options

### Option 1: Tencent Cloud Webify (Recommended)

**Advantages:**
- Fast China network access
- Generous free quota (sufficient for game hub)
- One-click deployment
- Automatic HTTPS
- CDN acceleration

**Steps:**
1. Visit: https://console.cloud.tencent.com/webify
2. Login with WeChat scan (Chinese account)
3. Click "New Application"
4. Select "Deploy from code repository"
5. Authorize GitHub or Gitee account
6. Select this project repository
7. Auto build and deploy
8. Get public link: `https://your-app-xxx.tcloudbaseapp.com`

**Expected Time:** 10-15 minutes

### Option 2: Alibaba Cloud Function Compute

**Advantages:**
- Alibaba Cloud China network
- Stable performance
- Free tier available
- Static website hosting

**Steps:**
1. Visit: https://fc.console.aliyun.com
2. Login with Alipay scan
3. Create service and application
4. Upload project zip file
5. Configure static website hosting
6. Auto generate access domain

**Expected Link:** `https://your-app.region.fc.aliyuncs.com`

### Option 3: Gitee Pages (Completely Free)

**Advantages:**
- 100% free
- Very fast China access
- Simple deployment
- No credit card required

**Requirements:**
- Chinese phone number for registration
- Manual file upload

**Steps:**
1. Visit: https://gitee.com/
2. Register account (Chinese phone required)
3. Create repository
4. Upload all project files
5. Enable Gitee Pages service
6. Wait for deployment

**Expected Link:** `https://your-name.gitee.io/your-repo`

## Comparison Table

| Feature | Tencent Webify | Gitee Pages | Alibaba FC |
|---------|----------------|-------------|------------|
| China Speed | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Deployment Ease | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Cost | Free (quota) | Completely Free | Free (quota) |
| Stability | High | Medium | High |
| Setup Time | 10-15 min | 15-20 min | 15-20 min |

## Troubleshooting

### Common Issues

**1. Build Failures**
- Ensure all dependencies are in package.json
- Check for missing files
- Verify build script works locally

**2. Access Issues**
- Wait 5-10 minutes after deployment
- Clear browser cache
- Try different browser

**3. Registration Issues**
- Use Chinese phone number for Gitee
- WeChat/Alipay accounts must be Chinese

### Local Testing

Before deployment, test locally:

```bash
npm run build
npm run preview  # or serve the dist folder
```

## Alternative: Quick Manual Deployment

If scripts fail, manually deploy:

1. **Build project:** `npm run build`
2. **Zip the dist folder**
3. **Upload to chosen platform**
4. **Configure static hosting**

## Support

If deployment fails:
- Try Option 1 (Tencent Webify) first
- Use Option 3 (Gitee) if registration possible
- Contact platform support if needed

---

**Note:** All solutions provide China-accessible public links that your friends can click directly without VPN or special setup.
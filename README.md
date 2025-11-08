# FunGameNook 🎮 | 趣玩小铺

A personal project showcasing frontend development skills through interactive web games, starting with the classic 2048 and expanding with more games!

一个展示前端开发能力的个人项目，通过交互式网页游戏（从经典2048开始）展现现代Web开发技术栈与实践能力。



***

## 🌟 项目简介 | Project Introduction

### 中文说明

FunGameNook 趣玩小铺是我作为计算机科学与技术专业毕业生开发的个人前端项目。我从经典的2048游戏入手，构建了一个可扩展的游戏聚合平台。项目注重代码质量与用户体验，采用现代前端工程化实践，完整实现了游戏逻辑、状态管理、响应式布局与动画效果。

通过模块化的架构设计，我确保了代码的可维护性和可扩展性，使后续新增游戏能够无缝集成。这个项目不仅展示了我的前端开发能力，也是我学习新技术、解决复杂问题的实践平台。

### English Description

FunGameNook is a personal frontend project developed by a Computer Science and Technology graduate. Starting with the classic 2048 game, I built an extensible game aggregation platform. The project focuses on code quality and user experience, adopting modern frontend engineering practices, and fully implementing game logic, state management, responsive layouts, and animation effects.

Through modular architecture design, I ensured code maintainability and scalability, allowing newly added games to be seamlessly integrated. This project not only showcases my frontend development capabilities but also serves as a practical platform for me to learn new technologies and solve complex problems.



***

## 🎯 核心功能 | Core Features

### 已上线游戏 | Current Games



* **2048 经典版** 🧩: 独立开发实现的数字解谜游戏，使用原生JavaScript实现游戏核心逻辑，包含键盘与触摸事件处理、游戏状态管理、得分系统与动画效果。通过算法优化确保在各种设备上的流畅体验。

* **2048 Classic Edition** 🧩: Independently developed number puzzle game using vanilla JavaScript for core game logic, including keyboard and touch event handling, game state management, scoring system, and animation effects. Algorithm optimization ensures smooth experience across various devices.

### 开发计划 | Roadmap

我计划在未来实现以下游戏，持续拓展前端技术应用场景：

* 要或不要游戏 🔄: 简单的决策游戏，玩家需要根据提示选择“要”或“不要”，最终影响游戏结果。
* 消除类益智游戏 🧬: 将使用Vue.js组件化开发，实现复杂的匹配逻辑与关卡系统。
* 复古贪吃蛇 🐍: 使用Canvas API实现高性能渲染，展示图形编程能力。
* 记忆卡牌游戏 🃏: 结合CSS动画与状态管理，打造流畅的交互体验。

I plan to implement the following games in the future, continuously expanding frontend technology application scenarios:

* Want or Not Game 🔄: A simple decision-making game where players need to choose "Want" or "Not" based on prompts, and the choices will ultimately affect the game outcome.
* Match-3 Puzzle Game 🧬: Will use Vue.js component development to implement complex matching logic and level system.
* Snake Retro Edition 🐍: Use Canvas API for high-performance rendering, showcasing graphics programming capabilities.
* Memory Card Game 🃏: Combine CSS animations with state management to create smooth interactive experiences.

### 项目技术亮点 | Technical Highlights



1. **响应式设计** | Responsive Design: 使用CSS Grid和Flexbox实现全设备兼容，确保在手机、平板和桌面端都有良好体验。

2. **性能优化** | Performance Optimization: 实现事件委托、防抖节流、内存管理等前端性能优化技术，保证游戏流畅运行。

3. **模块化架构** | Modular Architecture: 采用ES Modules规范，实现代码的高内聚低耦合，便于维护和扩展。

4. **工程化实践** | Engineering Practices: 集成现代前端工具链，包括代码规范、自动格式化、单元测试等，确保代码质量。



***

## 🚀 快速开始 | Quick Start

### 前置要求 | Prerequisites



* Node.js (推荐 v14.0.0 及以上版本) | Node.js (v14.0.0+ recommended)

* npm 或 yarn | npm or yarn

* Git

### 安装步骤 | Installation Steps

#### 1. 克隆仓库 | Clone the Repository


#### 2. 安装依赖 | Install Dependencies


# 或使用yarn安装
yarn install
```

> **注意**：项目使用pnpm可能会遇到依赖解析问题，建议使用npm或yarn

#### 3. 环境变量配置 | Environment Configuration

创建 `.env` 文件并配置必要的环境变量：

```dotenv
# 开发服务器配置
VITE_PORT=3000
VITE_HOST=localhost

# 游戏配置
VITE_GAME_AUTO_SAVE=true
VITE_GAME_ANIMATION_ENABLED=true

# 构建配置
VITE_BUILD_ANALYZE=false
```

#### 4. 运行开发服务器 | Run Development Server

```bash
# 使用npm
npm run dev

# 或使用yarn
yarn dev
```

#### 5. 访问应用 | Access Application

开发服务器启动后，打开浏览器访问：`http://localhost:3000`

### 构建生产版本 | Build for Production



```
npm run build

\# 或 | or

yarn build
```

构建后的文件将保存在 `dist` 目录下，可部署至 GitHub Pages 等静态托管服务。| The built files will be in the `dist` directory, which can be deployed to static hosting services like GitHub Pages.



***

## 🛠️ 技术栈 | Tech Stack



* **前端框架** | Frontend Framework: Vue.js 3 + Composition API | 利用组合式API实现更灵活的逻辑复用

* **状态管理** | State Management: Pinia | 轻量级状态管理，优化游戏状态共享

* **样式方案** | Styling: Tailwind CSS + SCSS | 原子化CSS加速开发，SCSS增强可维护性

* **构建工具** | Build Tool: Vite | 极速开发体验与优化的生产构建

* **代码质量** | Code Quality: ESLint + Prettier | 统一代码规范，提高开发效率

* **版本控制** | Version Control: Git & GitHub | 规范的分支管理与代码提交



***

## 🤝 贡献指南 | Contribution Guide

作为一名刚毕业的开发者，我非常欢迎学习交流与合作！如果你有兴趣参与项目或提供建议，请：

1. **Fork 仓库** | Fork the Repository

2. **创建功能分支** | Create a Feature Branch

```
git checkout -b feature/your-feature-name
```

3. **提交更改** | Commit Your Changes

```
git commit -m "feat: add your feature description"
```

4. **推送分支** | Push to the Branch

```
git push origin feature/your-feature-name
```

5. **发起 Pull Request** | Open a Pull Request

作为一名刚毕业的开发者，我非常期待与大家共同学习成长！

As a recent graduate developer, I warmly welcome learning exchanges and collaborations! If you're interested in participating in the project or providing suggestions:



***

## 🐛 BUG 反馈与功能建议 | Bug Reports & Feature Requests

若你遇到任何 BUG，或有新功能 / 新游戏的想法，欢迎：| If you encounter any bugs or have ideas for new features/games, feel free to:



* 在 GitHub 上发起 Issue，并添加 `bug` 或 `feature request` 标签 | Open an issue on GitHub with the label `bug` or `feature request`

* 详细描述问题 / 想法（包括复现 BUG 的步骤或具体游戏需求）| Describe the problem/idea in detail (including steps to reproduce bugs or specific game requirements)



***

## 📜 许可证 | License

本项目基于 [MIT 许可证](LICENSE) 开源。作为学习与展示用途，欢迎交流学习！| This project is licensed under the [MIT License](LICENSE). Welcome for learning and exchange purposes!



***

## 💬 联系方式 | Contact



* GitHub: [@前端开发者肖以琛](https://github.com/gloryhonourmyheart) | GitHub: [@gloryhonourmyheart](https://github.com/gloryhonourmyheart)

* 邮箱：yichenx254@gmail.com | Email: yichenx254@gmail.com

* 求职意向：前端开发工程师 | Job Seeking: Frontend Developer

* 毕业本科院校：计算机科学与技术专业 2025届 | Education: Computer Science and Technology, Class of 2025



***

> 🌟 
>
> **作为一名刚毕业的计算机科学与技术专业学生，我通过这个项目实践了前端开发的核心技能。我热衷于学习新技术，解决复杂问题，并致力于创建优秀的用户体验。期待与您一起探讨前端技术，共同成长！**

🌟 **As a recent Computer Science and Technology graduate, I've practiced core frontend development skills through this project. I'm passionate about learning new technologies, solving complex problems, and creating excellent user experiences. Looking forward to discussing frontend technologies with you and growing together!**

如果这个项目展示了我的能力，别忘了在 GitHub 上给我点一个 ⭐ 并联系我！| If this project showcases my capabilities, don't forget to give me a ⭐ on GitHub and contact me!

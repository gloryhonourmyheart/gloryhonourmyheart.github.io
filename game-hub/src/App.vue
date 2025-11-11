<template>
  <div id="app">
    <!-- 顶部导航栏 -->
    <nav class="navbar" v-if="showNavbar">
      <div class="nav-container">
        <div class="nav-brand">
          <span class="brand-icon">🌿</span>
          <span class="brand-name">清悦休闲</span>
        </div>
        <div class="nav-actions">
          <div v-if="!loggedIn" class="auth-buttons">
            <button class="login-btn" @click="goToLogin">
              <span class="btn-icon">🔑</span>
              登录
            </button>
            <button class="register-btn" @click="goToRegister">
              <span class="btn-icon">📝</span>
              注册
            </button>
          </div>
          <div v-else class="user-info">
            <div class="user-avatar">{{ user.avatar }}</div>
            <span class="user-name">你好，{{ user.username }}</span>
            <button class="logout-btn" @click="handleLogout">
              <span class="btn-icon">🚪</span>
              退出
            </button>
          </div>
        </div>
      </div>
    </nav>
    
    <!-- 主内容区域 -->
    <main class="main-content">
      <router-view />
    </main>
  </div>
</template>

<script>
import { computed, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { isLoggedIn, getCurrentUser, logout } from './utils/auth'

export default {
  name: 'App',
  setup() {
    const route = useRoute()
    const router = useRouter()
    
    // 用户状态
    const user = ref(getCurrentUser())
    
    // 在注册页面隐藏导航栏
    const showNavbar = computed(() => route.name !== 'register')
    
    // 检查登录状态
    const loggedIn = ref(isLoggedIn())
    
    const goToRegister = () => {
      if (route.name !== 'register') {
        router.push('/register')
      }
    }
    
    const goToLogin = () => {
      if (route.name !== 'login') {
        router.push('/login')
      }
    }
    
    const handleLogout = () => {
      logout()
      user.value = null
      loggedIn.value = false
      router.push('/')
    }
    
    // 监听路由变化，更新用户状态
    router.afterEach(() => {
      loggedIn.value = isLoggedIn()
      user.value = getCurrentUser()
    })
    
    return {
      showNavbar,
      goToRegister,
      goToLogin,
      handleLogout,
      loggedIn,
      user
    }
  }
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Baloo 2', cursive, sans-serif;
  background: linear-gradient(-45deg, #e2f3e4, #c5e6c6, #a8d8b9, #8bcbae);
  background-size: 400% 400%;
  animation: gradientShift 8s ease infinite;
  min-height: 100vh;
}

@keyframes gradientShift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

/* 导航栏样式 */
.navbar {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(139, 180, 172, 0.3);
  padding: 15px 0;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.nav-brand {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 1.5em;
  font-weight: bold;
  color: #2d6a4f;
}

.brand-icon {
  font-size: 1.2em;
}

.brand-name {
  background: linear-gradient(135deg, #2d6a4f, #5a8a6e);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.nav-actions {
  display: flex;
  gap: 15px;
}

.login-btn {
  background: linear-gradient(135deg, #4a90e2, #357abd);
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 25px;
  font-size: 1em;
  font-weight: bold;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: all 0.3s ease;
  box-shadow: 0 3px 10px rgba(74, 144, 226, 0.3);
}

.login-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(74, 144, 226, 0.4);
}

.register-btn {
  background: linear-gradient(135deg, #5a8a6e, #8bb4ac);
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 25px;
  font-size: 1em;
  font-weight: bold;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: all 0.3s ease;
  box-shadow: 0 3px 10px rgba(91, 138, 110, 0.3);
}

.register-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(91, 138, 110, 0.4);
}

.btn-icon {
  font-size: 1.1em;
}

/* 用户信息样式 */
.user-info {
  display: flex;
  align-items: center;
  gap: 15px;
}

.user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: linear-gradient(135deg, #ff6b6b, #ee5a52);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2em;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
}

.user-name {
  font-weight: bold;
  color: #2d6a4f;
  font-size: 1em;
}

.logout-btn {
  background: linear-gradient(135deg, #ff6b6b, #ee5a52);
  color: white;
  border: none;
  padding: 8px 15px;
  border-radius: 20px;
  font-size: 0.9em;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 5px;
  transition: all 0.3s ease;
}

.logout-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 3px 10px rgba(255, 107, 107, 0.4);
}

.auth-buttons {
  display: flex;
  gap: 15px;
}

.main-content {
  flex: 1;
  display: flex;
  flex-direction: column;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .nav-container {
    padding: 0 15px;
  }
  
  .nav-brand {
    font-size: 1.3em;
  }
  
  .brand-name {
    font-size: 0.9em;
  }
  
  .register-btn {
    padding: 8px 16px;
    font-size: 0.9em;
  }
}
</style>
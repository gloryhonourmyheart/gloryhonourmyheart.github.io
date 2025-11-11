<template>
  <div class="login-container">
    <div class="login-background">
      <div class="login-form">
        <div class="form-header">
          <h1 class="form-title">登录清悦休闲</h1>
          <p class="form-subtitle">欢迎回来，继续您的游戏之旅</p>
        </div>
        
        <!-- 微信扫码登录 -->
        <div class="wechat-login-section">
          <div class="wechat-qr-code">
            <div class="qr-code-placeholder">
              <div class="wechat-icon">💬</div>
              <p class="qr-text">微信扫码登录</p>
            </div>
          </div>
          <button class="wechat-login-btn" @click="handleWechatLogin">
            <span class="btn-icon">💬</span>
            微信扫码登录
          </button>
          <p class="wechat-tip">首次使用微信登录将自动注册</p>
        </div>
        
        <!-- 分隔线 -->
        <div class="divider">
          <span class="divider-text">或</span>
        </div>
        
        <!-- 用户名登录 -->
        <div class="username-login-section">
          <div class="form-group">
            <label for="username">用户名</label>
            <input 
              id="username"
              v-model="username"
              type="text" 
              placeholder="请输入用户名"
              class="form-input"
            >
          </div>
          <button class="username-login-btn" @click="handleUsernameLogin">
            <span class="btn-icon">🔑</span>
            用户名登录
          </button>
        </div>
        
        <!-- 底部链接 -->
        <div class="form-footer">
          <p class="footer-text">
            还没有账户？
            <router-link to="/register" class="footer-link">立即注册</router-link>
          </p>
        </div>
        
        <!-- 加载状态 -->
        <div v-if="loading" class="loading-overlay">
          <div class="loading-spinner"></div>
          <p class="loading-text">{{ loadingText }}</p>
        </div>
        
        <!-- 成功提示 -->
        <div v-if="showSuccess" class="success-modal">
          <div class="modal-content">
            <div class="modal-icon">🎉</div>
            <h3 class="modal-title">登录成功！</h3>
            <p class="modal-message">欢迎回来，{{ successUsername }}</p>
            <button class="modal-btn" @click="goToHome">开始游戏</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { login, wechatLogin, simulateWechatScan } from '../utils/auth'

export default {
  name: 'Login',
  setup() {
    const router = useRouter()
    
    const username = ref('')
    const loading = ref(false)
    const loadingText = ref('')
    const showSuccess = ref(false)
    const successUsername = ref('')
    
    const handleWechatLogin = async () => {
      loading.value = true
      loadingText.value = '正在连接微信...'
      
      try {
        // 模拟微信扫码过程
        setTimeout(() => {
          // 模拟微信用户数据
          const wechatUser = {
            username: `微信用户_${Math.floor(Math.random() * 10000)}`,
            email: '',
            avatar: '💬'
          }
          
          simulateWechatScan(wechatUser)
          loadingText.value = '正在登录...'
          
          // 执行微信登录
          wechatLogin()
            .then(user => {
              loading.value = false
              successUsername.value = user.username
              showSuccess.value = true
            })
            .catch(error => {
              loading.value = false
              alert('微信登录失败：' + error.message)
            })
        }, 1500)
      } catch (error) {
        loading.value = false
        alert('微信登录失败：' + error.message)
      }
    }
    
    const handleUsernameLogin = () => {
      if (!username.value.trim()) {
        alert('请输入用户名')
        return
      }
      
      loading.value = true
      loadingText.value = '正在登录...'
      
      try {
        const user = login(username.value)
        loading.value = false
        successUsername.value = user.username
        showSuccess.value = true
      } catch (error) {
        loading.value = false
        alert('登录失败：' + error.message)
      }
    }
    
    const goToHome = () => {
      showSuccess.value = false
      router.push('/')
    }
    
    return {
      username,
      loading,
      loadingText,
      showSuccess,
      successUsername,
      handleWechatLogin,
      handleUsernameLogin,
      goToHome
    }
  }
}
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20px;
}

.login-background {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(20px);
  border-radius: 30px;
  padding: 60px 40px;
  max-width: 500px;
  width: 100%;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
}

.form-header {
  text-align: center;
  margin-bottom: 40px;
}

.form-title {
  font-size: 2.5rem;
  color: white;
  margin-bottom: 10px;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
}

.form-subtitle {
  font-size: 1.1rem;
  color: rgba(255, 255, 255, 0.8);
}

.wechat-login-section {
  text-align: center;
  margin-bottom: 30px;
}

.wechat-qr-code {
  margin-bottom: 20px;
}

.qr-code-placeholder {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 30px;
  border: 2px dashed rgba(255, 255, 255, 0.3);
}

.wechat-icon {
  font-size: 3rem;
  margin-bottom: 10px;
}

.qr-text {
  color: rgba(255, 255, 255, 0.8);
  font-size: 1rem;
}

.wechat-login-btn {
  background: linear-gradient(135deg, #07c160, #06ae56);
  color: white;
  border: none;
  padding: 15px 30px;
  border-radius: 25px;
  font-size: 1.1rem;
  font-weight: bold;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  width: 100%;
  transition: all 0.3s ease;
  margin-bottom: 10px;
}

.wechat-login-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(7, 193, 96, 0.4);
}

.wechat-tip {
  font-size: 0.9rem;
  color: rgba(255, 255, 255, 0.6);
}

.divider {
  position: relative;
  text-align: center;
  margin: 30px 0;
}

.divider::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 0;
  right: 0;
  height: 1px;
  background: rgba(255, 255, 255, 0.3);
}

.divider-text {
  background: rgba(255, 255, 255, 0.1);
  padding: 0 15px;
  color: rgba(255, 255, 255, 0.8);
  font-size: 0.9rem;
}

.username-login-section {
  margin-bottom: 30px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  color: white;
  margin-bottom: 8px;
  font-weight: bold;
}

.form-input {
  width: 100%;
  padding: 12px 15px;
  border: none;
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.9);
  font-size: 1rem;
  transition: all 0.3s ease;
}

.form-input:focus {
  outline: none;
  background: white;
  box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.3);
}

.username-login-btn {
  background: linear-gradient(135deg, #4a90e2, #357abd);
  color: white;
  border: none;
  padding: 15px 30px;
  border-radius: 25px;
  font-size: 1.1rem;
  font-weight: bold;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  width: 100%;
  transition: all 0.3s ease;
}

.username-login-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(74, 144, 226, 0.4);
}

.form-footer {
  text-align: center;
  margin-top: 30px;
}

.footer-text {
  color: rgba(255, 255, 255, 0.8);
}

.footer-link {
  color: #4ecdc4;
  text-decoration: none;
  font-weight: bold;
}

.footer-link:hover {
  text-decoration: underline;
}

.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.loading-spinner {
  width: 50px;
  height: 50px;
  border: 5px solid rgba(255, 255, 255, 0.3);
  border-top: 5px solid #4ecdc4;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 20px;
}

.loading-text {
  color: white;
  font-size: 1.1rem;
}

.success-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 20px;
  padding: 40px;
  text-align: center;
  max-width: 400px;
  width: 90%;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
}

.modal-icon {
  font-size: 4rem;
  margin-bottom: 20px;
}

.modal-title {
  font-size: 1.8rem;
  color: #2d6a4f;
  margin-bottom: 10px;
}

.modal-message {
  color: #666;
  margin-bottom: 30px;
}

.modal-btn {
  background: linear-gradient(135deg, #5a8a6e, #8bb4ac);
  color: white;
  border: none;
  padding: 12px 30px;
  border-radius: 25px;
  font-size: 1rem;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s ease;
}

.modal-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(91, 138, 110, 0.4);
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

@media (max-width: 768px) {
  .login-background {
    padding: 40px 20px;
    margin: 20px;
  }
  
  .form-title {
    font-size: 2rem;
  }
  
  .qr-code-placeholder {
    padding: 20px;
  }
  
  .wechat-icon {
    font-size: 2.5rem;
  }
}
</style>
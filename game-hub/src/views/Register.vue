<template>
  <div class="register-container">
    <div class="register-card">
      <!-- 返回按钮 -->
      <button class="back-btn" @click="goBack">
        <span class="back-icon">←</span>
        返回首页
      </button>
      
      <!-- 注册表单 -->
      <div class="register-form">
        <div class="form-header">
          <h1 class="form-title">注册清悦休闲</h1>
          <p class="form-subtitle">创建您的游戏账户，开始畅玩</p>
        </div>
        
        <form @submit.prevent="handleRegister">
          <!-- 邮箱输入 -->
          <div class="form-group">
            <label for="email" class="form-label">邮箱地址</label>
            <div class="input-wrapper">
              <span class="input-icon">📧</span>
              <input
                id="email"
                v-model="form.email"
                type="email"
                class="form-input"
                placeholder="请输入您的邮箱"
                required
              />
            </div>
          </div>
          
          <!-- 密码输入 -->
          <div class="form-group">
            <label for="password" class="form-label">密码</label>
            <div class="input-wrapper">
              <span class="input-icon">🔒</span>
              <input
                id="password"
                v-model="form.password"
                type="password"
                class="form-input"
                placeholder="请输入密码（至少6位）"
                minlength="6"
                required
              />
            </div>
          </div>
          
          <!-- 确认密码 -->
          <div class="form-group">
            <label for="confirmPassword" class="form-label">确认密码</label>
            <div class="input-wrapper">
              <span class="input-icon">🔒</span>
              <input
                id="confirmPassword"
                v-model="form.confirmPassword"
                type="password"
                class="form-input"
                placeholder="请再次输入密码"
                minlength="6"
                required
              />
            </div>
            <div v-if="form.password && form.confirmPassword && form.password !== form.confirmPassword" 
                 class="error-message">
              密码不一致
            </div>
          </div>
          
          <!-- 昵称输入 -->
          <div class="form-group">
            <label for="nickname" class="form-label">昵称</label>
            <div class="input-wrapper">
              <span class="input-icon">👤</span>
              <input
                id="nickname"
                v-model="form.nickname"
                type="text"
                class="form-input"
                placeholder="请输入您的昵称"
                required
              />
            </div>
          </div>
          
          <!-- 用户协议 -->
          <div class="form-group terms-group">
            <label class="checkbox-label">
              <input
                v-model="form.agreeTerms"
                type="checkbox"
                class="checkbox-input"
                required
              />
              <span class="checkbox-text">
                我已阅读并同意
                <a href="#" class="terms-link">《用户协议》</a>
                和
                <a href="#" class="terms-link">《隐私政策》</a>
              </span>
            </label>
          </div>
          
          <!-- 注册按钮 -->
          <button type="submit" class="submit-btn" :disabled="!isFormValid">
            <span v-if="!isLoading">立即注册</span>
            <span v-else class="loading-text">注册中...</span>
          </button>
        </form>
        
        <!-- 登录链接 -->
        <div class="login-link">
          已有账户？
          <a href="#" class="link" @click.prevent="goToLogin">立即登录</a>
        </div>
      </div>
    </div>
    
    <!-- 注册成功弹窗 -->
    <div v-if="showSuccessModal" class="modal-overlay">
      <div class="success-modal">
        <div class="modal-icon">🎉</div>
        <h3 class="modal-title">注册成功！</h3>
        <p class="modal-message">欢迎加入清悦休闲，开始您的游戏之旅</p>
        <button class="modal-btn" @click="goToHome">开始游戏</button>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'

export default {
  name: 'Register',
  setup() {
    const router = useRouter()
    
    // 表单数据
    const form = ref({
      email: '',
      password: '',
      confirmPassword: '',
      nickname: '',
      agreeTerms: false
    })
    
    const isLoading = ref(false)
    const showSuccessModal = ref(false)
    
    // 表单验证
    const isFormValid = computed(() => {
      return (
        form.value.email &&
        form.value.password &&
        form.value.confirmPassword &&
        form.value.nickname &&
        form.value.agreeTerms &&
        form.value.password === form.value.confirmPassword
      )
    })
    
    // 处理注册
    const handleRegister = async () => {
      if (!isFormValid.value) return
      
      isLoading.value = true
      
      // 模拟注册请求
      try {
        await new Promise(resolve => setTimeout(resolve, 1500))
        
        // 保存用户信息到本地存储
        const userData = {
          email: form.value.email,
          nickname: form.value.nickname,
          registeredAt: new Date().toISOString()
        }
        localStorage.setItem('qingyue_user', JSON.stringify(userData))
        
        showSuccessModal.value = true
      } catch (error) {
        console.error('注册失败:', error)
      } finally {
        isLoading.value = false
      }
    }
    
    // 导航方法
    const goBack = () => {
      router.push('/')
    }
    
    const goToHome = () => {
      showSuccessModal.value = false
      router.push('/')
    }
    
    const goToLogin = () => {
      // 这里可以跳转到登录页面
      console.log('跳转到登录页面')
    }
    
    return {
      form,
      isLoading,
      showSuccessModal,
      isFormValid,
      handleRegister,
      goBack,
      goToHome,
      goToLogin
    }
  }
}
</script>

<style scoped>
.register-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  background: linear-gradient(-45deg, #e2f3e4, #c5e6c6, #a8d8b9, #8bcbae);
  background-size: 400% 400%;
  animation: gradientShift 8s ease infinite;
}

.register-card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  border-radius: 20px;
  padding: 40px;
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
  border: 1px solid rgba(139, 180, 172, 0.3);
  max-width: 450px;
  width: 100%;
  position: relative;
}

.back-btn {
  position: absolute;
  top: 20px;
  left: 20px;
  background: rgba(139, 180, 172, 0.1);
  border: 1px solid rgba(139, 180, 172, 0.3);
  color: #5a8a6e;
  padding: 8px 15px;
  border-radius: 20px;
  font-size: 0.9em;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 5px;
  transition: all 0.3s ease;
}

.back-btn:hover {
  background: rgba(139, 180, 172, 0.2);
  transform: translateX(-2px);
}

.back-icon {
  font-size: 1.1em;
}

.register-form {
  margin-top: 10px;
}

.form-header {
  text-align: center;
  margin-bottom: 30px;
}

.form-title {
  font-size: 2em;
  font-weight: bold;
  color: #2d6a4f;
  margin-bottom: 10px;
  background: linear-gradient(135deg, #2d6a4f, #5a8a6e);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.form-subtitle {
  color: #7a9c89;
  font-size: 1em;
}

.form-group {
  margin-bottom: 20px;
}

.form-label {
  display: block;
  margin-bottom: 8px;
  color: #5a8a6e;
  font-weight: 500;
  font-size: 0.95em;
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

.input-icon {
  position: absolute;
  left: 15px;
  font-size: 1.1em;
  z-index: 1;
}

.form-input {
  width: 100%;
  padding: 12px 15px 12px 45px;
  border: 2px solid rgba(139, 180, 172, 0.3);
  border-radius: 12px;
  font-size: 1em;
  background: rgba(255, 255, 255, 0.8);
  transition: all 0.3s ease;
  font-family: inherit;
}

.form-input:focus {
  outline: none;
  border-color: #5a8a6e;
  box-shadow: 0 0 0 3px rgba(91, 138, 110, 0.1);
  background: rgba(255, 255, 255, 0.95);
}

.error-message {
  color: #e74c3c;
  font-size: 0.85em;
  margin-top: 5px;
}

.terms-group {
  margin-top: 25px;
}

.checkbox-label {
  display: flex;
  align-items: center;
  cursor: pointer;
  font-size: 0.9em;
  color: #7a9c89;
}

.checkbox-input {
  margin-right: 10px;
  transform: scale(1.1);
}

.terms-link {
  color: #5a8a6e;
  text-decoration: none;
}

.terms-link:hover {
  text-decoration: underline;
}

.submit-btn {
  width: 100%;
  background: linear-gradient(135deg, #5a8a6e, #8bb4ac);
  color: white;
  border: none;
  padding: 15px;
  border-radius: 12px;
  font-size: 1.1em;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-top: 20px;
  box-shadow: 0 4px 15px rgba(91, 138, 110, 0.3);
}

.submit-btn:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(91, 138, 110, 0.4);
}

.submit-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
}

.loading-text {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.login-link {
  text-align: center;
  margin-top: 25px;
  color: #7a9c89;
  font-size: 0.95em;
}

.link {
  color: #5a8a6e;
  text-decoration: none;
  font-weight: 500;
}

.link:hover {
  text-decoration: underline;
}

/* 成功弹窗样式 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2000;
}

.success-modal {
  background: white;
  padding: 40px;
  border-radius: 20px;
  text-align: center;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
  max-width: 350px;
  width: 90%;
}

.modal-icon {
  font-size: 3em;
  margin-bottom: 15px;
}

.modal-title {
  font-size: 1.5em;
  font-weight: bold;
  color: #2d6a4f;
  margin-bottom: 10px;
}

.modal-message {
  color: #7a9c89;
  margin-bottom: 25px;
}

.modal-btn {
  background: linear-gradient(135deg, #5a8a6e, #8bb4ac);
  color: white;
  border: none;
  padding: 12px 30px;
  border-radius: 25px;
  font-size: 1em;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s ease;
}

.modal-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(91, 138, 110, 0.4);
}

/* 响应式设计 */
@media (max-width: 480px) {
  .register-card {
    padding: 30px 20px;
    margin: 10px;
  }
  
  .form-title {
    font-size: 1.7em;
  }
  
  .back-btn {
    top: 15px;
    left: 15px;
    font-size: 0.85em;
  }
}

@keyframes gradientShift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}
</style>
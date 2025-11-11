// 用户认证状态管理
import { ref } from 'vue'

// 用户状态
const user = ref(null)

// 模拟用户数据存储
const users = JSON.parse(localStorage.getItem('gamehub_users') || '[]')

// 检查是否已登录
export const isLoggedIn = () => {
  const userData = localStorage.getItem('gamehub_current_user')
  if (userData) {
    user.value = JSON.parse(userData)
    return true
  }
  return false
}

// 用户注册
export const register = (userData) => {
  // 检查用户名是否已存在
  const existingUser = users.find(u => u.username === userData.username)
  if (existingUser) {
    throw new Error('用户名已存在')
  }
  
  // 添加新用户
  const newUser = {
    id: Date.now().toString(),
    username: userData.username,
    email: userData.email,
    avatar: userData.avatar || '👤',
    createdAt: new Date().toISOString(),
    lastLogin: new Date().toISOString()
  }
  
  users.push(newUser)
  localStorage.setItem('gamehub_users', JSON.stringify(users))
  
  // 自动登录
  login(newUser.username)
  
  return newUser
}

// 用户登录
export const login = (username) => {
  const foundUser = users.find(u => u.username === username)
  if (!foundUser) {
    throw new Error('用户不存在')
  }
  
  // 更新最后登录时间
  foundUser.lastLogin = new Date().toISOString()
  localStorage.setItem('gamehub_users', JSON.stringify(users))
  
  // 设置当前用户
  user.value = foundUser
  localStorage.setItem('gamehub_current_user', JSON.stringify(foundUser))
  
  return foundUser
}

// 微信扫码登录（模拟）
export const wechatLogin = () => {
  return new Promise((resolve, reject) => {
    // 模拟微信扫码登录过程
    setTimeout(() => {
      // 检查是否有微信用户数据
      const wechatUser = localStorage.getItem('gamehub_wechat_user')
      if (wechatUser) {
        const userData = JSON.parse(wechatUser)
        const existingUser = users.find(u => u.username === userData.username)
        
        if (existingUser) {
          // 已有用户，直接登录
          login(existingUser.username)
          resolve(existingUser)
        } else {
          // 新用户，自动注册并登录
          const newUser = register({
            username: userData.username,
            email: userData.email || `${userData.username}@wechat.com`,
            avatar: userData.avatar || '👤'
          })
          resolve(newUser)
        }
      } else {
        reject(new Error('请先扫描二维码登录微信'))
      }
    }, 2000)
  })
}

// 模拟微信扫码
export const simulateWechatScan = (userData) => {
  localStorage.setItem('gamehub_wechat_user', JSON.stringify(userData))
}

// 用户登出
export const logout = () => {
  user.value = null
  localStorage.removeItem('gamehub_current_user')
}

// 获取当前用户
export const getCurrentUser = () => {
  return user.value
}

// 初始化检查登录状态
isLoggedIn()

export default {
  user,
  isLoggedIn,
  register,
  login,
  wechatLogin,
  simulateWechatScan,
  logout,
  getCurrentUser
}
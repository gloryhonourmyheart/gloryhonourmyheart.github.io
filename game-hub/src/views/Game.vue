<template>
  <div class="game-container">
    <!-- 游戏主界面 -->
    <div v-if="!gameStarted" class="game-main">
      <div class="game-info">
        <div class="game-icon">
          <span class="icon">{{ currentGame?.icon }}</span>
        </div>
        <h1 class="game-title">{{ currentGame?.name }}</h1>
        <p class="game-description">{{ currentGame?.description }}</p>
        <div class="high-score">
          <span>最高分：{{ highScore }}</span>
        </div>
      </div>
      
      <div class="game-actions">
        <button class="start-btn" @click="startGame">开始游戏</button>
        <button class="back-btn" @click="backToHome">返回菜单</button>
      </div>
    </div>
    
    <!-- 游戏界面 -->
    <div v-else class="game-interface">
      <div class="game-header">
        <button class="menu-btn" @click="backToMenu">返回菜单</button>
        <div class="score-display">
          <span>分数：{{ score }}</span>
        </div>
      </div>
      
      <div class="game-content">
        <!-- 动态渲染游戏组件 -->
        <component 
          :is="currentGameComponent" 
          @game-over="handleGameOver"
          @score-update="updateScore"
        />
      </div>
    </div>
  </div>
</template>

<script>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import Game2048 from '../components/Game2048.vue'

// 游戏数据
const games = {
  '2048': {
    name: '2048',
    description: '滑动数字方块，合并相同数字，挑战2048！',
    icon: '🧩',
    color: '#4CAF50',
    component: Game2048
  },
  'minesweeper': {
    name: '扫雷',
    description: '避开地雷，标记安全区域，考验你的推理能力！',
    icon: '💣',
    color: '#FF9800',
    component: null
  },
  'snake': {
    name: '贪吃蛇',
    description: '控制小蛇吃食物，避免撞墙或咬到自己！',
    icon: '🐍',
    color: '#2196F3',
    component: null
  },
  'tetris': {
    name: '俄罗斯方块',
    description: '旋转和移动方块，填满一行消除得分！',
    icon: '🧊',
    color: '#E91E63',
    component: null
  }
}

export default {
  name: 'Game',
  setup() {
    const route = useRoute()
    const router = useRouter()
    
    const gameStarted = ref(false)
    const currentScore = ref(0)
    const highScore = ref(0)
    
    // 获取当前游戏信息
    const currentGame = computed(() => {
      return games[route.params.id]
    })
    
    // 动态加载游戏组件
    const currentGameComponent = computed(() => {
      if (!currentGame.value) return null
      
      if (currentGame.value.component) {
        return currentGame.value.component
      }
      
      // 返回占位符组件
      return {
        template: '<div class="game-placeholder"><h3>{{ gameName }}</h3><p>游戏开发中...</p></div>',
        props: ['gameName'],
        setup(props) {
          return { gameName: currentGame.value.name }
        }
      }
    })
    
    // 开始游戏
    const startGame = () => {
      gameStarted.value = true
      currentScore.value = 0
    }
    
    // 返回主菜单
    const backToMenu = () => {
      gameStarted.value = false
    }
    
    // 返回首页
    const backToHome = () => {
      router.push('/')
    }
    
    // 处理游戏结束
    const handleGameOver = (finalScore) => {
      if (finalScore > highScore.value) {
        highScore.value = finalScore
        // 保存到本地存储
        localStorage.setItem(`highScore_${route.params.id}`, finalScore.toString())
      }
      setTimeout(() => {
        if (confirm(`游戏结束！得分：${finalScore}\n是否重新开始？`)) {
          startGame()
        } else {
          backToMenu()
        }
      }, 500)
    }
    
    // 更新分数
    const updateScore = (newScore) => {
      currentScore.value = newScore
    }
    
    // 计算游戏标题和图标
    const gameTitle = computed(() => currentGame.value?.name || '游戏')
    const gameDescription = computed(() => currentGame.value?.description || '')
    const gameIcon = computed(() => currentGame.value?.icon || '🎮')
    
    // 加载最高分
    onMounted(() => {
      const savedHighScore = localStorage.getItem(`highScore_${route.params.id}`)
      if (savedHighScore) {
        highScore.value = parseInt(savedHighScore)
      }
    })
    
    return {
      gameStarted,
      score: currentScore,
      highScore,
      currentGame,
      currentGameComponent,
      gameTitle,
      gameDescription,
      gameIcon,
      startGame,
      backToMenu,
      backToHome,
      handleGameOver,
      updateScore
    }
  }
}
</script>

<style scoped>
.game-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.game-main {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  padding: 40px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  max-width: 500px;
  width: 100%;
  text-align: center;
}

.game-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
  margin-bottom: 30px;
}

.game-icon {
  width: 100px;
  height: 100px;
  background: linear-gradient(135deg, #5a8a6e, #8bb4ac);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 3em;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.game-title {
  color: #2d6a4f;
  font-size: 2.5em;
  margin: 0;
  font-weight: bold;
}

.game-description {
  color: #6b8c7d;
  font-size: 1.1em;
  line-height: 1.5;
  margin: 0;
}

.high-score {
  background: rgba(139, 180, 172, 0.1);
  padding: 10px 20px;
  border-radius: 15px;
  color: #5a8a6e;
  font-weight: bold;
}

.game-actions {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.start-btn, .back-btn {
  padding: 15px 30px;
  border: none;
  border-radius: 25px;
  font-size: 1.1em;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s ease;
}

.start-btn {
  background: linear-gradient(135deg, #5a8a6e, #8bb4ac);
  color: white;
}

.start-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(91, 138, 110, 0.3);
}

.back-btn {
  background: rgba(139, 180, 172, 0.1);
  color: #5a8a6e;
  border: 2px solid #8bb4ac;
}

.back-btn:hover {
  background: rgba(139, 180, 172, 0.2);
}

.game-interface {
  width: 100%;
  max-width: 600px;
}

.game-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 15px 20px;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 15px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.menu-btn {
  background: #8bb4ac;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 20px;
  cursor: pointer;
  font-weight: bold;
}

.menu-btn:hover {
  background: #7aa49c;
}

.score-display {
  font-size: 1.2em;
  color: #2d6a4f;
  font-weight: bold;
}

.game-content {
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  padding: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.game-placeholder {
  padding: 40px;
  text-align: center;
}

.game-placeholder h3 {
  color: #2d6a4f;
  margin-bottom: 15px;
}

.game-placeholder p {
  color: #6b8c7d;
}

@media (max-width: 768px) {
  .game-main {
    padding: 30px 20px;
    margin: 10px;
  }
  
  .game-title {
    font-size: 2em;
  }
  
  .game-icon {
    width: 80px;
    height: 80px;
    font-size: 2.5em;
  }
  
  .start-btn, .back-btn {
    padding: 12px 25px;
    font-size: 1em;
  }
  
  .game-header {
    flex-direction: column;
    gap: 15px;
    text-align: center;
  }
}
</style>
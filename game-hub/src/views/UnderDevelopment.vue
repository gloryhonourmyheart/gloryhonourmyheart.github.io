<template>
  <div class="under-development">
    <div class="development-container">
      <div class="development-icon">🚧</div>
      <h1 class="development-title">开发中</h1>
      <p class="development-message">
        该游戏正在紧张开发中，敬请期待！
      </p>
      <p class="development-subtitle">
        我们正在努力为您带来更好的游戏体验
      </p>
      
      <div class="game-info">
        <div class="game-icon" :style="{ background: gameColor }">
          {{ gameIcon }}
        </div>
        <h2 class="game-name">{{ gameName }}</h2>
        <p class="game-description">{{ gameDescription }}</p>
      </div>
      
      <div class="progress-section">
        <div class="progress-bar">
          <div class="progress-fill" :style="{ width: progress + '%' }"></div>
        </div>
        <div class="progress-text">开发进度：{{ progress }}%</div>
      </div>
      
      <div class="action-buttons">
        <button @click="backToHome" class="back-btn">返回主界面</button>
        <button @click="backToAddGames" class="add-games-btn">查看更多游戏</button>
      </div>
      
      <div class="coming-soon">
        <h3>即将上线</h3>
        <div class="coming-games">
          <div class="coming-game">
            <span class="game-emoji">💣</span>
            <span>扫雷</span>
          </div>
          <div class="coming-game">
            <span class="game-emoji">🐍</span>
            <span>贪吃蛇</span>
          </div>
          <div class="coming-game">
            <span class="game-emoji">🧩</span>
            <span>俄罗斯方块</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { useRouter, useRoute } from 'vue-router'

export default {
  name: 'UnderDevelopment',
  setup() {
    const router = useRouter()
    const route = useRoute()
    
    // 根据游戏ID获取游戏信息
    const getGameInfo = () => {
      const gameId = route.params.id
      const games = {
        'minesweeper': {
          name: '扫雷',
          icon: '💣',
          description: '避开地雷，标记安全区域',
          color: 'linear-gradient(135deg, #ff9800, #ffb74d)',
          progress: 65
        },
        'snake': {
          name: '贪吃蛇',
          icon: '🐍',
          description: '控制小蛇吃食物，不断变长',
          color: 'linear-gradient(135deg, #4caf50, #81c784)',
          progress: 45
        },
        'tetris': {
          name: '俄罗斯方块',
          icon: '🧩',
          description: '旋转下落方块，消除完整行',
          color: 'linear-gradient(135deg, #2196f3, #64b5f6)',
          progress: 75
        }
      }
      
      return games[gameId] || {
        name: '未知游戏',
        icon: '❓',
        description: '游戏信息加载中...',
        color: 'linear-gradient(135deg, #999, #ccc)',
        progress: 50
      }
    }
    
    const gameInfo = getGameInfo()
    
    const backToHome = () => {
      router.push('/')
    }
    
    const backToAddGames = () => {
      router.push('/add-games')
    }
    
    return {
      gameName: gameInfo.name,
      gameIcon: gameInfo.icon,
      gameColor: gameInfo.color,
      gameDescription: gameInfo.description,
      progress: gameInfo.progress,
      backToHome,
      backToAddGames
    }
  }
}
</script>

<style scoped>
.under-development {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px 20px;
  color: white;
}

.development-container {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(20px);
  border-radius: 30px;
  padding: 60px 40px;
  text-align: center;
  max-width: 600px;
  width: 100%;
  box-shadow: 0 20px 60px rgba(0,0,0,0.3);
}

.development-icon {
  font-size: 5rem;
  margin-bottom: 20px;
  animation: bounce 2s infinite;
}

.development-title {
  font-size: 3rem;
  margin-bottom: 15px;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

.development-message {
  font-size: 1.3rem;
  margin-bottom: 10px;
  opacity: 0.9;
}

.development-subtitle {
  font-size: 1rem;
  opacity: 0.7;
  margin-bottom: 40px;
}

.game-info {
  background: rgba(255,255,255,0.1);
  border-radius: 20px;
  padding: 30px;
  margin: 30px 0;
}

.game-icon {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2.5rem;
  margin: 0 auto 20px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}

.game-name {
  font-size: 2rem;
  margin-bottom: 10px;
}

.game-description {
  font-size: 1.1rem;
  opacity: 0.8;
}

.progress-section {
  margin: 30px 0;
}

.progress-bar {
  width: 100%;
  height: 10px;
  background: rgba(255,255,255,0.2);
  border-radius: 5px;
  overflow: hidden;
  margin-bottom: 10px;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #4ecdc4, #44a08d);
  border-radius: 5px;
  transition: width 1s ease;
}

.progress-text {
  font-size: 1rem;
  opacity: 0.8;
}

.action-buttons {
  display: flex;
  gap: 20px;
  justify-content: center;
  margin: 30px 0;
}

.back-btn, .add-games-btn {
  padding: 12px 30px;
  font-size: 1.1rem;
  border: none;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s ease;
  color: white;
}

.back-btn {
  background: linear-gradient(135deg, #ff6b6b, #ee5a52);
}

.add-games-btn {
  background: linear-gradient(135deg, #4ecdc4, #44a08d);
}

.back-btn:hover, .add-games-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(0,0,0,0.3);
}

.coming-soon {
  margin-top: 40px;
}

.coming-soon h3 {
  font-size: 1.5rem;
  margin-bottom: 20px;
  opacity: 0.9;
}

.coming-games {
  display: flex;
  justify-content: center;
  gap: 30px;
}

.coming-game {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  opacity: 0.7;
  transition: opacity 0.3s ease;
}

.coming-game:hover {
  opacity: 1;
}

.game-emoji {
  font-size: 2rem;
}

@keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    transform: translateY(0);
  }
  40% {
    transform: translateY(-10px);
  }
  60% {
    transform: translateY(-5px);
  }
}

@media (max-width: 768px) {
  .development-container {
    padding: 40px 20px;
    margin: 20px;
  }
  
  .development-icon {
    font-size: 3rem;
  }
  
  .development-title {
    font-size: 2rem;
  }
  
  .development-message {
    font-size: 1.1rem;
  }
  
  .action-buttons {
    flex-direction: column;
    gap: 15px;
  }
  
  .coming-games {
    flex-direction: column;
    gap: 20px;
  }
}
</style>
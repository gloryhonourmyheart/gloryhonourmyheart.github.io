<template>
  <div class="add-games-container">
    <div class="header">
      <h1 class="title">添加更多游戏</h1>
      <p class="subtitle">选择您想要添加的游戏</p>
      <button @click="backToHome" class="back-btn">← 返回主界面</button>
    </div>
    
    <div class="games-grid">
      <div 
        v-for="game in availableGames" 
        :key="game.id" 
        class="game-card"
        @click="addGame(game)"
      >
        <div class="game-icon" :style="{ background: game.color }">
          {{ game.icon }}
        </div>
        <div class="game-info">
          <h3>{{ game.name }}</h3>
          <p>{{ game.description }}</p>
          <div class="game-status">
            <span class="status-badge">{{ game.status }}</span>
          </div>
        </div>
      </div>
    </div>
    
    <div class="footer">
      <p>更多精彩游戏正在开发中...</p>
    </div>
  </div>
</template>

<script>
import { useRouter } from 'vue-router'

export default {
  name: 'AddGames',
  setup() {
    const router = useRouter()
    
    const availableGames = [
      {
        id: 'minesweeper',
        name: '扫雷',
        icon: '💣',
        description: '避开地雷，标记安全区域',
        color: 'linear-gradient(135deg, #ff9800, #ffb74d)',
        status: '开发中'
      },
      {
        id: 'snake',
        name: '贪吃蛇',
        icon: '🐍',
        description: '控制小蛇吃食物，不断变长',
        color: 'linear-gradient(135deg, #4caf50, #81c784)',
        status: '开发中'
      },
      {
        id: 'tetris',
        name: '俄罗斯方块',
        icon: '🧩',
        description: '旋转下落方块，消除完整行',
        color: 'linear-gradient(135deg, #2196f3, #64b5f6)',
        status: '开发中'
      }
    ]
    
    const addGame = (game) => {
      // 跳转到开发未完成提示界面
      router.push(`/game/under-development/${game.id}`)
    }
    
    const backToHome = () => {
      router.push('/')
    }
    
    return {
      availableGames,
      addGame,
      backToHome
    }
  }
}
</script>

<style scoped>
.add-games-container {
  min-height: 100vh;
  padding: 40px 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.header {
  text-align: center;
  margin-bottom: 60px;
  position: relative;
}

.title {
  font-size: 3rem;
  color: white;
  text-shadow: 3px 3px 6px rgba(0,0,0,0.3);
  margin-bottom: 10px;
}

.subtitle {
  font-size: 1.2rem;
  color: rgba(255,255,255,0.8);
  margin-bottom: 20px;
}

.back-btn {
  background: rgba(255,255,255,0.2);
  border: 2px solid rgba(255,255,255,0.3);
  padding: 10px 20px;
  font-size: 1rem;
  color: white;
  border-radius: 20px;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.back-btn:hover {
  background: rgba(255,255,255,0.3);
  transform: translateX(-5px);
}

.games-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  max-width: 1000px;
  width: 100%;
  margin-bottom: 40px;
}

.game-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  padding: 25px;
  display: flex;
  align-items: center;
  gap: 20px;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 10px 30px rgba(0,0,0,0.1);
  backdrop-filter: blur(10px);
  position: relative;
}

.game-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 20px 40px rgba(0,0,0,0.2);
}

.game-icon {
  width: 70px;
  height: 70px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.8rem;
  font-weight: bold;
  color: white;
  box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.game-info {
  flex: 1;
}

.game-info h3 {
  font-size: 1.4rem;
  color: #333;
  margin-bottom: 8px;
}

.game-info p {
  color: #666;
  font-size: 0.9rem;
  line-height: 1.4;
  margin-bottom: 10px;
}

.game-status {
  display: flex;
  align-items: center;
}

.status-badge {
  background: linear-gradient(135deg, #ff6b6b, #ee5a52);
  color: white;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 0.8rem;
  font-weight: bold;
}

.footer {
  text-align: center;
  margin-top: 40px;
}

.footer p {
  color: rgba(255,255,255,0.7);
  font-size: 0.9rem;
}

@media (max-width: 768px) {
  .add-games-container {
    padding: 20px 15px;
  }
  
  .title {
    font-size: 2rem;
  }
  
  .games-grid {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .game-card {
    padding: 20px;
    flex-direction: column;
    text-align: center;
  }
  
  .game-icon {
    width: 60px;
    height: 60px;
    font-size: 1.5rem;
  }
}
</style>
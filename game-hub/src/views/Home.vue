<template>
  <div class="home-container">
    <div class="header">
      <h1 class="title">清悦休闲</h1>
      <p class="subtitle">选择你喜欢的游戏开始玩耍吧！</p>
    </div>
    
    <div class="games-grid">
      <div 
        v-for="game in games" 
        :key="game.id" 
        class="game-card"
        @click="selectGame(game)"
      >
        <div class="game-icon" :style="{ background: game.color }">
          {{ game.icon }}
        </div>
        <div class="game-info">
          <h3>{{ game.name }}</h3>
          <p>{{ game.description }}</p>
        </div>
      </div>
    </div>
    
    <div class="add-game-section">
      <button @click="goToAddGames" class="add-game-btn">
        <span class="add-icon">+</span>
        添加更多游戏
      </button>
    </div>
    
    <div class="footer">
      <p>护眼清新绿风格 · 为你的眼睛着想</p>
    </div>
  </div>
</template>

<script>
import { useRouter } from 'vue-router'

export default {
  name: 'Home',
  setup() {
    const router = useRouter()
    
    const games = [
      {
        id: '2048',
        name: '2048',
        icon: '2048',
        description: '滑动数字，合并方块，挑战2048！',
        color: 'linear-gradient(135deg, #5a8a6e, #8bb4ac)'
      },
      {
        id: 'yes-or-no',
        name: '要或不要',
        icon: '🎁',
        description: '3D互动游戏，选择筹码赢取惊喜礼物',
        color: 'linear-gradient(135deg, #ff6b6b, #ff4757)'
      }
    ]
    
    const selectGame = (game) => {
      if (game.id === 'yes-or-no') {
        router.push('/yes-or-no')
      } else {
        router.push(`/game/${game.id}`)
      }
    }
    
    const goToAddGames = () => {
      router.push('/add-games')
    }
    
    return {
      games,
      selectGame,
      goToAddGames
    }
  }
}
</script>

<style scoped>
.home-container {
  min-height: 100vh;
  padding: 40px 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.header {
  text-align: center;
  margin-bottom: 60px;
}

.title {
  font-size: 4rem;
  color: #2e7d32;
  text-shadow: 3px 3px 6px rgba(0,0,0,0.1);
  margin-bottom: 10px;
  animation: titlePulse 3s ease-in-out infinite;
}

.subtitle {
  font-size: 1.2rem;
  color: #4caf50;
  opacity: 0.8;
}

.games-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 30px;
  max-width: 1200px;
  width: 100%;
  margin-bottom: 40px;
}

.game-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  padding: 30px;
  display: flex;
  align-items: center;
  gap: 20px;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 10px 30px rgba(76, 175, 80, 0.1);
  backdrop-filter: blur(10px);
}

.game-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(76, 175, 80, 0.2);
}

.game-icon {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2rem;
  font-weight: bold;
  color: white;
  box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.game-info h3 {
  font-size: 1.5rem;
  color: #2e7d32;
  margin-bottom: 8px;
}

.game-info p {
  color: #66bb6a;
  font-size: 0.9rem;
  line-height: 1.4;
}

.add-game-section {
  text-align: center;
  margin: 40px 0;
}

.add-game-btn {
  background: linear-gradient(135deg, #4ecdc4, #44a08d);
  border: none;
  padding: 15px 30px;
  font-size: 1.1rem;
  color: white;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s ease;
  display: inline-flex;
  align-items: center;
  gap: 10px;
  box-shadow: 0 5px 15px rgba(78, 205, 196, 0.3);
}

.add-game-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(78, 205, 196, 0.4);
}

.add-icon {
  font-size: 1.5rem;
  font-weight: bold;
}

.footer {
  text-align: center;
  margin-top: 40px;
}

.footer p {
  color: #81c784;
  font-size: 0.9rem;
  opacity: 0.7;
}

@keyframes titlePulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

@media (max-width: 768px) {
  .home-container {
    padding: 20px 15px;
  }
  
  .title {
    font-size: 2.5rem;
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
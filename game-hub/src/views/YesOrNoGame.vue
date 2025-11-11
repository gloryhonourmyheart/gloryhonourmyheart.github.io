<template>
  <div class="yes-or-no-game">
    <!-- 游戏主界面 -->
    <div v-if="gameState === 'main'" class="game-main">
      <div class="game-header">
        <h1>要或不要</h1>
        <p>一个充满惊喜的3D互动游戏</p>
      </div>
      
      <div class="game-content">
        <div class="game-preview">
          <div class="preview-scene">
            <div class="table"></div>
            <div class="player player-left">
              <div class="player-avatar"></div>
              <div class="chips">
                <div class="chip yes-chip">要</div>
                <div class="chip no-chip">不要</div>
              </div>
            </div>
            <div class="player player-right">
              <div class="player-avatar"></div>
              <div class="pointing-hand"></div>
            </div>
            <div class="gift-box"></div>
          </div>
        </div>
        
        <button @click="startGame" class="start-btn">开始游戏</button>
      </div>
    </div>

    <!-- 3D游戏场景 -->
    <div v-if="gameState === 'playing'" class="game-scene">
      <div class="scene-container">
        <div class="table-3d">
          <div class="table-surface"></div>
          <div class="table-legs">
            <div class="leg"></div>
            <div class="leg"></div>
            <div class="leg"></div>
            <div class="leg"></div>
          </div>
        </div>
        
        <div class="player-3d player-left-3d">
          <div class="player-body">
            <div class="player-head"></div>
            <div class="player-torso"></div>
            <div class="player-arms">
              <div class="arm"></div>
              <div class="arm"></div>
            </div>
          </div>
          <div class="chips-3d">
            <div class="chip-3d yes-chip-3d" @click="selectChip('yes')">要</div>
            <div class="chip-3d no-chip-3d" @click="selectChip('no')">不要</div>
          </div>
        </div>
        
        <div class="player-3d player-right-3d">
          <div class="player-body">
            <div class="player-head"></div>
            <div class="player-torso"></div>
            <div class="player-arms">
              <div class="arm pointing-arm"></div>
              <div class="arm"></div>
            </div>
          </div>
        </div>
        
        <div v-if="showGiftBox" class="gift-box-3d" @click="openGift">
          <div class="box-lid"></div>
          <div class="box-body"></div>
        </div>
      </div>
      
      <div class="game-controls">
        <div v-if="!selectedChip" class="instruction">请选择筹码：要 或 不要</div>
        <div v-else class="instruction">已选择：{{ selectedChip === 'yes' ? '要' : '不要' }}</div>
      </div>
    </div>

    <!-- 礼物展示界面 -->
    <div v-if="gameState === 'gift'" class="gift-showcase">
      <div class="gift-header">
        <h2>恭喜！你获得了</h2>
      </div>
      
      <div class="gift-display">
        <div class="gift-item" v-for="(gift, index) in currentGifts" :key="index">
          <div class="gift-icon">{{ gift.icon }}</div>
          <div class="gift-name">{{ gift.name }}</div>
          <div class="gift-value">价值：{{ gift.value }}</div>
        </div>
      </div>
      
      <button @click="showCongrats" class="next-btn">继续</button>
    </div>

    <!-- 恭喜界面 -->
    <div v-if="gameState === 'congrats'" class="congrats-screen">
      <div class="congrats-content">
        <div class="confetti"></div>
        <h1>🎉 恭喜！ 🎉</h1>
        <p>你成功完成了游戏！</p>
        <div class="total-value">
          总价值：{{ totalValue }} 金币
        </div>
        <button @click="showSettlement" class="next-btn">查看结算</button>
      </div>
    </div>

    <!-- 结算界面 -->
    <div v-if="gameState === 'settlement'" class="settlement-screen">
      <div class="settlement-content">
        <h2>游戏结算</h2>
        
        <div class="result-summary">
          <div class="result-item">
            <span>选择：</span>
            <span class="chip-result">{{ selectedChip === 'yes' ? '要' : '不要' }}</span>
          </div>
          <div class="result-item">
            <span>获得礼物：</span>
            <span>{{ currentGifts.length }} 件</span>
          </div>
          <div class="result-item">
            <span>总价值：</span>
            <span class="total-value">{{ totalValue }} 金币</span>
          </div>
        </div>
        
        <div class="action-buttons">
          <button @click="restartGame" class="restart-btn">重新开始</button>
          <button @click="backToMain" class="back-btn">返回主界面</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'YesOrNoGame',
  data() {
    return {
      gameState: 'main', // main, playing, gift, congrats, settlement
      selectedChip: null,
      currentGifts: [],
      totalValue: 0,
      
      // 礼物库
      giftPool: [
        { icon: '💎', name: '钻石', value: 1000 },
        { icon: '🏆', name: '奖杯', value: 800 },
        { icon: '📱', name: '手机', value: 500 },
        { icon: '💻', name: '笔记本电脑', value: 1200 },
        { icon: '🎮', name: '游戏机', value: 300 },
        { icon: '📚', name: '书籍', value: 50 },
        { icon: '☕', name: '咖啡', value: 30 },
        { icon: '🎵', name: '耳机', value: 200 },
        { icon: '👕', name: 'T恤', value: 80 },
        { icon: '🍕', name: '披萨', value: 40 },
        { icon: '✈️', name: '机票', value: 1500 },
        { icon: '🏨', name: '酒店住宿', value: 600 },
        { icon: '🎫', name: '演唱会门票', value: 400 },
        { icon: '💄', name: '化妆品', value: 250 },
        { icon: '🏀', name: '篮球', value: 120 }
      ]
    }
  },
  methods: {
    startGame() {
      this.gameState = 'playing'
      this.selectedChip = null
      this.showGiftBox = false
    },
    
    selectChip(chip) {
      this.selectedChip = chip
      this.showGiftBox = true
      
      // 模拟延迟后自动打开礼盒
      setTimeout(() => {
        this.openGift()
      }, 2000)
    },
    
    openGift() {
      // 随机选择10个礼物
      this.currentGifts = this.getRandomGifts(10)
      this.totalValue = this.currentGifts.reduce((sum, gift) => sum + gift.value, 0)
      
      setTimeout(() => {
        this.gameState = 'gift'
      }, 1000)
    },
    
    getRandomGifts(count) {
      const shuffled = [...this.giftPool].sort(() => 0.5 - Math.random())
      return shuffled.slice(0, count)
    },
    
    showCongrats() {
      this.gameState = 'congrats'
    },
    
    showSettlement() {
      this.gameState = 'settlement'
    },
    
    restartGame() {
      this.gameState = 'main'
      this.currentGifts = []
      this.totalValue = 0
    },
    
    backToMain() {
      this.$router.push('/')
    }
  }
}
</script>

<style scoped>
.yes-or-no-game {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  font-family: 'Arial', sans-serif;
}

/* 游戏主界面样式 */
.game-main {
  padding: 2rem;
  text-align: center;
}

.game-header h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

.game-header p {
  font-size: 1.2rem;
  opacity: 0.8;
}

.game-content {
  margin-top: 3rem;
}

.preview-scene {
  width: 400px;
  height: 300px;
  margin: 0 auto 2rem;
  background: rgba(255,255,255,0.1);
  border-radius: 20px;
  position: relative;
  overflow: hidden;
}

.table {
  width: 200px;
  height: 100px;
  background: #8B4513;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  border-radius: 10px;
}

.player {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
}

.player-left {
  left: 50px;
}

.player-right {
  right: 50px;
}

.player-avatar {
  width: 60px;
  height: 60px;
  background: #ddd;
  border-radius: 50%;
  margin-bottom: 10px;
}

.chips {
  display: flex;
  gap: 10px;
}

.chip {
  width: 40px;
  height: 40px;
  background: gold;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  color: #333;
}

.pointing-hand {
  width: 30px;
  height: 30px;
  background: #ff6b6b;
  border-radius: 50%;
  position: relative;
}

.gift-box {
  width: 60px;
  height: 40px;
  background: #ff4757;
  position: absolute;
  top: 30%;
  left: 50%;
  transform: translateX(-50%);
  border-radius: 5px;
}

.start-btn {
  background: linear-gradient(45deg, #ff6b6b, #ee5a52);
  border: none;
  padding: 15px 40px;
  font-size: 1.2rem;
  color: white;
  border-radius: 25px;
  cursor: pointer;
  transition: transform 0.3s;
}

.start-btn:hover {
  transform: scale(1.05);
}

/* 3D游戏场景样式 */
.game-scene {
  height: 100vh;
  position: relative;
  perspective: 1000px;
}

.scene-container {
  width: 100%;
  height: 80%;
  position: relative;
  transform-style: preserve-3d;
}

.table-3d {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%) rotateX(60deg);
}

.table-surface {
  width: 300px;
  height: 150px;
  background: #8B4513;
  border-radius: 10px;
  position: relative;
}

.table-legs {
  display: flex;
  justify-content: space-around;
  margin-top: -20px;
}

.leg {
  width: 20px;
  height: 80px;
  background: #654321;
}

.player-3d {
  position: absolute;
  top: 40%;
  transform-style: preserve-3d;
}

.player-left-3d {
  left: 20%;
}

.player-right-3d {
  right: 20%;
}

.player-body {
  position: relative;
}

.player-head {
  width: 40px;
  height: 40px;
  background: #ffd700;
  border-radius: 50%;
  margin: 0 auto;
}

.player-torso {
  width: 60px;
  height: 80px;
  background: #4a90e2;
  margin: 0 auto;
}

.player-arms {
  display: flex;
  justify-content: space-around;
  margin-top: 10px;
}

.arm {
  width: 60px;
  height: 10px;
  background: #4a90e2;
}

.pointing-arm {
  background: #ff6b6b;
  transform: rotate(-30deg);
}

.chips-3d {
  display: flex;
  gap: 20px;
  margin-top: 20px;
  justify-content: center;
}

.chip-3d {
  width: 50px;
  height: 50px;
  background: gold;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  color: #333;
  cursor: pointer;
  transition: transform 0.3s;
  transform-style: preserve-3d;
}

.chip-3d:hover {
  transform: scale(1.1) rotateY(180deg);
}

.gift-box-3d {
  position: absolute;
  top: 30%;
  left: 50%;
  transform: translateX(-50%);
  cursor: pointer;
}

.box-body {
  width: 80px;
  height: 60px;
  background: #ff4757;
  border-radius: 5px;
}

.box-lid {
  width: 90px;
  height: 10px;
  background: #ff6b6b;
  border-radius: 5px 5px 0 0;
  margin-bottom: -5px;
}

.game-controls {
  position: absolute;
  bottom: 20px;
  left: 0;
  right: 0;
  text-align: center;
}

.instruction {
  font-size: 1.2rem;
  background: rgba(0,0,0,0.3);
  padding: 10px 20px;
  border-radius: 20px;
  display: inline-block;
}

/* 礼物展示样式 */
.gift-showcase {
  padding: 2rem;
  text-align: center;
}

.gift-header h2 {
  font-size: 2.5rem;
  margin-bottom: 2rem;
}

.gift-display {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  max-width: 1000px;
  margin: 0 auto 2rem;
}

.gift-item {
  background: rgba(255,255,255,0.1);
  padding: 1rem;
  border-radius: 10px;
  backdrop-filter: blur(10px);
}

.gift-icon {
  font-size: 3rem;
  margin-bottom: 0.5rem;
}

.gift-name {
  font-size: 1.1rem;
  font-weight: bold;
  margin-bottom: 0.5rem;
}

.gift-value {
  opacity: 0.8;
}

.next-btn {
  background: linear-gradient(45deg, #4ecdc4, #44a08d);
  border: none;
  padding: 12px 30px;
  font-size: 1.1rem;
  color: white;
  border-radius: 20px;
  cursor: pointer;
}

/* 恭喜界面样式 */
.congrats-screen {
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.congrats-content h1 {
  font-size: 4rem;
  margin-bottom: 1rem;
}

.total-value {
  font-size: 2rem;
  margin: 2rem 0;
  color: gold;
}

/* 结算界面样式 */
.settlement-screen {
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.settlement-content {
  background: rgba(255,255,255,0.1);
  padding: 3rem;
  border-radius: 20px;
  backdrop-filter: blur(10px);
  text-align: center;
}

.result-summary {
  margin: 2rem 0;
}

.result-item {
  display: flex;
  justify-content: space-between;
  margin: 1rem 0;
  font-size: 1.2rem;
}

.chip-result {
  color: gold;
  font-weight: bold;
}

.action-buttons {
  display: flex;
  gap: 20px;
  justify-content: center;
}

.restart-btn {
  background: linear-gradient(45deg, #ff6b6b, #ee5a52);
}

.back-btn {
  background: linear-gradient(45deg, #4ecdc4, #44a08d);
}

.restart-btn, .back-btn {
  border: none;
  padding: 12px 30px;
  font-size: 1.1rem;
  color: white;
  border-radius: 20px;
  cursor: pointer;
}

/* 动画效果 */
@keyframes confetti {
  0% { transform: translateY(-100px) rotate(0deg); }
  100% { transform: translateY(100vh) rotate(360deg); }
}

.confetti {
  position: absolute;
  width: 10px;
  height: 10px;
  background: gold;
  animation: confetti 2s infinite;
}
</style>
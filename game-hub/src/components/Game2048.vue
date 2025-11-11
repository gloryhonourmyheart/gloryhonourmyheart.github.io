<template>
  <div class="game-2048">
    <div class="game-header">
      <div class="scores">
        <div class="score-box">
          <div class="score-title">分数</div>
          <div class="score">{{ score }}</div>
        </div>
        <div class="score-box">
          <div class="score-title">最高分</div>
          <div class="high-score">{{ highScore }}</div>
        </div>
      </div>
      <div class="controls">
        <button class="new-game-btn" @click="newGame">新游戏</button>
        <button class="undo-btn" @click="undoMove" :disabled="moveHistory.length === 0">↩️ 撤销</button>
      </div>
    </div>
    
    <div class="grid-container">
      <div class="grid">
        <div 
          v-for="(row, rowIndex) in grid" 
          :key="rowIndex" 
          class="grid-row"
        >
          <div 
            v-for="(cell, colIndex) in row" 
            :key="colIndex" 
            class="cell"
          ></div>
        </div>
        
        <div 
          v-for="tile in activeTiles" 
          :key="`${tile.row}-${tile.col}`"
          class="tile"
          :class="`tile-${tile.value}`"
          :style="{
            left: `${tile.col * 25}%`,
            top: `${tile.row * 25}%`,
            width: 'calc(25% - 12px)',
            height: 'calc(25% - 12px)'
          }"
        >
          {{ tile.value }}
        </div>
      </div>
    </div>
    
    <div class="tips">使用方向键 ↑ ↓ ← → 或手指滑动</div>
    
    <div v-if="gameOver" class="game-over-overlay">
      <div class="game-over-message">
        <h3>游戏结束！</h3>
        <p>得分：{{ score }}</p>
        <p>最高分：{{ highScore }}</p>
        <button @click="newGame">再玩一次</button>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, computed, onMounted, onUnmounted } from 'vue'

export default {
  name: 'Game2048',
  emits: ['game-over'],
  setup(props, { emit }) {
    const gridSize = 4
    const grid = ref(Array(gridSize).fill().map(() => Array(gridSize).fill(0)))
    const score = ref(0)
    const highScore = ref(parseInt(localStorage.getItem('2048_highScore')) || 0)
    const moveHistory = ref([])
    const gameOver = ref(false)
    const animating = ref(false)
    const MAX_UNDO_STEPS = 3

    const activeTiles = computed(() => {
      const tiles = []
      for (let i = 0; i < gridSize; i++) {
        for (let j = 0; j < gridSize; j++) {
          if (grid.value[i][j] !== 0) {
            tiles.push({
              row: i,
              col: j,
              value: grid.value[i][j]
            })
          }
        }
      }
      return tiles
    })

    const initGame = () => {
      grid.value = Array(gridSize).fill().map(() => Array(gridSize).fill(0))
      score.value = 0
      moveHistory.value = []
      gameOver.value = false
      animating.value = false
      
      addNewTile()
      addNewTile()
      updateHighScore()
    }

    const addNewTile = () => {
      const emptyCells = []
      for (let i = 0; i < gridSize; i++) {
        for (let j = 0; j < gridSize; j++) {
          if (grid.value[i][j] === 0) emptyCells.push({ row: i, col: j })
        }
      }
      
      if (emptyCells.length > 0) {
        const randomCell = emptyCells[Math.floor(Math.random() * emptyCells.length)]
        grid.value[randomCell.row][randomCell.col] = Math.random() < 0.9 ? 2 : 4
      }
    }

    const saveToHistory = () => {
      if (moveHistory.value.length >= MAX_UNDO_STEPS) {
        moveHistory.value.shift()
      }
      moveHistory.value.push({
        grid: JSON.parse(JSON.stringify(grid.value)),
        score: score.value
      })
    }

    const undoMove = () => {
      if (animating.value || moveHistory.value.length === 0) return
      
      const lastState = moveHistory.value.pop()
      grid.value = Array(gridSize).fill().map((_, i) => [...lastState.grid[i]])
      score.value = lastState.score
      gameOver.value = false
    }

    const move = (direction) => {
      if (animating.value || gameOver.value) return false
      
      animating.value = true
      saveToHistory()
      
      const tempGrid = JSON.parse(JSON.stringify(grid.value))
      let moved = false
      
      if (direction === 'left') {
        for (let i = 0; i < gridSize; i++) {
          let row = grid.value[i].filter(cell => cell !== 0)
          for (let j = 0; j < row.length - 1; j++) {
            if (row[j] === row[j + 1]) {
              row[j] *= 2
              score.value += row[j]
              row.splice(j + 1, 1)
              j++
            }
          }
          while (row.length < gridSize) row.push(0)
          grid.value[i] = row
        }
      } else if (direction === 'right') {
        for (let i = 0; i < gridSize; i++) {
          let row = grid.value[i].filter(cell => cell !== 0)
          for (let j = row.length - 1; j > 0; j--) {
            if (row[j] === row[j - 1]) {
              row[j] *= 2
              score.value += row[j]
              row.splice(j - 1, 1)
              j--
            }
          }
          while (row.length < gridSize) row.unshift(0)
          grid.value[i] = row
        }
      } else if (direction === 'up') {
        for (let j = 0; j < gridSize; j++) {
          let column = []
          for (let i = 0; i < gridSize; i++) {
            if (grid.value[i][j] !== 0) column.push(grid.value[i][j])
          }
          for (let i = 0; i < column.length - 1; i++) {
            if (column[i] === column[i + 1]) {
              column[i] *= 2
              score.value += column[i]
              column.splice(i + 1, 1)
              i++
            }
          }
          while (column.length < gridSize) column.push(0)
          for (let i = 0; i < gridSize; i++) {
            grid.value[i][j] = column[i]
          }
        }
      } else if (direction === 'down') {
        for (let j = 0; j < gridSize; j++) {
          let column = []
          for (let i = 0; i < gridSize; i++) {
            if (grid.value[i][j] !== 0) column.push(grid.value[i][j])
          }
          for (let i = column.length - 1; i > 0; i--) {
            if (column[i] === column[i - 1]) {
              column[i] *= 2
              score.value += column[i]
              column.splice(i - 1, 1)
              i--
            }
          }
          while (column.length < gridSize) column.unshift(0)
          for (let i = 0; i < gridSize; i++) {
            grid.value[i][j] = column[i]
          }
        }
      }
      
      if (!arraysEqual(tempGrid, grid.value)) {
        moved = true
        setTimeout(() => {
          addNewTile()
          checkGameOver()
          updateHighScore()
          animating.value = false
        }, 200)
      } else {
        animating.value = false
      }
      
      return moved
    }

    const arraysEqual = (arr1, arr2) => {
      if (arr1.length !== arr2.length) return false
      for (let i = 0; i < arr1.length; i++) {
        if (arr1[i].length !== arr2[i].length) return false
        for (let j = 0; j < arr1[i].length; j++) {
          if (arr1[i][j] !== arr2[i][j]) return false
        }
      }
      return true
    }

    const checkGameOver = () => {
      // 检查是否有空格
      for (let i = 0; i < gridSize; i++) {
        for (let j = 0; j < gridSize; j++) {
          if (grid.value[i][j] === 0) return false
        }
      }
      
      // 检查相邻格子
      for (let i = 0; i < gridSize; i++) {
        for (let j = 0; j < gridSize; j++) {
          if (j < gridSize - 1 && grid.value[i][j] === grid.value[i][j + 1]) return false
          if (i < gridSize - 1 && grid.value[i][j] === grid.value[i + 1][j]) return false
        }
      }
      
      gameOver.value = true
      emit('game-over', score.value)
    }

    const updateHighScore = () => {
      if (score.value > highScore.value) {
        highScore.value = score.value
        localStorage.setItem('2048_highScore', highScore.value.toString())
      }
    }

    const newGame = () => {
      initGame()
    }

    const handleKeydown = (e) => {
      if (['ArrowLeft', 'ArrowRight', 'ArrowUp', 'ArrowDown'].includes(e.key)) {
        e.preventDefault()
        const direction = e.key.replace('Arrow', '').toLowerCase()
        move(direction)
      }
    }

    let touchStartX = 0
    let touchStartY = 0

    const handleTouchStart = (e) => {
      touchStartX = e.touches[0].clientX
      touchStartY = e.touches[0].clientY
    }

    const handleTouchEnd = (e) => {
      const touchEndX = e.changedTouches[0].clientX
      const touchEndY = e.changedTouches[0].clientY
      const dx = touchEndX - touchStartX
      const dy = touchEndY - touchStartY
      
      if (Math.abs(dx) > 50 || Math.abs(dy) > 50) {
        if (Math.abs(dx) > Math.abs(dy)) {
          if (dx > 50) move('right')
          else if (dx < -50) move('left')
        } else {
          if (dy > 50) move('down')
          else if (dy < -50) move('up')
        }
      }
    }

    onMounted(() => {
      initGame()
      document.addEventListener('keydown', handleKeydown)
      document.addEventListener('touchstart', handleTouchStart, { passive: true })
      document.addEventListener('touchend', handleTouchEnd, { passive: true })
    })

    onUnmounted(() => {
      document.removeEventListener('keydown', handleKeydown)
      document.removeEventListener('touchstart', handleTouchStart)
      document.removeEventListener('touchend', handleTouchEnd)
    })

    return {
      grid,
      score,
      highScore,
      moveHistory,
      gameOver,
      activeTiles,
      newGame,
      undoMove
    }
  }
}
</script>

<style scoped>
.game-2048 {
  max-width: 500px;
  margin: 0 auto;
  padding: 20px;
}

.game-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 15px;
}

.scores {
  display: flex;
  gap: 10px;
}

.score-box {
  background-color: #b3d6c6;
  padding: 8px 15px;
  border-radius: 8px;
  text-align: center;
  color: #4a7b6f;
  font-weight: bold;
  box-shadow: 0 3px 6px rgba(0,0,0,0.1);
  min-width: 60px;
}

.score-title {
  font-size: 14px;
}

.score, .high-score {
  font-size: 22px;
  margin-top: 2px;
}

.controls {
  display: flex;
  gap: 10px;
}

.new-game-btn, .undo-btn {
  background-color: #9bc4bc;
  color: white;
  padding: 10px 15px;
  border-radius: 8px;
  border: none;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s;
}

.new-game-btn:hover, .undo-btn:hover:not(:disabled) {
  background-color: #8bb4ac;
  transform: translateY(-2px);
}

.undo-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.grid-container {
  background-color: #c8e0d2;
  border-radius: 12px;
  padding: 15px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
  position: relative;
  aspect-ratio: 1;
}

.grid {
  position: relative;
  width: 100%;
  height: 100%;
}

.grid-row {
  display: flex;
  height: 25%;
}

.cell {
  background-color: rgba(200, 224, 210, 0.3);
  border-radius: 8px;
  flex: 1;
  margin: 5px;
}

.tile {
  position: absolute;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 35px;
  font-weight: bold;
  border-radius: 8px;
  transition: all 0.15s ease;
  z-index: 2;
  margin: 5px;
}

.tile-2 { background-color: #e2f3e4; color: #6b8c7d; }
.tile-4 { background-color: #c5e6c6; color: #5a8a6e; }
.tile-8 { background-color: #a8d8b9; color: #ffffff; box-shadow: 0 3px 6px rgba(0,100,80,0.1); }
.tile-16 { background-color: #8bcbae; color: #ffffff; box-shadow: 0 3px 6px rgba(0,100,80,0.2); }
.tile-32 { background-color: #6fbfa3; color: #ffffff; box-shadow: 0 3px 6px rgba(0,100,80,0.3); }
.tile-64 { background-color: #55b798; color: #ffffff; box-shadow: 0 3px 6px rgba(0,100,80,0.4); }
.tile-128 { background-color: #3cad8e; color: #ffffff; box-shadow: 0 3px 6px rgba(0,100,80,0.5); font-size: 30px; }
.tile-256 { background-color: #27a384; color: #ffffff; box-shadow: 0 3px 6px rgba(0,100,80,0.6); font-size: 30px; }
.tile-512 { background-color: #0f997a; color: #ffffff; box-shadow: 0 3px 6px rgba(0,100,80,0.7); font-size: 30px; }
.tile-1024 { background-color: #008c6f; color: #ffffff; box-shadow: 0 3px 6px rgba(0,100,80,0.8); font-size: 25px; }
.tile-2048 { background-color: #007f63; color: #ffffff; box-shadow: 0 3px 6px rgba(0,100,80,0.9); font-size: 25px; }

.tips {
  text-align: center;
  margin-top: 15px;
  color: #7a9c8e;
  font-size: 14px;
}

.game-over-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  z-index: 10;
}

.game-over-message {
  background: white;
  padding: 30px;
  border-radius: 15px;
  text-align: center;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}

.game-over-message h3 {
  color: #d32f2f;
  margin-bottom: 15px;
}

.game-over-message p {
  margin: 10px 0;
  color: #666;
}

.game-over-message button {
  background: #4caf50;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 20px;
  cursor: pointer;
  margin-top: 15px;
  font-size: 16px;
}

@media (max-width: 500px) {
  .game-header {
    flex-direction: column;
    align-items: stretch;
  }
  
  .scores {
    justify-content: center;
  }
  
  .controls {
    justify-content: center;
  }
  
  .tile {
    font-size: 25px;
  }
  
  .tile-128, .tile-256, .tile-512 {
    font-size: 22px;
  }
  
  .tile-1024, .tile-2048 {
    font-size: 18px;
  }
}
</style>
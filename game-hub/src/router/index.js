import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Game from '../views/Game.vue'
import Register from '../views/Register.vue'
import YesOrNoGame from '../views/YesOrNoGame.vue'
import AddGames from '../views/AddGames.vue'
import UnderDevelopment from '../views/UnderDevelopment.vue'
import Login from '../views/Login.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/game/:id',
    name: 'Game',
    component: Game
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  },
  {
    path: '/yes-or-no',
    name: 'YesOrNoGame',
    component: YesOrNoGame
  },
  {
    path: '/add-games',
    name: 'AddGames',
    component: AddGames
  },
  {
    path: '/game/under-development/:id',
    name: 'UnderDevelopment',
    component: UnderDevelopment
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
import { createRouter, createWebHistory } from 'vue-router'
import Homepage from '../components/Homepage.vue'
import Login from '../components/Login.vue'
import ChangePassword from '../components/ChangePassword.vue'

const routes = [
  {
    path: '/',
    name: 'Homepage',
    component: Homepage
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/change-password',
    name: 'ChangePassword',
    component: ChangePassword
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router

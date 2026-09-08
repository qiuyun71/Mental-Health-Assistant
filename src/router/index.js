import { createRouter, createWebHistory } from 'vue-router'
import BackLayout from '../views/BackLayout.vue'

const backRoutes = [
  {
    path: '/back',
    component: BackLayout,
    children: [
      {
        path: '/back/dashboard',
        component: () => import('../views/Dashboard.vue'),
      }
    ]
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes: backRoutes,
})

export default router
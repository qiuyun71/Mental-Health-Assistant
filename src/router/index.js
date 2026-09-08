import { createRouter, createWebHistory } from 'vue-router'
import BackLayout from '../components/BackLayout.vue'

const backRoutes = [
  {
    path: '/back',
    component: BackLayout,
    children: [
      {
        path: 'dashboard',
        component: () => import('../views/Dashboard.vue'),
        meta: {
          title: '数据分析',
          icon: 'odometer',
        }
      },
      {
        path: 'knowledge',
        component: () => import('../views/Knowledge.vue'),
        meta: {
          title: '知识文章',
          icon: 'document',
        }
      },
      {
        path: 'consultations',
        component: () => import('../views/Consultations.vue'),
        meta: {
          title: '咨询记录',
          icon: 'notebook',
        }
      },
      {
        path: 'emotional',
        component: () => import('../views/Emotional.vue'),
        meta: {
          title: '情绪日志',
          icon: 'sunny',
        }
      }
    ]
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes: backRoutes,
})

export default router
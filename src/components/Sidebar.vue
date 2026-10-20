<template>
    <el-aside :width="isCollapse ? '64px' : '264px'">
        <el-menu :collapse="isCollapse" :collapse-transition="false" default-active="2" class="menu-style">
            <div class="brand">
                <el-image style="width: 50px; height: 50px; margin-right: 10px;" :src="iconUrl" alt="logo" />
                <div v-show="!isCollapse" class="info-card">
                    <h1 class="brand-title">心理健康AI助手</h1>
                    <p class="brand-subtitle">管理后台</p>
                </div>
            </div>
            <el-menu-item @click="selectMenu" v-for="item in router.options.routes[0].children" :key="item.path"
                :index="item.path">
                <el-icon>
                    <component :is="item.meta.icon" />
                </el-icon>
                <span>{{ item.meta.title }}</span>
            </el-menu-item>
        </el-menu>
    </el-aside>
</template>
<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAdminStore } from '@/stores/admin'
const router = useRouter()//router获取整个路由配置，而useroute获取当前路由信息,这里读路由表，需要用router.options.routes

// 图片地址需在 JS 中先生成再绑定：el-image 是自定义组件，模板里直接把 '@/assets/...' 当静态属性写不会被构建工具解析，浏览器会 404
// new URL(相对路径, import.meta.url).href：以当前模块为基准，解析出打包后的真实地址字符串
// 固定图片也可用更简洁的等价写法：import iconUrl from '@/assets/images/机器人.png'，直接是字符串
// 二者取舍：路径写死的固定图片，用 import 更好——更短、意图更直接（项目里 frontendKnowledge.vue 就是这么写的）
// new URL 更适合文件名要在运行时才能确定的场景，例：new URL(`../assets/images/${name}.png`, import.meta.url).href
const iconUrl = new URL('@/assets/images/机器人.png', import.meta.url).href

const isCollapse = computed(() => useAdminStore().isCollapse)

const selectMenu = (key) => {
    console.log(key)
    const currentRoute = router.options.routes[0]
    router.push(`${currentRoute.path}/${key.index}`)
}

</script>
<style lang="scss" scoped>
.menu-style {
    height: 100%;

    .brand {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 10px;
        background-color: #fff;
        border-bottom: 1px solid #e5e7eb;

        .info-card {
            .brand-title {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 5px;
                color: #1f2937;
            }

            .brand-subtitle {
                font-size: 14px;
                color: #6b7280;
            }
        }
    }
}
</style>

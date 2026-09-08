<template>
    <div class="backend-layout">
        <el-container>
            <Sidebar />
            <el-container>
                <Navbar />
                <el-main>
                    <router-view />
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>

<script setup>
import Sidebar from './Sidebar.vue';
import Navbar from './Navbar.vue';
</script>

<style lang="scss" scoped>
.backend-layout {
    height: 100vh;
}
</style>
<template>
    <el-form ref="ruleFormRef" :model="formData">
        <el-row :gutter="24">
            <template v-for="item in formItemAttrs" :key="item.prop">
                <!-- v-bind 不带参数、直接绑定对象时，会把对象里的每个键展开成一个独立属性：
                     item.col = { xs: 24, sm: 12, md: 8, lg: 6, xl: 6 }
                     等价于 <el-col :xs="24" :sm="12" :md="8" :lg="6" :xl="6">，
                     即 Element Plus 的响应式栅格属性，按屏幕宽度控制每个搜索项占的列宽 -->
                <el-col v-bind="item.col">
                    <el-form-item :label="item.label" :prop="item.prop">
                        <component v-model="formData[item.prop]" :is="isComp(item.comp)"
                            :placeholder="item.placeholder">
                            <template v-if="item.comp === 'select'">
                                <el-option label="全部" value="" />
                                <el-option v-for="opt in item.options" :key="opt.value" :label="opt.label"
                                    :value="opt.value" />
                            </template>
                        </component>
                    </el-form-item>
                </el-col>
            </template>
        </el-row>
        <el-row>
            <el-button type="primary" @click="handleSearch">查询</el-button>
            <el-button @click="handleReset(ruleFormRef)">重置</el-button>
        </el-row>
    </el-form>
</template>
<script setup>
import { ref, reactive, computed } from 'vue'

const props = defineProps({
    formItem: {
        type: Array,
        default: () => []
    }
})
const emit = defineEmits(['search'])

const formItemAttrs = computed(() => {
    const { formItem } = props
    formItem.forEach(item => {
        item.col = { xs: 24, sm: 12, md: 8, lg: 6, xl: 6 }
    })
    return formItem
})

// 表单数据
const ruleFormRef = ref()
const formData = reactive({})
const isComp = (comp) => {
    return {
        input: 'elInput',
        select: 'elSelect'
    }[comp]
}

const handleSearch = () => {
    emit('search', formData)
}
const handleReset = (formEl) => {
    // 先重置表单，然后在触发查询
    if (!formEl) return
    formEl.resetFields()
    emit('search', formData)
}
</script>
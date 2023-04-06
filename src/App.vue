<template>
  <router-view v-slot="{ Component }">
    <keep-alive>
      <transition :name="page_animation">
        <component :is="Component"/>
      </transition>
    </keep-alive>
  </router-view>
</template>

<script setup lang="ts">
import {useRouter} from "vue-router";
import {ref, watch} from "vue";

const router = useRouter()
const page_animation = ref<PageAnimation>()

watch(() => router.currentRoute.value, (new_value, old_value) => {
  page_animation.value = new_value.meta.depth > old_value.meta.depth ? "switch-left" : "switch-right"
})
</script>

<style lang="less" scoped>
</style>

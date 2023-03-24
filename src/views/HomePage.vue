<template>
  <home-header/>
  <div>
    <router-view v-slot="{ Component }">
      <keep-alive>
        <transition :name="page_animation">
          <component :is="Component"/>
        </transition>
      </keep-alive>
    </router-view>
  </div>

  <transition enter-active-class="animate__animated animate__fadeInUp" appear>
    <home-navbar v-model:active="navbar_active"/>
  </transition>
</template>


<script lang="ts" setup>
import HomeHeader from "@/components/home/HomeHeader.vue";
import HomeNavbar from "@/components/home/HomeNavbar.vue";

import {ref, watch, ComponentPublicInstance} from "vue"

interface VM extends ComponentPublicInstance {
  navbar_active: number
}

const navbar_active = ref<number>(0)
const page_animation = ref<"switch-left" | "switch-right">("switch-left")
watch(navbar_active, (newValue, oldValue) => {
  if (newValue > oldValue) {
    page_animation.value = "switch-left"
  } else {
    page_animation.value = "switch-right"
  }
})

defineExpose({navbar_active})
defineOptions({
  name: "HomePage",
  beforeRouteEnter(to, from, next) {
    next(vm => {
      const instance = vm as VM
      instance.navbar_active = <number>to.meta.navbar_active;
    })
  }
})
</script>


<style lang="less" scoped>

</style>

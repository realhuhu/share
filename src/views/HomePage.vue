<template>
  <div>
    <transition enter-active-class="animate__animated animate__fadeInUp" appear>
      <home-navbar class="md:hidden" v-model:active="navbar_active"/>
    </transition>

    <home-sidebar class="hidden md:flex" v-model:active="navbar_active"/>

    <router-view v-slot="{ Component }">
      <transition :name="page_animation || undefined" @after-enter="page_animation=undefined">
        <keep-alive>
          <component class="pt-12 md:ml-16 md:pt-0" :is="Component"/>
        </keep-alive>
      </transition>
    </router-view>
  </div>
</template>


<script lang="ts" setup>
import HomeNavbar from "@/components/home/HomeNavbar.vue";

import {ref, watch, ComponentPublicInstance} from "vue"
import HomeSidebar from "@/components/home/HomeSidebar.vue";

interface VM extends ComponentPublicInstance {
  navbar_active: number
}

const navbar_active = ref<number>(0)
const page_animation = ref<PageAnimation>()


watch(navbar_active, (newValue, oldValue) => {
  if (window.innerWidth >= 768) {
    page_animation.value = undefined
    return
  }
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

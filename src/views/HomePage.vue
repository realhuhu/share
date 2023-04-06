<template>
  <div>
    <home-header class="md:hidden"/>

    <transition enter-active-class="animate__animated animate__fadeInUp" appear>
      <home-navbar class="md:hidden" v-model:active="navbar_active"/>
    </transition>

    <home-sidebar class="hidden md:flex" v-model:active="navbar_active"/>

    <div>
      <router-view v-slot="{ Component }">
        <keep-alive>
          <transition :name="page_animation || undefined">
            <component :is="Component"/>
          </transition>
        </keep-alive>
      </router-view>
    </div>
  </div>
</template>


<script lang="ts" setup>
import HomeHeader from "@/components/home/HomeHeader.vue";
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
    page_animation.value = null
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

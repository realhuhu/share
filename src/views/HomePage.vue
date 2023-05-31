<template>
  <div>
    <transition enter-active-class="animate__animated animate__fadeInUp" appear>
      <home-navbar class="md:hidden" v-model:active="navbar_active"/>
    </transition>


    <router-view v-slot="{ Component }">
      <keep-alive>
        <component :is="Component"/>
      </keep-alive>
    </router-view>
  </div>
</template>


<script lang="ts" setup>
import {ref, watch, ComponentPublicInstance} from "vue"
import {UseStore} from "@/store";

interface VM extends ComponentPublicInstance {
  navbar_active: number
}

const store = UseStore()
const navbar_active = ref<number>(0)
const page_animation = ref<PageAnimation>()


watch(navbar_active, (newValue, oldValue) => {
  if (!store.is_mobile) {
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

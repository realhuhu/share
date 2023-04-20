<template>

  <router-view v-slot="{ Component }">
    <transition :name="page_animation">
      <component v-if="show_help" :is="Component"/>
      <meta-mask-help v-else/>
    </transition>
  </router-view>

  <register-modal/>
</template>

<script setup lang="ts">
import {useRoute, useRouter} from "vue-router";
import {computed, ref, watch} from "vue";
import {UseStore} from "@/store";
import MetaMaskHelp from "@/components/fullscreen/MetaMaskHelp.vue";

const router = useRouter()
const route = useRoute()
const store = UseStore()
const page_animation = ref<PageAnimation>()

store.connectEthereum()

const show_help = computed(() => {
  if (store.ethereum_type === "metamask") {
    if (store.ethereum_chain_id !== store.correct_chain_id) return false
    if (route.meta.auth && !store.contracts_connected) return false
  }
  return true
})

watch(() => router.currentRoute.value, (new_value, old_value) => {
  if (window.innerWidth >= 768 || old_value.path === "/") {
    page_animation.value = undefined
    return
  }
  page_animation.value = new_value.meta.depth > old_value.meta.depth ? "scale-push" : "scale-pop"
})
</script>

<style lang="less" scoped>
</style>

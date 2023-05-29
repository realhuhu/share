<template>
  <router-view v-slot="{ Component }" class="md:pl-[64px]">
    <suspense v-if="show">
      <!--    <transition :name="page_animation">-->
      <component :is="Component"/>
      <!--    </transition>-->
      <template #fallback>
        加载中...
      </template>
    </suspense>

    <access-help v-else/>
  </router-view>

  <home-sidebar class="hidden md:flex"/>
  <register-modal/>
  <default-wallet-modal/>
</template>

<script setup lang="ts">
import {useRoute, useRouter} from "vue-router";
import {computed, ref, watch} from "vue";
import {UseStore} from "@/store";
import AccessHelp from "@/components/fullscreen/AccessHelp.vue";
import HomeSidebar from "@/components/home/HomeSidebar.vue";

const router = useRouter()
const route = useRoute()
const store = UseStore()
const page_animation = ref<PageAnimation>()

store.connectEthereum()

const show = computed(() => {
  if (store.ethereum_type === "metamask") {
    if (store.ethereum_chain_id !== store.correct_chain_id) return false
    if (route.meta.auth && !store.contracts_connected) return false
  }
  return true
})

watch(show, (new_value: boolean) => {
  if (store.is_mobile) page_animation.value = !new_value ? "scale-push" : "scale-pop"
})

watch(() => router.currentRoute.value, (new_value, old_value) => {
  if (!store.is_mobile || old_value.path === "/") {
    page_animation.value = undefined
    return
  }
  page_animation.value = new_value.meta.depth > old_value.meta.depth ? "scale-push" : "scale-pop"
})
</script>

<style lang="less" scoped>
</style>

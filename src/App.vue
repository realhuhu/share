<template>
  <router-view v-slot="{ Component }" class="md:pl-[64px]">

    <suspense v-if="show">
      <transition @after-enter="to_top" :name="page_animation">
        <keep-alive :include="include">
          <component :is="Component"/>
        </keep-alive>
      </transition>

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
const page_animation = ref()
const include = ref<string[]>(["HomePage"])
const init = ref()

store.connectEthereum()

const to_top = () => {
  if (route.meta.keep_alive && route.name !== init.value) return
  window.scrollTo(0, 0)
}

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

watch(() => router.currentRoute.value, (to, from) => {
  if (typeof to.name === "string" && typeof from.name === "string") {
    init.value = undefined
    if (to.meta.keep_alive) {
      if (include.value.indexOf(to.name) === -1) {
        init.value = to.name
        include.value.push(to.name);
      }
    }

    if (from.meta.keep_alive && to.meta.depth < from.meta.depth) {
      let index = include.value.indexOf(from.name);
      index !== -1 && include.value.splice(index, 1);
    }
  }

  if (store.is_mobile) {
    if (to.meta.depth === from.meta.depth) {
      page_animation.value = ""
    } else {
      page_animation.value = to.meta.depth > from.meta.depth ? "steady-left" : "right-steady"
    }
  }


  // if (from.name === 'Article' && to.name === "PostArticle") {
  //   let index = include.value.indexOf(from.name);
  //   index !== -1 && include.value.splice(index, 1);
  // }
  // if (!store.is_mobile || old_value.path === "/") {
  //   page_animation.value = undefined
  //   return
  // }
  // page_animation.value = new_value.meta.depth > old_value.meta.depth ? "scale-push" : "scale-pop"
})
</script>

<style lang="less" scoped>
</style>

<template>
  <router-view v-slot="{ Component }">
    <keep-alive>
      <transition :name="page_animation || undefined">
        <component :is="Component"/>
      </transition>
    </keep-alive>
  </router-view>
</template>

<script setup lang="ts">
import {useRouter} from "vue-router";
import {ref, watch} from "vue";
// import {ethers} from "ethers";
// import {User__factory} from "@/assets/types/ethers";
//
// const provider = new ethers.providers.JsonRpcProvider("http://127.0.0.1:9545");
// const address = "0xB0f24359e7843dC4d40DC859C8d35d1664056121"
// const contract = User__factory.connect(address, provider)
// contract.supply().then(console.log).catch(console.log)

const router = useRouter()
const page_animation = ref<PageAnimation>()
watch(() => router.currentRoute.value, (new_value, old_value) => {
  if (window.innerWidth >= 768 || old_value.path === "/") {
    page_animation.value = null
    return
  }
  page_animation.value = new_value.meta.depth > old_value.meta.depth ? "scale-push" : "scale-pop"
})

</script>

<style lang="less" scoped>
</style>

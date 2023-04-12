<template>
  <router-view v-slot="{ Component }">
    <transition :name="page_animation">
      <component :is="Component"/>
    </transition>
  </router-view>
</template>

<script setup lang="ts">
import {useRouter} from "vue-router";
import {ref, watch} from "vue";
import {UseStore} from "@/store";
import {Snackbar, Dialog} from "@varlet/ui"
import output from "@/assets/eth/migrations/output.json"
import "@varlet/ui/es/snackbar/style/index"
import "@varlet/ui/es/dialog/style/index"

console.log(output);

const router = useRouter()
const page_animation = ref<PageAnimation>()

watch(() => router.currentRoute.value, (new_value, old_value) => {
  if (window.innerWidth >= 768 || old_value.path === "/") {
    page_animation.value = undefined
    return
  }
  page_animation.value = new_value.meta.depth > old_value.meta.depth ? "scale-push" : "scale-pop"
})

const useDefaultWallet = () => {
  console.log(1)
}

const store = UseStore()
const ethereum = store.ethereum

switch (store.ethereum.type) {
  case "local":
    useDefaultWallet()
    break
  case "metamask":
    ethereum.connectMetaMask(window.ethereum).then(({res, err}) => {
      if (!err) {
        ethereum.address = res[0]
        return
      }

      window.ethereum.on("accountsChanged", (address_list: Address[]) => {
        ethereum.address = address_list[0]
      })

      switch (err.code) {
        case -32002:
          Snackbar({content: "请打开MetaMask登录", type: "warning", duration: 1000})
          break
        case 4001:
          Snackbar({content: "已取消连接MetaMask", type: "warning", duration: 1000})
          break
        default:
          console.log(err.code);
          Snackbar({content: "未知的MetaMask错误", type: "error", duration: 1000})
          break
      }
    })
    break
  case "other":
    Dialog({
      title: "不支持当前钱包，是否使用自带钱包？",
      onConfirm: useDefaultWallet
    })
    break
}

</script>

<style lang="less" scoped>
</style>

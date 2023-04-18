<template>
  <router-view v-slot="{ Component }">
    <transition :name="page_animation">
      <component :is="Component"/>
    </transition>
  </router-view>
  <register-modal/>
</template>

<script setup lang="ts">
import {useRouter} from "vue-router";
import {ethers} from "ethers";
import {ref, watch} from "vue";
import {UseStore} from "@/store";
import {Snackbar, Dialog} from "@varlet/ui"
import "@varlet/ui/es/snackbar/style/index"
import "@varlet/ui/es/dialog/style/index"
import {Web3Provider} from "@ethersproject/providers";


const router = useRouter()
const store = UseStore()
const page_animation = ref<PageAnimation>()

store.init()

const useDefaultWallet = () => {
  console.log(1)
}

let provider: Web3Provider

switch (store.ethereum_type) {
  case "local":
    useDefaultWallet()
    break
  case "metamask":
    window.ethereum.on("accountsChanged", (address_list: Address[]) => {
      if (!store.initialized) store.connectContract(provider)
      store.address = address_list[0]
    })

    provider = new ethers.providers.Web3Provider(window.ethereum)
    provider.send("eth_requestAccounts", []).then((address_list: Address[]) => {
      store.connectContract(provider)
      store.address = address_list[0]
    }).catch((err: MetaMaskError) => {
      switch (err.code) {
        case -32002:
          Snackbar({content: "请打开MetaMask登录", type: "warning", duration: 1000})
          break
        case 4001:
          Snackbar({content: "已取消连接MetaMask", type: "warning", duration: 1000})
          break
        default:
          Snackbar({content: "未知的MetaMask错误:" + err.code, type: "error", duration: 1000})
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

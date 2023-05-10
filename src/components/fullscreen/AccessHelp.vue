<template>
  <div v-if="store.ethereum_type==='metamask'">
    <div class="w-screen h-screen flex flex-col justify-center items-center">
      <div>请登录MetaMask</div>
      <div v-if="!store.isCorrectChain()">并连接
        <var-link
          href="https://testnet.seutools.com/"
          target="_blank"
          type="success">OurChain测试链
        </var-link>
      </div>

      <div class="flex justify-center items-center gap-2 mt-6">
        <var-button text outline type="primary" class="w-28" @click="store.useDefaultWallet()">使用默认钱包</var-button>
        <var-button text outline type="info" class="w-28" @click="reload">刷新页面</var-button>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";

const store = UseStore()

const reload = () => {
  window.location.reload()
}

defineOptions({
  name: "AccessHelp"
})
</script>


<style lang="less" scoped>

</style>


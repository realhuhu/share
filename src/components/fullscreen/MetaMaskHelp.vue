<template>
  <div class="w-screen h-screen flex flex-col justify-center items-center">
    <div>请登录MetaMask</div>
    <div v-if="!store.isCorrectChain()">请连接seu测试链</div>
  </div>
</template>


<script lang="ts" setup>

import {UseStore} from "@/store";

const store = UseStore()

defineOptions({
  name: "MetaMaskHelp"
})
</script>


<style lang="less" scoped>

</style>


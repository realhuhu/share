<template>
  <div class="bg-white h-12 w-full px-3 flex justify-between items-center gap-3">
    <div class="flex">
      <var-avatar src="https://varlet.gitee.io/varlet-ui/cat.jpg" size="small"/>
    </div>
    <div class="flex-grow overflow-hidden">
      <search-bar redirect="/search"/>
    </div>
    <var-button text round>
      <var-icon name="message-processing-outline" color="black" @click="router.push('/message')"/>
    </var-button>
  </div>
</template>


<script lang="ts" setup>
import {useRouter} from "vue-router";

const router = useRouter()

defineOptions({
  name: "HomeHeader"
})
</script>


<style lang="less" scoped>

</style>


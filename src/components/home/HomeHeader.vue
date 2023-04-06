<template>
  <div class=" md:hidden bg-white fixed w-screen h-12 z-10 px-3 var-elevation--2 flex justify-between items-center gap-3">
    <div class="flex">
      <var-avatar src="https://varlet.gitee.io/varlet-ui/cat.jpg" size="small"/>
    </div>
    <div class="flex-grow overflow-hidden">
      <search-bar redirect="/search"/>
    </div>
    <var-button text round>
      <var-icon name="message-processing-outline" color="black"/>
    </var-button>
  </div>
</template>


<script lang="ts" setup>
import SearchBar from "@/components/utils/SearchBar.vue";

defineOptions({
  name: "HomeHeader"
})
</script>


<style lang="less" scoped>

</style>


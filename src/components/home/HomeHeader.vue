<template>
  <div class="bg-white fixed w-screen h-12 z-10 px-3 var-elevation--2 flex justify-between items-center gap-3">
    <div class="">123</div>
    <div class="flex-grow">
      <search-bar/>
    </div>
    <var-button type="primary" round>
      <var-icon name="plus"/>
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


<template>
  <div>
    <home-header class="flex md:hidden"/>

    <div style="height: 200vh;background: linear-gradient(green, red);"></div>
  </div>
</template>


<script lang="ts" setup>
import HomeHeader from "@/components/home/HomeHeader.vue";

defineOptions({
  name: "HomeResource"
})
</script>


<style lang="less" scoped>

</style>

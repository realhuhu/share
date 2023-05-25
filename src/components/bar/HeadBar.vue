<template>
  <var-app-bar color="#f2f4f6" text-color="#666" elevation="0">
    {{ title }}
    <template #left>
      <var-button round text color="transparent" text-color="#4ebaee" @click="safeBack(back)">
        <var-icon name="chevron-left" :size="24"/>
      </var-button>
    </template>
    <template #right>
      <slot/>
    </template>
  </var-app-bar>
</template>


<script lang="ts" setup>
import {safeBack} from "@/router";

defineProps(["title", "back"])

defineOptions({
  name: "HeadBar"
})
</script>


<style lang="less" scoped>
</style>

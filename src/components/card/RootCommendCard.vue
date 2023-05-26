<template>
  <div>
    {{ comment}}
  </div>
</template>


<script lang="ts" setup>

import {Types} from "@/assets/types/ethers/ImplementationContact";

const props = withDefaults(defineProps<{
  comment: Types.FileRootCommentStructOutput
}>(), {})

defineOptions({
  name: "RootCommendCard"
})
</script>


<style lang="less" scoped>
</style>

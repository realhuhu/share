<template>
  <div :class="color_list[level-1]" class="text-gray-50 font-bold px-1 rounded-md my-1 text-sm">Lv.{{ level }}</div>
</template>


<script lang="ts" setup>
import {ref} from "vue";

defineProps<{
  level: number
}>()

const color_list = ref([
  "bg-[#bfbfbf]",
  "bg-[#57d9ad]",
  "bg-[#8bd4e8]",
  "bg-[#4cc3ff]",
  "bg-[#fbb47f]",
  "bg-[#979df2]",
  "bg-[#ffd24b]",
  "bg-[#bf1517]"
])


defineOptions({
  name: "LevelChip"
})
</script>


<style lang="less" scoped>

</style>


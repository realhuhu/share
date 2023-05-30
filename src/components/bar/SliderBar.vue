<template>
  <div class="text-gray-500">{{ min||1 }}</div>
  <var-slider v-model="price" :min="min||1" :max="max||20" class="cursor-pointer">
    <template #button="{ currentValue }">
      <div
        class="bg-[#4ebaee] w-5 h-5 flex items-center justify-center p-3.5 rounded-full shadow-around text-white font-bold">
        {{ currentValue }}
      </div>
    </template>
  </var-slider>
  <div class="text-gray-500">{{ max || 20 }}</div>
</template>


<script lang="ts" setup>

withDefaults(defineProps<{
  min?: number
  max?: number
}>(), {})

const price = defineModel<number>("price", {required: true})

defineOptions({
  name: "SliderBar"
})
</script>


<style lang="less" scoped>
</style>

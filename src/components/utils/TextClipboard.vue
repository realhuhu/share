<template>
  <div class="bg-gray-50 p-2 rounded-2xl border">
    <div class="flex justify-start items-center gap-2">
      <div class="text-gray-500">{{ title }}</div>
      <i-material-symbols-content-copy-outline-rounded
        class="cursor-pointer hover:text-[#4ebaee] duration-75"
        @click="copy"
      />
    </div>
    <div class="mx-2 break-words">{{ text }}</div>
  </div>
</template>


<script lang="ts" setup>
import useClipboard from "vue-clipboard3";
import {Snackbar} from "@varlet/ui"

const {toClipboard} = useClipboard();

const props = withDefaults(defineProps<{
  title: string
  text: string
}>(), {})


const copy = () => {
  toClipboard(props.text).then(() => {
    Snackbar({content: "复制成功", type: "success", duration: 1000})
  }).catch(() => {
    Snackbar({content: "复制失败", type: "warning", duration: 1000})
  })
}

defineOptions({
  name: "TextClipboard"
})
</script>


<style lang="less" scoped>

</style>


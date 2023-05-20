<template>
  <var-uploader
    v-model="images"
    :maxlength="3"
    :previewed="previewed"
    :maxsize="5*1024*1024"
    @after-read="readImage"
    @remove="removeImage"
    @oversize="Snackbar.warning('图片不超过5MB!')"
    removable/>
</template>


<script lang="ts" setup>

import {Snackbar, VarFile} from "@varlet/ui";
import {computed, ref} from "vue";
import {UseStore} from "@/store";

defineProps(["images"])
const emits = defineEmits(["update:images"])

const store = UseStore()
const images = ref<VarFile[]>([])
const previewed = computed(() => window.innerWidth < 768)
const cache = ref<Record<number, string>>({})
const readImage = async (image: VarFile) => {
  if (!image.file) {
    Snackbar({
      content: "图片读取失败",
      type: "warning",
      duration: 2000
    })
    image.state = "error"
    return
  }

  const buffer = await image.file.arrayBuffer()

  if (!buffer) {
    Snackbar({
      content: "读取二进制信息失败",
      type: "warning",
      duration: 2000
    })
    image.state = "error"
    return
  }

  try {
    const res = await store.ipfs.add({
      path: image.name,
      content: buffer
    })
    cache.value[image.id] = res.cid.toString()
    image.state = "success"
    const result = Object.values(cache.value)
    const length = result.length
    for (let i = 0; i < 3 - length; i++) {
      result.push("")
    }
    emits("update:images", result)
  } catch {
    Snackbar({
      content: "上传失败",
      type: "warning",
      duration: 2000
    })
    image.state = "error"
  }
}


const removeImage = async (image: VarFile) => {
  delete cache.value[image.id]
  const result = Object.values(cache.value)
  const length = result.length
  for (let i = 0; i < 3 - length; i++) {
    result.push("")
  }
  emits("update:images", result)
}

const clear = () => {
  images.value = []
  cache.value = {}
  emits("update:images", ["", "", ""])
}

defineExpose({clear})

defineOptions({
  name: "ImageUploader"
})
</script>


<style lang="less" scoped>
</style>

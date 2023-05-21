<template>
  <var-uploader
    id="file-uploader"
    hide-list
    accept="*/*"
    :previewed="false"
    :maxsize="1024*1024*1024"
    @after-read="readFile"
    @oversize="Snackbar.warning('文件不超过1GB!')">

    <div class="bg-[#f7f8fa] hover:text-[#4ebaee] cursor-pointer duration-100 p-2">
      <div v-if="file" class="flex justify-between items-center gap-2">
        <div class="truncate ...">{{ file.name }}</div>
        <var-icon name="window-close" class="text-[#4ebaee] cursor-pointer" @click.stop="clearFile"/>
      </div>

      <div v-else class="flex justify-start items-center gap-2">
        <var-icon name="upload"/>
        上传文件
      </div>
    </div>

    <div v-if="file&&progress_data.uploading" class="text-gray-500 flex justify-between items-center">
      <div>上传中</div>
      <div class=" flex justify-end items-center gap-2">
        <div>{{ speed }}</div>
        <div>{{ progress_data.percent.toFixed(2) }}%</div>
      </div>
    </div>

    <var-progress v-if="file" :value="progress_data.percent" :track="false"/>
  </var-uploader>
</template>


<script lang="ts" setup>
import {Snackbar, VarFile} from "@varlet/ui";
import {computed, ref} from "vue";
import {UseStore} from "@/store";

defineProps(["file", "name"])
const emits = defineEmits(["update:file", "update:name"])

const store = UseStore()
const file = ref<VarFile>()
const progress_data = ref({
  bytes: 0,
  delta: 0,
  percent: 0,
  timestamp: 0,
  uploading: false
})

const speed = computed(() => {
  if (progress_data.value.delta > 1024 * 1024) return (progress_data.value.delta / 1024 / 1024).toFixed(2) + "MB/s"
  return (progress_data.value.delta / 1024).toFixed(2) + "KB/s"
})


const clearFile = () => {
  file.value = undefined
  progress_data.value = {
    bytes: 0,
    delta: 0,
    percent: 0,
    timestamp: 0,
    uploading: false
  }
  emits("update:file", undefined)
  emits("update:name", undefined)
}

const readFile = async (uploaded_file: VarFile) => {
  await clearFile()

  file.value = uploaded_file
  progress_data.value.timestamp = new Date().getTime()
  progress_data.value.uploading = true

  if (!uploaded_file.file) {
    Snackbar({
      content: "文件读取失败",
      type: "warning",
      duration: 2000
    })
    return
  }

  const buffer = await uploaded_file.file.arrayBuffer()

  if (!buffer) {
    Snackbar({
      content: "读取二进制信息失败",
      type: "warning",
      duration: 2000
    })
    return
  }

  const res = await store.ipfs.add({
    path: "/",
    content: buffer
  }, {
    progress: (bytes: number) => {
      if (uploaded_file.file) {
        const timestamp = new Date().getTime()
        progress_data.value.delta = 1000 * (bytes - progress_data.value.bytes) / (timestamp - progress_data.value.timestamp)
        progress_data.value.bytes = bytes
        progress_data.value.percent = 100 * progress_data.value.bytes / uploaded_file.file.size
        progress_data.value.timestamp = timestamp
        progress_data.value.uploading = true
      }

    }
  })

  progress_data.value.uploading = false
  const cid = res.cid.toString()

  emits("update:file", cid)
  emits("update:name", uploaded_file.name)
}

defineExpose({clearFile})

defineOptions({
  name: "FileUploader"
})
</script>


<style lang="less">
#file-uploader .var-uploader__file-list {
  display: block;
}
</style>

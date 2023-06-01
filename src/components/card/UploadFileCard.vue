<template>
  <div class="flex flex-col gap-4 m-4">
    <file-uploader ref="file_uploader" v-model:file="ipfs_address" v-model:name="name"/>
    <var-input variant="outlined" placeholder="标题" :maxlength="64" v-model="title"/>
    <var-input variant="outlined" placeholder="文件描述..." :maxlength="512" resize textarea v-model="description"/>
    <category-select-bar v-model:category="category_address"/>

    <div class="flex justify-center items-center gap-6 pr-6 pt-4">
      <div class="w-16 font-bold md:text-lg text-gray-500">图片:</div>
      <image-uploader ref="image_uploader" v-model:images="images"/>
    </div>

    <div class="flex justify-center items-center gap-6 pr-6">
      <div class="w-16 font-bold md:text-lg text-gray-500">价格:</div>
      <slider-bar v-model:price="price"/>
    </div>

    <div class="md:p-12 pt-4">
      <var-button block type="success" @click="upload" :disabled="!valid()||uploading">
        {{ uploading ? "处理中..." : "上传" }}
      </var-button>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {ref} from "vue";
import {UseStore} from "@/store";
import {assertNotEmpty, wait} from "@/assets/lib/utils";
import {via} from "@/assets/lib/settings";

const store = UseStore()
const ipfs_address = ref<string>()
const name = ref<string>()
const title = ref<string>()
const description = ref<string>()
const category_address = ref<string>()
const images = ref<Images>(["", "", ""])
const price = ref<number>(2)
const uploading = ref(false)
const file_uploader = ref()
const image_uploader = ref()

const valid = () => Boolean(title.value && description.value && price.value && category_address.value && ipfs_address.value && name.value)

const upload = async () => {
  if (!(title.value && description.value && price.value && category_address.value && ipfs_address.value && name.value)) {
    return
  }

  const contract = assertNotEmpty(store.contract, "合约未初始化")
  uploading.value = true
  try {
    await wait(contract.uploadFile(
      via.FILE,
      ipfs_address.value,
      name.value,
      title.value,
      description.value,
      category_address.value,
      images.value,
      price.value
    ))

    uploading.value = false
    title.value = description.value = category_address.value = undefined
    price.value = 2;
    file_uploader.value.clearFile()
    image_uploader.value.clear()
  } catch {
    uploading.value = false
  }
}

defineOptions({
  name: "UploadFileCard"
})
</script>


<style lang="less" scoped>
</style>

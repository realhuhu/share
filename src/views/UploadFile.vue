<template>
  <div>
    <var-app-bar color="#f2f4f6" text-color="#666" elevation="0">
      上传文件
      <template #left>
        <var-button round text color="transparent" text-color="#4ebaee" @click="safeBack('/home/resource')">
          <var-icon name="chevron-left" :size="24"/>
        </var-button>
      </template>
    </var-app-bar>

    <div class=" flex items-center justify-center md:mt-16">
      <div class="w-screen md:w-[720px] flex flex-col gap-4 md:shadow-around md:p-12 p-5 rounded-3xl">

        <var-divider>上传文件</var-divider>
        <file-uploader ref="file_uploader" v-model:file="ipfs_address" v-model:name="name"/>
        <var-input variant="outlined" placeholder="标题" :maxlength="64" v-model="title"/>
        <var-input variant="outlined" placeholder="文件描述..." :maxlength="512" resize textarea v-model="description"/>
        <category-select-bar v-model="category"/>

        <div class="flex justify-center items-center gap-6 pr-6 pt-4">
          <div class="w-16 font-bold md:text-lg text-gray-500">图片:</div>
          <image-uploader ref="image_uploader" v-model:images="images"/>
        </div>

        <div class="flex justify-center items-center gap-6 pr-6">
          <div class="w-16 font-bold md:text-lg text-gray-500">价格:</div>
          <div class="text-gray-500">1</div>
          <var-slider v-model="price" min="1" max="20" class="cursor-pointer">
            <template #button="{ currentValue }">
              <div
                class="bg-[#4ebaee] w-5 h-5 flex items-center justify-center p-3.5 rounded-full shadow-around text-white font-bold">
                {{ currentValue }}
              </div>
            </template>
          </var-slider>
          <div class="text-gray-500">20</div>
        </div>

        <div class="md:p-12 pt-4">
          <var-button block type="success" @click="upload" :disabled="!valid()||uploading">
            {{ uploading ? "处理中..." : "上传" }}
          </var-button>
        </div>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {ref} from "vue";
import {safeBack} from "@/router";
import {UseStore} from "@/store";
import {assertNotEmpty} from "@/assets/lib/utils";
import ImageUploader from "@/components/uploader/ImageUploader.vue";

const store = UseStore()
const ipfs_address = ref<string>()
const name = ref<string>()
const title = ref<string>()
const description = ref<string>()
const category = ref<Address>()
const images = ref<Images>(["", "", ""])
const price = ref<number>(2)
const uploading = ref(false)
const file_uploader = ref()
const image_uploader = ref()

const valid = () => Boolean(title.value && description.value && price.value && category.value && ipfs_address.value && name.value)

const upload = async () => {
  if (!(title.value && description.value && price.value && category.value && ipfs_address.value && name.value)) {
    return
  }

  const contract = assertNotEmpty(store.contract, "合约未初始化")
  uploading.value = true
  try {
    await contract.uploadFile(
      ipfs_address.value,
      name.value,
      title.value,
      description.value,
      category.value,
      images.value,
      price.value
    )
    uploading.value = false
    title.value = description.value = category.value = undefined
    price.value = 2;
    file_uploader.value.clearFile()
    image_uploader.value.clear()
  } catch {
    uploading.value = false
  }
}

defineOptions({
  name: "UploadFile"
})
</script>


<style lang="less" scoped>
</style>


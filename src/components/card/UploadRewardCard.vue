<template>
  <div class="flex flex-col gap-4 m-4">
    <var-input variant="outlined" placeholder="标题" :maxlength="64" v-model="title"/>
    <var-input variant="outlined" placeholder="文件描述..." :maxlength="512" resize textarea v-model="description"/>
    <div class="flex justify-center items-center gap-6 pr-6 pt-4">
      <div class="w-16 font-bold md:text-lg text-gray-500">图片:</div>
      <image-uploader ref="image_uploader" v-model:images="images"/>
    </div>

    <div class="flex justify-center items-center gap-6 pr-6">
      <div class="w-16 font-bold md:text-lg text-gray-500">悬赏:</div>
      <slider-bar v-model:price="remuneration"/>
    </div>

    <div class="md:p-12 pt-4">
      <var-button block type="info" @click="upload" :disabled="!valid()||uploading">
        {{ uploading ? "处理中..." : "创建" }}
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
const title = ref<string>()
const description = ref<string>()
const images = ref<Images>(["", "", ""])
const remuneration = ref(2)
const uploading = ref(false)
const contract = assertNotEmpty(store.contract, "合约未初始化")

const valid = () => Boolean(title.value && description.value && remuneration.value)

const upload = async () => {
  if (title.value && description.value && remuneration.value) {
    uploading.value = true
    await wait(contract.createReward(via.REWARD, title.value, description.value, images.value, remuneration.value))
    uploading.value = false
  }
}

defineOptions({
  name: "UploadRewardCard"
})
</script>


<style lang="less" scoped>
</style>

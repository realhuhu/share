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
      <div class="w-[720px] flex flex-col gap-4 md:shadow-around md:p-12 p-5 rounded-3xl">
        <div class="md:block hidden">
          <var-divider>上传文件</var-divider>
        </div>
        <var-uploader
          id="file-uploader"
          hide-list
          :previewed="false"
          @after-read="readFile"
          :maxsize="1024*1024*1024"
          accept="*/*"
          @oversize="Snackbar.warning('文件不超过1GB!')"
          removable>
          <div class="bg-[#f7f8fa] hover:text-[#4ebaee] cursor-pointer duration-100 p-2">
            <div v-if="file">
              <div class="flex justify-between items-center gap-2">
                <div>{{ file.name }}</div>
                <var-icon name="window-close" class="text-[#4ebaee] cursor-pointer" @click.stop="file=undefined"/>
              </div>
            </div>

            <div v-else class="flex justify-start items-center gap-2">
              <var-icon name="upload"/>
              上传文件
            </div>
          </div>
          <var-progress :value="80" :track="false" />
        </var-uploader>


        <var-input variant="outlined" placeholder="标题" :maxlength="64" v-model="title"/>
        <var-input variant="outlined" placeholder="文件描述..." :maxlength="512" resize textarea v-model="description"/>
        <var-select v-if="store.categories" placeholder="分类" variant="outlined" v-model="category">
          <var-option v-for="category in store.categories" :label="category.name"
                      :value="category.category_address" :key="category.category_address"/>
        </var-select>
        <div class="flex justify-center items-center gap-6 pr-6 pt-4">
          <div class="w-16 font-bold md:text-lg text-gray-500">图片:</div>
          <var-uploader
            v-model="images"
            :maxlength="3"
            :previewed="previewed"
            :maxsize="5*1024*1024"
            @oversize="Snackbar.warning('图片不超过5MB!')"
            removable/>
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
          <var-button block type="success" @click="upload" :disabled="!valid()||uploading">上传</var-button>
        </div>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {computed, ref} from "vue";
import {safeBack} from "@/router";
import {Snackbar, VarFile} from "@varlet/ui";
import {UseStore} from "@/store";
import {assertNotEmpty} from "@/assets/lib/utils";

const store = UseStore()
const title = ref<string>()
const description = ref<string>()
const category = ref<Address>()
const file = ref<VarFile>()
const images = ref<VarFile[]>([])
const price = ref<number>(2)

const previewed = computed(() => window.innerWidth < 768)
const uploading = ref(false)

// const valid = () => Boolean(title.value && description.value && price.value && category.value)

const readFile = (uploaded_file: VarFile) => {
  file.value = uploaded_file
}

const valid = () => true
const upload = async () => {
  for (let image of images.value) {
    const buffer = await image.file?.arrayBuffer()
    if (buffer) {
      const res = await store.ipfs.add({
          path: image.name,
          content: buffer
        }
      )
      console.log(res.path)
      console.log(res.cid.toString());
    }
  }
  // if (!(title.value && description.value && price.value && category.value)) {
  //   return
  // }
  // let images_b64: [string, string, string] = ["", "", ""]
  // for (let i = 0; i < 3; i++) {
  //   if (images.value[i]) {
  //     images_b64[i] = assertNotEmpty(images.value[i].url, "文件上传中")
  //   }
  // }
  // const contract = assertNotEmpty(store.contract, "合约未初始化")
  // uploading.value = true
  // try {
  //   await contract.uploadFile(
  //     "0x0000000000000000000000000000000000000112",
  //     title.value,
  //     description.value,
  //     category.value,
  //     images_b64,
  //     price.value
  //   )
  //   uploading.value = false
  //   title.value = description.value = category.value = undefined
  //   price.value = 2;
  //   images.value = []
  // } catch {
  //   uploading.value = false
  // }

}

defineOptions({
  name: "UploadFile"
})
</script>


<style lang="less">
#file-uploader .var-uploader__file-list {
  display: block;
}
</style>


<template>
  <var-popup class="md:pl-[64px] bg-transparent flex justify-center items-center shadow-none"
             v-model:show="_show" position="bottom">
    <div class="w-[960px] max-w-[100vw] bg-white p-3 rounded-t-2xl">
      <transition enter-active-class="animate__animated animate__fadeIn"
                  leave-active-class="hidden" appear>
        <var-input v-if="!upload_image" variant="outlined" placeholder="写下评论..." textarea
                   :maxlength="128" rows="4" v-model="content"/>
        <div v-else>
          <div class="text-center text-gray-500 text-sm">携带图片</div>
          <image-uploader v-model:images="images"/>
        </div>
      </transition>

      <div class="flex justify-between items-center pt-2 px-2">
        <var-badge type="danger" :value="images.filter(x=>x.length).length">
          <i-ion-image-outline @click="upload_image=!upload_image" :class="upload_image?'text-[#4ebaee]':''"
                               class="h-7 w-7 cursor-pointer hover:bg-gray-100 duration-200"/>
        </var-badge>
        <var-button type="success" size="small" @click="comment" :disabled="!valid()||uploading">
          {{ uploading ? "处理中..." : "确定" }}
        </var-button>
      </div>
    </div>
  </var-popup>
</template>


<script lang="ts" setup>

import {computed, ref} from "vue";
import {UseStore} from "@/store";
import {assertNotEmpty} from "@/assets/lib/utils";
import {Types} from "@/assets/types/ethers/ImplementationContact";

const props = withDefaults(defineProps<{
  file_info: Types.FileDetailInfoStructOutput,
  show: boolean,
}>(), {})
const emits = defineEmits(["update:show"])

const store = UseStore()
const upload_image = ref(false)
const images = ref<Images>(["", "", ""])
const content = ref("")
const contract = assertNotEmpty(store.contract, "合约未初始化")
const uploading = ref(false)

const valid = () => content.value.length || images.value.filter(x => x.length).length
const comment = async () => {
  if (!valid()) return

  uploading.value = true
  try {
    await contract.addComment(props.file_info.file_address, content.value, images.value)
    uploading.value = false
    emits("update:show", false)
  } catch {
    uploading.value = false
  }
}

const _show = computed({
  get: () => props.show,
  set: (val) => emits("update:show", val)
})

defineOptions({
  name: "CommentEditor"
})
</script>


<style lang="less" scoped>
</style>

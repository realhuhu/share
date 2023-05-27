<template>
  <var-popup class="md:pl-[64px] bg-transparent flex justify-center items-center shadow-none"
             v-model:show="show" position="bottom">
    <div class="w-[960px] max-w-[100vw] bg-white p-3 rounded-t-2xl">
      <transition enter-active-class="animate__animated animate__fadeIn"
                  leave-active-class="hidden" appear>
        <div v-if="!upload_image">
          <div v-if="tip" class="text-gray-500 bg-gray-50 p-2">{{ tip }}</div>
          <var-input variant="outlined" placeholder="写下评论..." textarea :maxlength="128" rows="4" v-model="content"/>
        </div>
        <div v-else>
          <div class="text-center text-gray-500 text-sm">携带图片</div>
          <image-uploader v-model:images="images"/>
        </div>
      </transition>

      <div class="flex justify-between flex-row-reverse items-center pt-2 px-2">
        <var-button type="success" size="small" @click="comment" :disabled="!valid()||uploading">
          {{ uploading ? "处理中..." : "确定" }}
        </var-button>

        <var-badge type="danger" :value="images.filter(x=>x.length).length" v-if="!meta.root_comment">
          <i-ion-image-outline @click="upload_image=!upload_image" :class="upload_image?'text-[#4ebaee]':''"
                               class="h-7 w-7 cursor-pointer hover:bg-gray-100 duration-200"/>
        </var-badge>
      </div>
    </div>
  </var-popup>
</template>


<script lang="ts" setup>
import {computed, defineModel, ref} from "vue";
import {UseStore} from "@/store";
import {assertNotEmpty, wait} from "@/assets/lib/utils";
import {Types} from "@/assets/types/ethers/ImplementationContact";
import {zero_address} from "@/assets/lib/settings";

const props = withDefaults(defineProps<{
  file_info: Types.FileDetailInfoStructOutput
  meta: FileReviewEditorMeta
}>(), {})
const show = defineModel<boolean>("show", {required: true})

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
    const {root_comment, target_comment} = props.meta
    if (!root_comment) {
      await wait(contract.addComment(props.file_info.file_address, content.value, images.value))
    } else {
      await wait(contract.addSubComment(
        props.file_info.file_address,
        target_comment ? target_comment.sub_comment_address : zero_address,
        root_comment.comment_address,
        content.value
      ))
    }
    uploading.value = false
    upload_image.value = false
    images.value = ["", "", ""]
    content.value = ""
    show.value = false
  } catch (e) {
    uploading.value = false
    throw e
  }
}

const tip = computed(() => {
  const {root_comment, target_comment} = props.meta
  if (root_comment && target_comment) {
    return `回复 ${target_comment.author.nickname}`
  } else if (root_comment) {
    return `回复 ${root_comment.author.nickname}`
  }

  return ""
})

defineOptions({
  name: "CommentEditor"
})
</script>


<style lang="less" scoped>
</style>

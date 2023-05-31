<template>
  <var-popup class="md:pl-[64px] bg-transparent flex justify-center items-center shadow-none max-height-[50vh]"
             v-model:show="show" position="bottom">
    <div class="w-[960px] max-w-[100vw] bg-white p-3 rounded-t-2xl">
      <transition enter-active-class="animate__animated animate__fadeIn"
                  leave-active-class="hidden" appear>
        <div v-if="page==0">
          <div v-if="tip" class="text-gray-500 bg-gray-50 p-2">{{ tip }}</div>
          <var-input variant="outlined" placeholder="写下评论..." textarea :maxlength="128" rows="4" v-model="content"/>
        </div>
        <div v-else-if="page==1">
          <div class="text-center text-gray-500 text-sm">携带图片</div>
          <image-uploader v-model:images="images"/>
        </div>
        <div v-else>
          <div class="text-center text-gray-500 text-sm">选择文件</div>
          <div class=" flex flex-col items-center justify-center gap-4 rounded-xl bg-gray-50">
            <var-list
              class="w-full p-3"
              :finished="finished"
              v-model:loading="loading"
              @load="load"
            >
              <div v-for="(file_info,k) in files" :key="k" class="hover:shadow-around cursor-pointer">
                <transition enter-active-class="animate__animated animate__fadeIn" appear>
                  <div class="flex justify-between items-center text-sm p-2 rounded"
                       @click="file_address==file_info.file_address?file_address=zero_address:file_address=file_info.file_address"
                       :class="file_address==file_info.file_address?'bg-blue-200':'bg-gray-100'">
                    <div class="flex justify-start items-center gap-1">
                      <div class="font-bold">{{ file_info.title }}</div>
                      <div class="text-gray-500 line1">({{ file_info.name }})</div>
                    </div>
                    <div>{{ stripAddress(file_info.file_address) }}</div>
                  </div>
                </transition>
              </div>
            </var-list>
          </div>
        </div>
      </transition>

      <div class="flex justify-between flex-row-reverse items-center pt-2 px-2">
        <var-button type="success" size="small" @click="comment" :disabled="!valid()||uploading">
          {{ uploading ? "处理中..." : "确定" }}
        </var-button>

        <div class="flex justify-start items-center gap-3" v-if="!meta.root_comment">
          <i-humbleicons-text class="h-7 w-7 cursor-pointer hover:bg-gray-100 duration-200" @click="page=0"
                              :class="page===0?'text-[#4ebaee]':''"/>

          <var-badge type="danger" :value="images.filter(x=>x.length).length">
            <i-ion-image-outline @click="page=1" :class="page===1?'text-[#4ebaee]':''"
                                 class="h-7 w-7 cursor-pointer hover:bg-gray-100 duration-200"/>
          </var-badge>

          <var-badge type="danger" dot :hidden="file_address===zero_address">
            <i-ic-outline-book class="h-7 w-7 cursor-pointer hover:bg-gray-100 duration-200" @click="page=2"
                               :class="page===2?'text-[#4ebaee]':''"/>
          </var-badge>
        </div>
      </div>
    </div>
  </var-popup>
</template>


<script lang="ts" setup>
import {computed, ref, watch} from "vue";
import {UseStore} from "@/store";
import {assertNotEmpty, stripAddress, wait} from "@/assets/lib/utils";
import {Types} from "@/assets/types/ethers/ImplementationInterface";

import {head_address, tail_address, via, zero_address} from "@/assets/lib/settings";

const props = withDefaults(defineProps<{
  reward_info: Types.RewardDetailInfoStructOutput
  meta: RewardReviewEditorMeta
}>(), {})
const show = defineModel<boolean>("show", {required: true})

const store = UseStore()
const file_address = ref(zero_address)
const page = ref(0)
const images = ref<Images>(["", "", ""])
const content = ref("")
const contract = assertNotEmpty(store.contract, "合约未初始化")
const uploading = ref(false)

const cursor = ref<string>()
const reverse = ref(false)
const loading = ref(false)
const finished = ref(false)
const files = ref<Types.FileBriefInfoStructOutput[]>([])

const load = async () => {
  const contract = assertNotEmpty(store.contract, "合约未初始化")
  if (!cursor.value) cursor.value = reverse.value ? tail_address : head_address
  const res = await contract.getSelfFileBriefInfos(via.FILE, cursor.value, reverse.value)
  for (const file_info of res.file_infos) {
    if (file_info.file_address === zero_address) break
    files.value.push(file_info)
    cursor.value = res.next
  }
  loading.value = false
  finished.value = res.finished
}

const valid = () => content.value.length || images.value.filter(x => x.length).length

const clear = () => {
  page.value = 0
  images.value = ["", "", ""]
  file_address.value = zero_address
  uploading.value = false
  content.value = ""
}

const comment = async () => {
  if (!valid()) return
  uploading.value = true
  try {
    const {root_comment, target_comment} = props.meta
    if (!root_comment) {
      await wait(contract.addRewardComment(via.REWARD, props.reward_info.reward_address, file_address.value, content.value, images.value))
    } else {
      await wait(contract.addRewardSubComment(
        via.REWARD,
        props.reward_info.reward_address,
        target_comment ? target_comment.sub_comment_address : zero_address,
        root_comment.comment_address,
        content.value
      ))
    }
    clear()
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

watch(show, (new_value: boolean) => {
  if (!new_value) clear()
})

defineOptions({
  name: "RewardCommentEditor"
})
</script>


<style lang="less" scoped>
</style>

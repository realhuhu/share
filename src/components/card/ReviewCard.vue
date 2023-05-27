<template>
  <div class=" min-h-screen">
    <div class="px-2 md:px-12 md:py-6 md:shadow pb-32">
      <var-sticky>
        <div class="flex justify-between items-center bg-white">
          <var-tabs class="flex" style="padding: 0" v-model:active="order">
            <var-tab class="md:w-24">最新</var-tab>
            <var-tab class="md:w-24">最早</var-tab>
            <var-tab class="md:w-24">最多赞</var-tab>
          </var-tabs>
          <div class="text-gray-500 mr-2">{{ file_info.comment_num }}评论</div>
        </div>
        <var-divider margin="0"/>
      </var-sticky>


      <div v-if="file_info.comment_num.toNumber()">
        <var-list
          class="p-3"
          :finished="root_comment.finished"
          v-model:loading="root_comment.loading"
          @load="loadRootComments"
          :immediate-check="false"
        >
          <div v-for="(comment,k) in root_comment.comments" :key="k">
            <transition enter-active-class="animate__animated animate__fadeIn" appear>
              <root-commend-card :comment="comment as Types.FileRootCommentStructOutput"
                                 @clickRootComment="openEditor"
                                 @upAndDownRootComment="upAndDownComment"/>
            </transition>
          </div>
        </var-list>
      </div>

      <div v-else class="flex justify-center items-center h-32 text-gray-500">
        还没有评论...
      </div>
    </div>


    <transition enter-active-class="animate__animated animate__fadeInUp"
                leave-active-class="animate__animated animate__fadeOutDown">
      <div class="fixed left-0 md:pl-[64px] bottom-0 w-full flex justify-center items-center"
           v-if="!show_editor">
        <div class="w-[960px] max-w-full shadow-around flex justify-between items-center gap-6 pl-4 bg-white z-10">
          <div @click="show_editor=true"
               class="border-gray-200 border-[1px] px-3 py-1 my-2 rounded flex-grow text-gray-500 cursor-pointer hover:bg-gray-100">
            评论...
          </div>

          <div class="flex justify-end items-center">
            <div class="flex justify-center items-center cursor-pointer hover:bg-gray-100 p-2 md:p-4"
                 @click="upAndDown(true)"
                 :class="file_info.up_and_down.toNumber()===1?'text-[#4ebaee]':'text-gray-500'">
              <i-mdi-like-outline class="w-5 h-5 md:w-7 md:h-7"/>
              <div class="text-sm md:text-lg ml-1">{{ file_info.up_num }}</div>
            </div>
            <div class="flex justify-center items-center cursor-pointer hover:bg-gray-100 p-2 md:p-4"
                 @click="upAndDown(false)"
                 :class="file_info.up_and_down.toNumber()===2?'text-[#4ebaee]':'text-gray-500'">
              <i-mdi-dislike-outline class="w-5 h-5  md:w-7 md:h-7"/>
              <div class="text-sm md:text-lg ml-1">{{ file_info.down_num }}</div>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <comment-editor v-model:show="show_editor" :file_info="file_info" :meta="editor_meta as FileReviewEditorMeta"/>
  </div>
</template>


<script lang="ts" setup>
import {Types} from "@/assets/types/ethers/ImplementationContact";
import {UseStore} from "@/store";
import {assertNotEmpty, upAndDownCallback, wait} from "@/assets/lib/utils";
import {defineModel, ref, watch} from "vue";
import {head_address, tail_address, zero_address} from "@/assets/lib/settings";
import {BigNumber} from "ethers";

const file_info = defineModel<Types.FileDetailInfoStructOutput>("file_info", {required: true})

const store = UseStore()
const order = ref(0);
const order_by = ref({order: 0, reverse: true})
const show_editor = ref(false)
const root_comment = ref<{
  cursor: string
  loading: boolean
  finished: boolean
  comments: Types.FileRootCommentStructOutput[]
}>({
  cursor: tail_address,
  loading: false,
  finished: false,
  comments: []
})

const editor_meta = ref<FileReviewEditorMeta>({})
const contract = assertNotEmpty(store.contract, "合约未初始化")
const upAndDown = async (is_up: boolean) => {
  await wait(contract.upAndDownFile(file_info.value.file_address, is_up))
  file_info.value = upAndDownCallback(file_info.value, is_up)
}

const upAndDownComment = async (comment_address: string, is_up: boolean) => {
  await contract.upAndDownFileComment(file_info.value.file_address, comment_address, is_up)
}
const loadRootComments = async () => {
  const res = await contract.getRootComments(file_info.value.file_address, root_comment.value.cursor, order_by.value.order, order_by.value.reverse)
  for (const comment of res.root_comments) {
    if (comment.comment_address === zero_address) break
    if (root_comment.value.comments.map(x => x.comment_address).indexOf(comment.comment_address) !== -1) break
    root_comment.value.comments.push(comment)
  }

  root_comment.value.finished = res.finished
  root_comment.value.cursor = res.next
  root_comment.value.loading = false
}

const openEditor = (
  root_comment?: Types.FileRootCommentStructOutput,
  target_comment?: Types.FileChildrenCommentStructOutput
) => {
  editor_meta.value = {root_comment, target_comment}
  show_editor.value = true
}


watch(order, async (new_value: number) => {
  root_comment.value = {
    cursor: tail_address,
    loading: false,
    finished: false,
    comments: []
  }

  if (new_value === 0) {
    order_by.value = {order: 0, reverse: true}
  } else if (new_value === 1) {
    order_by.value = {order: 0, reverse: false}
    root_comment.value.cursor = head_address
  } else if (new_value === 2) {
    order_by.value = {order: 1, reverse: true}
  }

  await loadRootComments()
})

watch(show_editor, (new_value) => {
  if (!new_value) editor_meta.value = {}
})

loadRootComments()

defineOptions({
  name: "ReviewCard"
})
</script>


<style lang="less" scoped>
</style>

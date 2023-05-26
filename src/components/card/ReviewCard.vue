<template>
  <div>
    <div class="px-2 md:px-12 md:py-6 md:shadow pb-32 overflow-x-hidden">
      <div class="flex justify-between items-center">
        <var-tabs class="flex" style="padding: 0" v-model:active="order">
          <var-tab class="md:w-24">最新</var-tab>
          <var-tab class="md:w-24">最早</var-tab>
          <var-tab class="md:w-24">最多赞</var-tab>
        </var-tabs>
        <div class="text-gray-500 mr-2">{{ file_info.comment_num }}评论</div>
      </div>

      <var-divider margin="0"/>

      <div v-if="file_info.comment_num.toNumber()">
        <var-list
          class="w-[720px] max-w-full p-3"
          :finished="root_comment.finished"
          v-model:loading="root_comment.loading"
          @load="loadRootComments"
          :immediate-check="false"
        >
          <root-commend-card v-for="(comment,k) in root_comment.comments" :key="k"
                             :comment="comment as Types.FileRootCommentStructOutput"/>
        </var-list>
      </div>
      <div v-else class="flex justify-center items-center h-32 text-gray-500">
        还没有评论...
      </div>
    </div>


    <transition enter-active-class="animate__animated animate__fadeInUp"
                leave-active-class="animate__animated animate__fadeOutDown">
      <div class="fixed left-0 md:pl-[64px] bottom-0 w-full flex justify-center items-center bg-white"
           v-if="!show_editor">
        <div class="w-[960px] max-w-full shadow-around flex justify-between items-center gap-6 pl-4">
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

    <comment-editor v-model:show="show_editor" :file_info="file_info"/>
  </div>
</template>


<script lang="ts" setup>
import {Types} from "@/assets/types/ethers/ImplementationContact";
import {UseStore} from "@/store";
import {assertNotEmpty} from "@/assets/lib/utils";
import {ref, watch} from "vue";
import {tail_address, zero_address} from "@/assets/lib/settings";

const props = withDefaults(defineProps<{
  file_info: Types.FileDetailInfoStructOutput
}>(), {})

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

const contract = assertNotEmpty(store.contract, "合约未初始化")
const upAndDown = async (is_up: boolean) => {
  await contract.upAndDown(props.file_info.file_address, is_up)
}

const loadRootComments = async () => {
  const res = await contract.getRootComments(props.file_info.file_address, root_comment.value.cursor, order_by.value.order, order_by.value.reverse)
  for (const comment of res.root_comments) {
    if (comment.comment_address === zero_address) break
    root_comment.value.comments.push(comment)
  }

  root_comment.value.finished = res.finished
  root_comment.value.cursor = res.next
}

loadRootComments()

watch(order, (new_value: number) => {
  console.log(new_value);
})

defineOptions({
  name: "ReviewCard"
})
</script>


<style lang="less" scoped>
</style>

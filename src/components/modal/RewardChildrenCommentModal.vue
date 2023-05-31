<template>
  <var-popup v-model:show="show" class="rounded">
    <div class="w-[96vw] max-w-[600px] max-h-[70vh] md:max-h-[60vh] p-4 overflow-scroll">
      <div class="text-center my-2 font-bold">评论详情</div>
      <reward-root-comment-card
        :comment="root_comment" :index="root_comment_index" class="w-full"
        :hide_children="true"
        @clickRootComment="clickRootComment"
        @upAndDownRootComment="upAndDownRootComment"
      />
      <var-divider/>

      <var-list
        class="p-3 w-full"
        :finished="children_comment.finished"
        v-model:loading="children_comment.loading"
        @load="loadChildrenComments"
      >
        <div v-for="(comment,k) in children_comment.comments" :key="k">
          <transition enter-active-class="animate__animated animate__fadeIn" appear>
            <div class="p-2 cursor-pointer w-full"  @click="emits('clickChildrenComment',root_comment,comment)">
              <div class="flex justify-start items-start gap-2 pb-2">
                <div>
                  <var-image :src="avatar(comment.author.avatar)" width="36" radius="50%"/>
                </div>

                <div class="inline flex-grow">
                  <span class="font-bold">{{ comment.author.nickname }}</span>
                  <level-chip class="inline-block mx-2" :level="calcLevel(comment.author.experience.toNumber()).level"/>
                  <span v-if="comment.target_author.user_address!==zero_address" class="text-sm mr-1">
                    回复<span class="text-[#4ebaee] mx-1">{{ comment.target_author.nickname }}</span>:
                  </span>
                  <span class="text-sm">
                    {{ comment.content }}
                  </span>
                </div>
              </div>

              <div class="flex justify-end items-center gap-6 text-gray-400 text-[10px]">
                <div>{{ datetime(comment.comment_timestamp.toNumber()) }}</div>

                <div class="flex justify-center items-center gap-1 hover:shadow-around"
                     :class="comment.up_and_down.toNumber()===1?'text-[#4ebaee]':'text-gray-500'"
                     @click.stop="upAndDownChildrenComment(k,true)">
                  <i-mdi-like-outline class="w-5 h-5"/>
                  <div>{{ comment.up_num }}</div>
                </div>

                <div class="flex justify-center items-center gap-1 hover:shadow-around"
                     :class="comment.up_and_down.toNumber()===2?'text-[#4ebaee]':'text-gray-500'"
                     @click.stop="upAndDownChildrenComment(k,false)">
                  <i-mdi-dislike-outline class="w-5 h-5"/>
                  <div>{{ comment.down_num }}</div>
                </div>
              </div>
              <var-divider/>
            </div>
          </transition>
        </div>
      </var-list>
    </div>
  </var-popup>
</template>


<script lang="ts" setup>
import {Types} from "@/assets/types/ethers/ImplementationInterface";

import {head_address, via, zero_address} from "@/assets/lib/settings";
import {assertNotEmpty, avatar, calcLevel, datetime, upAndDownCallback, wait} from "@/assets/lib/utils";
import {UseStore} from "@/store";
import {ref, watch} from "vue";

const props = withDefaults(defineProps<{
  reward_info: Types.RewardDetailInfoStructOutput
  root_comment: Types.RewardRootCommentStructOutput
  root_comment_index: number
}>(), {})
const show = defineModel<boolean>("show", {required: true})
const emits = defineEmits([
  "upAndDownRootComment",
  "clickRootComment",
  "clickChildrenComment"
])

const store = UseStore()
const children_comment = ref<{
  cursor: string
  loading: boolean
  finished: boolean
  comments: Types.RewardChildrenCommentStructOutput[]
}>({
  cursor: head_address,
  loading: false,
  finished: false,
  comments: []
})

const contract = assertNotEmpty(store.contract, "合约未初始化")

const loadChildrenComments = async () => {
  const res = await contract.getRewardChildrenComments(
    via.REWARD,
    props.reward_info.reward_address,
    props.root_comment.comment_address,
    children_comment.value.cursor
  )

  for (const comment of res.children_comments) {
    if (comment.comment_address === zero_address) break
    if (children_comment.value.comments.map(x => x.sub_comment_address).indexOf(comment.sub_comment_address) !== -1) break
    children_comment.value.comments.push(comment)
  }

  children_comment.value.finished = res.finished
  children_comment.value.cursor = res.next
  children_comment.value.loading = false
}

const upAndDownChildrenComment = async (children_comment_index: number, is_up: boolean) => {
  await wait(contract.upAndDownRewardSubComment(
    via.REWARD,
    props.reward_info.reward_address,
    props.root_comment.comment_address,
    children_comment.value.comments[children_comment_index].sub_comment_address,
    is_up
  ))
  children_comment.value.comments[children_comment_index] = upAndDownCallback(children_comment.value.comments[children_comment_index], is_up)
}

const upAndDownRootComment = (root_comment_index: number, is_up: boolean) => {
  emits("upAndDownRootComment", root_comment_index, is_up)
}

const clickRootComment = (comment: Types.FileRootCommentStructOutput) => {
  emits("clickRootComment", comment)
}


watch(show, async (new_value: boolean) => {
  if (!new_value) {
    children_comment.value = {
      cursor: head_address,
      loading: false,
      finished: false,
      comments: []
    }
  }
})

defineOptions({
  name: "RewardChildrenCommentModal"
})
</script>


<style lang="less" scoped>
</style>

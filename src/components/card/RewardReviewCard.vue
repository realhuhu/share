<template>
  <div class=" min-h-screen md:min-h-0 shadow-around md:mb-32 bg-white">
    <div class="px-2">
      <var-sticky>
        <div class="flex justify-between items-center bg-white">
          <var-tabs class="flex" style="padding: 0" v-model:active="order">
            <var-tab class="md:w-24">最新</var-tab>
            <var-tab class="md:w-24">最早</var-tab>
            <var-tab class="md:w-24">最多赞</var-tab>
            <var-tab class="md:w-24">有文件</var-tab>
          </var-tabs>
          <div class="text-gray-500 mr-2">{{ reward_info.comment_num }}评论</div>
        </div>
        <var-divider margin="0"/>
      </var-sticky>


      <div v-if="reward_info.comment_num.toNumber()">
        <var-list
          class="p-3"
          :finished="root_comment.finished"
          v-model:loading="root_comment.loading"
          @load="loadRootComments"
          :immediate-check="false"
        >
          <div v-for="(comment,k) in root_comment.comments" :key="k">
            <transition enter-active-class="animate__animated animate__fadeIn" appear>
              <reward-root-comment-card
                :comment="comment as Types.RewardRootCommentStructOutput"
                :index="k"
                @clickRootComment="openEditor"
                @upAndDownRootComment="upAndDownRootComment"
                @openChildrenComment="openChildrenComment"
              />
            </transition>
          </div>
        </var-list>
      </div>

      <div v-else class="flex justify-center items-center h-32 text-gray-500">
        还没有评论...
      </div>
    </div>

    <reward-review-input-bar v-model:show_editor="show_editor" :reward_info="reward_info" @upAndDown="upAndDown"
                             @mark="mark"/>
    <reward-comment-editor v-model:show="show_editor" :reward_info="reward_info"
                           :meta="editor_meta as RewardReviewEditorMeta"/>
    <var-popup v-model:show="show_children" class="rounded">
      <reward-children-comment-modal
        v-model:show="show_children"
        :reward_info="reward_info"
        :root_comment="root_comment.comments[opened_comment_index||0] as Types.RewardRootCommentStructOutput"
        :root_comment_index="opened_comment_index||0"
        @clickRootComment="openEditor"
        @clickChildrenComment="openEditor"
        @upAndDownRootComment="upAndDownRootComment"
      />
    </var-popup>
  </div>
</template>


<script lang="ts" setup>

import {Types} from "@/assets/types/ethers/ImplementationInterface";
import {UseStore} from "@/store";
import {ref, watch} from "vue";
import {head_address, tail_address, via, zero_address} from "@/assets/lib/settings";
import {assertNotEmpty, markCallback, upAndDownCallback, wait} from "@/assets/lib/utils";
import RewardReviewInputBar from "@/components/bar/RewardReviewInputBar.vue";

const reward_info = defineModel<Types.RewardDetailInfoStructOutput>("reward_info", {required: true})

const store = UseStore()

const order = ref(0);
const order_by = ref({order: 0, reverse: true})
const root_comment = ref<{
  cursor: string
  loading: boolean
  finished: boolean
  comments: Types.RewardRootCommentStructOutput[]
}>({
  cursor: tail_address,
  loading: false,
  finished: false,
  comments: []
})

const show_editor = ref(false)
const editor_meta = ref<RewardReviewEditorMeta>({})

const show_children = ref(false)
const opened_comment_index = ref<number>()

const contract = assertNotEmpty(store.contract, "合约未初始化")

const upAndDown = async (is_up: boolean) => {
  await wait(contract.upAndDownReward(via.REWARD, reward_info.value.reward_address, is_up))
  reward_info.value = upAndDownCallback(reward_info.value, is_up)
}

const upAndDownRootComment = async (comment_index: number, is_up: boolean) => {
  await wait(contract.upAndDownRewardComment(via.REWARD, reward_info.value.reward_address, root_comment.value.comments[comment_index].comment_address, is_up))
  root_comment.value.comments[comment_index] = upAndDownCallback(root_comment.value.comments[comment_index], is_up)
}

const mark = async () => {
  await wait(contract.markReward(via.REWARD, reward_info.value.reward_address))
  reward_info.value = markCallback(reward_info.value)
}


const loadRootComments = async () => {
  const res = await contract.getRewardRootComments(via.REWARD, reward_info.value.reward_address, root_comment.value.cursor, order_by.value.order, order_by.value.reverse)
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
  root_comment?: Types.RewardRootCommentStructOutput,
  target_comment?: Types.RewardChildrenCommentStructOutput
) => {
  editor_meta.value = {root_comment, target_comment}
  show_editor.value = true
}

const openChildrenComment = (comment_index: number) => {
  show_children.value = true
  opened_comment_index.value = comment_index
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
  } else if (new_value === 3) {
    order_by.value = {order: 3, reverse: true}
  }

  await loadRootComments()
})

watch(show_editor, (new_value) => {
  if (!new_value) editor_meta.value = {}
})

watch(show_children, (new_value) => {
  if (!new_value) opened_comment_index.value = undefined
})

loadRootComments()

defineOptions({
  name: "RewardReviewCard"
})
</script>


<style lang="less" scoped>
</style>

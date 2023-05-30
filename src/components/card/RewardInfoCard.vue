<template>
  <div class="rounded-xl md:shadow-around p-6 md:px-16 flex flex-col gap-3">
    <div>
      <div class="text-[24px] font-bold">{{ reward_info.title }}</div>
      <div class="text-gray-500 text-sm">{{ stripAddress(reward_info.reward_address) }}</div>
    </div>

    <div class="flex justify-start items-center gap-3 text-sm text-gray-500">
      <div>{{ reward_info.up_num }}点赞</div>
      <div>{{ reward_info.down_num }}点踩</div>
      <div>{{ reward_info.comment_num }}评论</div>
    </div>

    <div class="flex justify-center items-center text-sm text-gray-500">
      <div>发布于：{{ create_time }}</div>
      <var-divider v-if="create_time!==update_time" vertical/>
      <div v-if="create_time!==update_time">最后更新于：{{ update_time }}</div>
    </div>

    <div>
      {{ reward_info.description }}
    </div>

    <var-image v-for="(image,k) in reward_info.images.filter(x=>x.length)" :key="k" :src="`${ipfs_url}ipfs/${image}`"/>
  </div>
</template>


<script lang="ts" setup>
import {Types} from "@/assets/types/ethers/ImplementationContact";
import {ipfs_url} from "@/assets/lib/settings";
import {datetime, stripAddress} from "@/assets/lib/utils";
import {computed} from "vue";

const props = withDefaults(defineProps<{
  reward_info: Types.RewardDetailInfoStructOutput
}>(), {})

const create_time = computed(() => datetime(props.reward_info.create_timestamp.toNumber()))
const update_time = computed(() => datetime(props.reward_info.update_timestamp.toNumber()))

defineOptions({
  name: "RewardInfoCard"
})
</script>


<style lang="less" scoped>
</style>

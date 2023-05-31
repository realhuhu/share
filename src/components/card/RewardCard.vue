<template>
  <div class="cursor-pointer hover:bg-gray-100 hover:shadow-around duration-200 text-sm"
       @click="router.push(`/reward-detail/${reward_info.reward_address}`)">
    <div class="flex justify-between items-center gap-1 md:mb-2">
      <div class="flex justify-start items-center gap-1">
        <var-chip v-if="reward_info.approved_comment===zero_address" type="info" size="small" class="min-w-[60px]">
          未解决
        </var-chip>
        <var-chip v-else type="success" class="w-16 min-w-[60px]">
          已解决
        </var-chip>

        <div class="font-bold text-[18px] line1">{{ reward_info.title }}</div>
      </div>

      <div class="min-w-[100px] text-end text-gray-500">{{ time }}</div>
    </div>

    <div class="flex justify-between items-start min-h-[50px] max-h-[150px] overflow-hidden">
      <img v-if="reward_info.cover" class="max-w-[30%]  max-h-[150px] self-center py-2"
           :src="`${ipfs_url}ipfs/${reward_info.cover}`" alt=""/>
      <div class="flex-grow p-2 break-all">
        <var-chip size="mini" :round="false" type="warning">赏金:{{ reward_info.remuneration }}</var-chip>
        {{ reward_info.description }}
      </div>
    </div>

    <div class="m-2 flex justify-between items-center">
      <div class="flex justify-start items-center text-gray-500 gap-1">
        <i-ph-user/>
        <div>{{ reward_info.author }}</div>
      </div>

      <div class="flex justify-end items-center gap-8">
        <div class="flex justify-center items-center gap-1"
             :class="reward_info.up_and_down.toNumber()===1? 'text-[#4ebaee]':'text-gray-500'">
          <i-mdi-like-outline/>
          {{ reward_info.up_num }}
        </div>

        <div class="flex justify-center items-center gap-1"
             :class="reward_info.up_and_down.toNumber()===-1? 'text-[#4ebaee]':'text-gray-500'">
          <i-mdi-dislike-outline/>
          {{ reward_info.down_num }}
        </div>

        <div class="flex justify-center items-center gap-1 text-gray-500">
          <i-mdi-comment-outline/>
          {{ reward_info.comment_num }}
        </div>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>

import {Types} from "@/assets/types/ethers/ImplementationInterface";

import {ipfs_url, zero_address} from "@/assets/lib/settings";
import {computed} from "vue";
import {datetime} from "@/assets/lib/utils";
import {useRouter} from "vue-router";

const props = withDefaults(defineProps<{
  reward_info: Types.RewardBriefInfoStructOutput
}>(), {})

const router = useRouter()

const time = computed(() => datetime(props.reward_info.update_timestamp.toNumber()))

defineOptions({
  name: "RewardCard"
})
</script>


<style lang="less" scoped>
</style>

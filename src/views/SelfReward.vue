<template>
  <div>
    <div class="fixed left-0 top-0 w-screen h-screen bg-[#f0f1f5] z-[-100]"/>
    <head-bar title="我的悬赏" back="/home/profile"/>
    <div class="flex flex-col items-center justify-center md:mt-16 gap-4 rounded-xl">
      <var-list
        class="w-[960px] max-w-full p-6 bg-white"
        :finished="finished"
        v-model:loading="loading"
        @load="load"
        :immediate-check="false"
      >
        <div v-for="(reward_info,k) in rewards" :key="k">
          <transition enter-active-class="animate__animated animate__fadeIn" appear>
            <reward-card :reward_info="reward_info as Types.RewardBriefInfoStructOutput"/>
          </transition>
          <var-divider/>
        </div>
      </var-list>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {ref} from "vue";
import {Types} from "@/assets/types/ethers/ImplementationInterface";

import {assertNotEmpty} from "@/assets/lib/utils";
import {head_address, tail_address, via, zero_address} from "@/assets/lib/settings";
import RewardCard from "@/components/card/RewardCard.vue";

const store = UseStore()
const cursor = ref<string>()
const reverse = ref(false)
const loading = ref(false)
const finished = ref(false)
const rewards = ref<Types.RewardBriefInfoStructOutput[]>([])

const load = async () => {
  const contract = assertNotEmpty(store.contract, "合约未初始化")
  if (!cursor.value) cursor.value = reverse.value ? tail_address : head_address
  const res = await contract.getSelfRewardBriefInfos(via.REWARD, cursor.value, reverse.value)
  for (const reward_info of res.reward_infos) {
    if (reward_info.reward_address === zero_address) break
    rewards.value.push(reward_info)
    cursor.value = res.next
  }
  loading.value = false
  finished.value = res.finished
}

load()


defineOptions({
  name: "SelfReward"
})
</script>


<style lang="less" scoped>
</style>

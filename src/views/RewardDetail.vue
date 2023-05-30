<template>
  <div>
    <div class="fixed left-0 top-0 w-screen h-screen bg-[#f0f1f5] z-[-100]"/>
    <head-bar title="悬赏详情" back="/home/reward"/>

    <div class="flex flex-col items-center justify-center">
      <div class="w-[960px] max-w-full md:mt-24 md:px-6 flex flex-col gap-3">
        <transition enter-active-class="animate__animated animate__fadeIn" appear>
          <reward-info-card v-if="reward_info" :reward_info="reward_info" class="bg-white mt-2"/>
        </transition>

        <transition enter-active-class="animate__animated animate__fadeIn" appear>
          <user-simple-card v-if="user_info" :user_info="user_info" class="bg-white"/>
        </transition>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {useRoute} from "vue-router";
import {UseStore} from "@/store";
import {assertNotEmpty} from "@/assets/lib/utils";
import {ref} from "vue";
import {Types} from "@/assets/types/ethers/ImplementationContact";

const route = useRoute()
const store = UseStore()
const reward_info = ref<Types.RewardDetailInfoStructOutput>()
const user_info = ref<Types.UserSimpleInfoStructOutput>()
const contract = assertNotEmpty(store.contract, "合约未初始化")
const reward_address = typeof route.params.reward_address === "string" ? route.params.reward_address : route.params.reward_address[0]

const init = async () => {
  reward_info.value = await contract.getRewardDetailInfo(reward_address)
  user_info.value = await contract.getOtherSimpleInfo(reward_info.value?.author)
}

init()


defineOptions({
  name: "RewardDetail"
})
</script>


<style lang="less" scoped>
</style>

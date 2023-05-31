<template>
  <div class="flex items-center justify-center pt-12 md:pt-0">
    <div class="fixed left-0 top-0 w-screen h-screen bg-[#f0f1f5] z-[-100]"/>
    <home-header class="flex md:hidden"/>

    <div class="w-[780px] max-w-full md:mt-24 md:px-6">

      <var-sticky>
        <var-tabs v-model:active="solved" class="md:hidden" style="padding: 0">
          <var-tab>全部</var-tab>
          <var-tab>已解决</var-tab>
          <var-tab>未解决</var-tab>
        </var-tabs>
      </var-sticky>

      <var-sticky>
        <div class="bg-white shadow-around md:py-2">
          <var-button class="hidden md:inline" @click="solved=0" text
                      :class="solved===0?'text-[#4ebaee] underline':'text-gray-500'">
            全部
          </var-button>
          <var-button class="hidden md:inline" @click="solved=1" text
                      :class="solved===1?'text-[#4ebaee] underline':'text-gray-500'">
            已解决
          </var-button>
          <var-button class="hidden md:inline" @click="solved=2" text
                      :class="solved===2?'text-[#4ebaee] underline':'text-gray-500'">
            未解决
          </var-button>
        </div>

        <var-divider margin="0"/>
      </var-sticky>

      <var-sticky>
        <div class="flex justify-end  py-2 text-sm">
          <var-menu placement="bottom-end" class="cursor-pointer md:hover:bg-gray-100 md:p-2 p-1 duration-75"
                    v-model:show="show_menu">
            <div class="flex justify-start items-center text-gray-500">
              {{ orders[current_order].text }}
              <var-icon name="menu-down"/>
            </div>

            <template #menu>
              <div v-for="(order,k) in orders" :key="k" :class="k===current_order?'text-[#4ebaee]':''"
                   class="cursor-pointer hover:bg-blue-100 p-2 duration-200" @click="current_order=k">
                {{ order.text }}
              </div>
            </template>
          </var-menu>
        </div>
      </var-sticky>

      <var-list
        class="max-w-full pb-24 min-h-screen"
        :finished="finished"
        v-model:loading="loading"
        @load="load"
      >
        <div class="flex items-start justify-start flex-wrap">
          <div v-for="(reward_info,k) in rewards" :key="k" class="w-full">
            <transition enter-active-class="animate__animated animate__fadeIn" appear>
              <reward-card class="bg-white p-2 px-4" :reward_info="reward_info as Types.RewardBriefInfoStructOutput"/>
            </transition>
            <var-divider margin="0"/>
          </div>
        </div>

        <div v-if="!finished&&!loading" class="text-center text-gray-500">下滑加载</div>
      </var-list>
    </div>
  </div>
</template>


<script lang="ts" setup>
import HomeHeader from "@/components/home/HomeHeader.vue";
import {UseStore} from "@/store";
import {ref, watch} from "vue";
import {head_address, tail_address, via, zero_address} from "@/assets/lib/settings";
import {assertNotEmpty} from "@/assets/lib/utils";
import {Types} from "@/assets/types/ethers/ImplementationInterface";


const store = UseStore()
const orders = ref([
  {
    text: "最近发布",
    type: 0,
    reverse: true
  },
  {
    text: "最多赞",
    type: 1,
    reverse: true
  },
  {
    text: "最近更新",
    type: 2,
    reverse: true
  },
  {
    text: "价格降序",
    type: 3,
    reverse: false
  },
  {
    text: "价格升序",
    type: 3,
    reverse: true
  }
])
const solved = ref(0)
const current_order = ref(0)
const show_menu = ref(false)

const cursor = ref<string>(tail_address)

const rewards = ref<Types.RewardBriefInfoStructOutput[]>([])
const loading = ref(false)
const finished = ref(false)

const clear = () => {
  rewards.value = []
  loading.value = false
  finished.value = false
  cursor.value = orders.value[current_order.value].reverse ? tail_address : head_address
}
const load = async () => {
  const contract = assertNotEmpty(store.contract, "合约未初始化")
  const {type, reverse} = orders.value[current_order.value]
  const res = await contract.getRewardBriefInfos(via.REWARD, cursor.value, solved.value, type, reverse)
  finished.value = res.finished
  cursor.value = res.next
  for (let reward_info of res.reward_infos) {
    if (reward_info.reward_address === zero_address) break
    if (rewards.value.map(x => x.reward_address).indexOf(reward_info.reward_address) !== -1) break
    rewards.value.push(reward_info)
  }
  loading.value = false
}

watch(current_order, async () => {
  show_menu.value = false
  await clear()
  await load()
})

watch(solved, async () => {
  await clear()
  await load()
})

load()

defineOptions({
  name: "HomeReward"
})
</script>


<style lang="less" scoped>

</style>


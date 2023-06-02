<template>
  <div class="flex flex-col items-center justify-start min-h-screen">
    <div class="w-[768px] max-w-full md:mt-12">
      <var-tabs class="flex bg-gray-100  shadow-around" v-model:active="active" @change="clear">
        <var-tab>收藏的资料</var-tab>
        <var-tab>收藏的悬赏</var-tab>
      </var-tabs>
      <var-divider margin="0"/>

      <var-tabs-items v-model:active="active" :can-swipe="false">
        <var-tab-item>
          <var-list
            class="bg-white"
            :finished="file_data.finished"
            v-model:loading="file_data.loading"
            @load="loadFiles"
          >
            <div v-for="(file,k) in file_data.files" :key="k" class="p-1 md:p-2">
              <transition enter-active-class="animate__animated animate__fadeIn" appear>
                <file-card :file_info="file as Types.FileBriefInfoStructOutput"/>
              </transition>
            </div>
          </var-list>
        </var-tab-item>
        <var-tab-item>
          <var-list
            class="bg-white"
            :finished="reward_data.finished"
            v-model:loading="reward_data.loading"
            @load="loadRewards"
            :immediate-check="false"
          >
            <div v-for="(reward,k) in reward_data.files" :key="k" class="p-2 rounded-xl">
              <transition enter-active-class="animate__animated animate__fadeIn" appear>
                <reward-card :reward_info="reward as Types.RewardBriefInfoStructOutput"/>
              </transition>
              <var-divider margin="0"/>
            </div>
          </var-list>
        </var-tab-item>
      </var-tabs-items>
    </div>
  </div>
</template>


<script lang="ts" setup>

import {ref} from "vue";
import {UseStore} from "@/store";
import {assertNotEmpty} from "@/assets/lib/utils";
import {Types} from "@/assets/types/ethers/ImplementationInterface";
import {head_address, via, zero_address} from "@/assets/lib/settings";

const active = ref(0)
const store = UseStore()
const file_data = ref<{
  files: Types.FileBriefInfoStructOutput[]
  cursor: string
  loading: boolean
  finished: boolean
}>({
  files: [],
  cursor: head_address,
  loading: false,
  finished: false
})
const reward_data = ref<{
  files: Types.RewardBriefInfoStructOutput[]
  cursor: string
  loading: boolean
  finished: boolean
}>({
  files: [],
  cursor: head_address,
  loading: false,
  finished: false
})
const contract = assertNotEmpty(store.contract, "合约未初始化")

const loadFiles = async () => {
  const res = await contract.getMarkedFiles(via.FILE, file_data.value.cursor)

  for (const file_info of res.file_infos) {
    if (file_info.file_address === zero_address) break
    file_data.value.files.push(file_info)
    file_data.value.cursor = res.next
  }
  file_data.value.loading = false
  file_data.value.finished = res.finished
}

const loadRewards = async () => {
  const res = await contract.getMarkedRewards(via.REWARD, reward_data.value.cursor)
  for (const reward_info of res.reward_infos) {
    if (reward_info.reward_address === zero_address) break
    reward_data.value.files.push(reward_info)
    reward_data.value.cursor = res.next
  }
  reward_data.value.loading = false
  reward_data.value.finished = res.finished
}

const clear = (active: string | number) => {
  if (active) {
    reward_data.value = {
      files: [],
      cursor: head_address,
      loading: false,
      finished: false
    }
    loadRewards()
  } else {
    file_data.value = {
      files: [],
      cursor: head_address,
      loading: false,
      finished: false
    }
    loadFiles()
  }
}

defineOptions({
  name: "HomeFavorite"
})
</script>


<style lang="less" scoped>
</style>

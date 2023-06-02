<template>
  <div>
    <head-bar title="用户信息" back="/home/profile"/>
    <div class="flex items-center justify-center md:mt-8 lg:mt-16 gap-4 rounded-xl">
      <div class="w-[768px] lg:w-[960px] max-w-full bg-white">
        <transition enter-active-class="animate__animated animate__fadeIn" appear>
          <user-detail-card v-if="user_info" v-model:user_info="user_info"/>
        </transition>

        <transition enter-active-class="animate__animated animate__fadeIn" appear>
          <user-file-reward-card v-if="user_info" :user_address="user_info.user_address"/>
        </transition>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {assertNotEmpty} from "@/assets/lib/utils";
import {via} from "@/assets/lib/settings";
import {useRoute} from "vue-router";
import UserDetailCard from "@/components/card/UserDetailCard.vue";
import {ref} from "vue";
import {Types} from "@/assets/types/ethers/ImplementationInterface";
import UserFileRewardCard from "@/components/card/UserFileRewardCard.vue";

const store = UseStore()
const route = useRoute()
const user_info = ref<Types.UserSimpleInfoStructOutput>()
const contract = assertNotEmpty(store.contract, "合约未初始化")
const user_address = typeof route.params.user_address === "string" ? route.params.user_address : route.params.user_address[0]

const init = async () => {
  user_info.value = await contract.getOtherSimpleInfo(via.USER, user_address)
}

init()

defineOptions({
  name: "UserInfo"
})
</script>


<style lang="less" scoped>
</style>

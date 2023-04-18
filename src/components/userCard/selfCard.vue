<template>
  <div class="flex flex-row justify-start items-start p-6 gap-4 whitespace-nowrap">
    <div class="w-[80px]">
      <var-avatar src="https://varlet.gitee.io/varlet-ui/cat.jpg" size="80"/>
    </div>

    <div class="flex flex-col justify-start items-start">
      <div v-if="!is_registered" class="flex gap-2 items-center">
        未授权
        <var-button size="small" type="primary" text outline @click="store.showRegisterModal=true">授权</var-button>
      </div>
      <div v-else-if="self_info">
        {{ self_info.nickname }}
      </div>

      <div class="overflow-ellipsis overflow-hidden ... w-full">
        {{ stripAddress(address) }}
      </div>
    </div>
  </div>
  <div v-if="self_info" class="flex justify-between items-center px-12 md:px-24">
    <div class="flex flex-col justify-center items-center">
      <div>123</div>
      <div class="text-sm text-gray-500">我的上传</div>
    </div>
    <div>
      <var-divider vertical/>
    </div>
    <div class="flex flex-col justify-center items-center">
      <div>{{self_info.following_num}}</div>
      <div class="text-sm text-gray-500">我关注的</div>
    </div>
    <div>
      <var-divider vertical/>
    </div>
    <div class="flex flex-col justify-center items-center">
      <div>{{ self_info.follower_num}}</div>
      <div class="text-sm text-gray-500">我的粉丝</div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {assertNotEmpty, stripAddress} from "@/assets/lib/utils";
import {ref} from "vue";
import {UserContract as UserContractType} from "@/assets/types/ethers";

const props = withDefaults(defineProps<{
  address: Address
}>(), {
  address: undefined
})
const store = UseStore()
const UserContract = assertNotEmpty(store.UserContract, "用户合约未初始化")
const is_registered = await UserContract.isRegistered(props.address)
const self_info = ref<UserContractType.UserSelfInfoStructOutput>()

if (is_registered) {
  self_info.value = await UserContract.getSelfInfo()
}
defineOptions({
  name: "selfCard"
})
</script>


<style lang="less" scoped>

</style>


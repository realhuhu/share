<template>
  <div
    class="rounded-xl md:shadow-around hover:bg-gray-50 p-3 flex justify-start items-center gap-2 text-sm cursor-pointer duration-200"
    @click="toDetail">
    <div class="w-16 h-16">
      <var-avatar :src="avatar(user_info.avatar)" size="64"/>
    </div>

    <div class="flex flex-col justify-start items-start self-start flex-grow">
      <div class="flex justify-start items-center gap-1">
        <div class="line1 text-sm">
          <span class="font-bold">{{ user_info.nickname }}</span>
          <span class="font-light mx-1">({{ stripAddress(user_info.user_address) }})</span>
        </div>
        <level-chip :level="calcLevel(user_info.experience.toNumber()).level"/>
      </div>

      <div class="text-gray-500">
        {{ user_info.signature || "还没有签名..." }}
      </div>

      <div class="flex justify-start items-center gap-3 mt-2">
        <var-chip size="mini" type="info">粉丝数:{{ user_info.follower_num }}</var-chip>
        <var-chip size="mini" type="success">已上传:{{ user_info.uploaded_file_num }}</var-chip>
      </div>
    </div>
    <div v-if="user_info.user_address.toUpperCase()!==store.user?.address?.toUpperCase()" class="ml-2">
      <var-button v-if="user_info.is_following" class="mr-2" text outline type="danger" @click.stop="follow(false)">
        取消关注
      </var-button>
      <var-button v-else class="mr-2" text outline type="info" @click.stop="follow(true)">关注</var-button>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {Types} from "@/assets/types/ethers/ImplementationInterface";
import {assertNotEmpty, avatar, calcLevel, followCallback, stripAddress, wait} from "@/assets/lib/utils";
import {UseStore} from "@/store";
import {via} from "@/assets/lib/settings";
import {Dialog} from "@varlet/ui";
import router from "@/router";


const user_info = defineModel<Types.UserSimpleInfoStructOutput>("user_info", {required: true})

const store = UseStore()
const contract = assertNotEmpty(store.contract, "合约未初始化")
const follow = async (is_follow: boolean) => {
  if (is_follow || await Dialog({title: "是否取消关注?"}) === "confirm") {
    if(await wait(contract.follow(via.USER, user_info.value.user_address))){
      user_info.value = followCallback(user_info.value)
    }
  }
}

const toDetail = () => {
  if (user_info.value.user_address.toUpperCase() === store.user?.address?.toUpperCase()) {
    router.push("/home/profile")
  } else {
    router.push(`/user/${user_info.value.user_address}`)
  }
}


defineOptions({
  name: "UserSimpleCard"
})
</script>


<style lang="less" scoped>
</style>

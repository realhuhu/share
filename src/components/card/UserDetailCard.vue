<template>
  <div class="flex flex-col justify-start items-start gap-4 md:border border-gray-100 rounded text-sm p-3 md:p-6">
    <div class="flex flex-row justify-between items-start gap-4 w-full">
      <var-avatar :src="avatar(user_info.avatar)" size="64" class="flex-shrink-0"/>

      <div class="flex-grow">
        <div class="flex justify-start items-center">
          <div class="line1">{{ user_info.nickname }}</div>
          <div class="text-gray-500">({{ stripAddress(user_info.user_address) }})</div>
        </div>
        <experience-bar :experience="user_info.experience.toNumber()"/>
      </div>

      <div class="self-center flex-shrink-0">
        <var-button v-if="user_info.is_following" text outline type="danger" @click.stop="follow(false)">
          取消关注
        </var-button>
        <var-button v-else text outline type="info" @click.stop="follow(true)">关注</var-button>
      </div>
    </div>

    <div class="text-gray-500 px-2">
      {{ user_info.signature || "还没有签名..." }}
    </div>

    <div class="flex justify-start items-center px-2 text-gray-500 gap-2 md:gap-4">
      <var-chip size="small" type="info">{{ user_info.follower_num }}粉丝</var-chip>

      <var-chip size="small" type="success">{{ user_info.medal_num }}上传</var-chip>

      <var-chip size="small" type="danger">{{ user_info.medal_num }}奖章</var-chip>
    </div>

    <var-divider class="md:hidden" margin="0"/>
  </div>
</template>


<script lang="ts" setup>
import {Types} from "@/assets/types/ethers/ImplementationInterface";
import {assertNotEmpty, avatar, followCallback, stripAddress, wait} from "@/assets/lib/utils";
import {Dialog} from "@varlet/ui";
import {via} from "@/assets/lib/settings";
import {UseStore} from "@/store";

const user_info = defineModel<Types.UserSimpleInfoStructOutput>("user_info", {required: true})
const store = UseStore()
const contract = assertNotEmpty(store.contract, "合约未初始化")

const follow = async (is_follow: boolean) => {
  if (is_follow || await Dialog({title: "是否取消关注?"}) === "confirm") {
    if (await wait(contract.follow(via.USER, user_info.value.user_address))) {
      user_info.value = followCallback(user_info.value)
    }
  }
}


defineOptions({
  name: "UserDetailCard"
})
</script>


<style lang="less" scoped>
</style>

<template>
  <div class="rounded-xl md:shadow-around p-3 flex justify-start items-center gap-2">
    <div class="w-20 h-20">
      <var-avatar :src="avatar(user_info.avatar)" size="80"/>
    </div>

    <div class="flex flex-col justify-start items-start self-start flex-grow">
      <div class="flex justify-start items-center gap-1">
        <div>{{ user_info.nickname }}</div>
        <level-chip :level="calcLevel(user_info.experience.toNumber()).level"/>
      </div>

      <div class="text-gray-500 text-sm">
        {{ user_info.signature || "还没有签名..." }}
      </div>

      <div class="flex justify-start items-center gap-3 mt-2">
        <var-chip size="mini" type="info">粉丝数:{{ user_info.follower_num }}</var-chip>
        <var-chip size="mini" type="warning">热心值:{{ user_info.heart }}</var-chip>
        <var-chip size="mini" type="success">已上传:{{ user_info.uploaded_file_num }}</var-chip>
      </div>
    </div>

    <var-button class="mr-2" text outline type="info">关注</var-button>
  </div>
</template>


<script lang="ts" setup>
import {StoreContact} from "@/assets/types/ethers/ImplementationContact";
import {avatar, calcLevel} from "@/assets/lib/utils";

const props = withDefaults(defineProps<{
  user_info: StoreContact.UserSimpleInfoStructOutput
}>(), {})


defineOptions({
  name: "UserSimpleCard"
})
</script>


<style lang="less" scoped>
</style>

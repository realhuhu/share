<template>
  <div class="flex flex-row justify-start items-start p-6 gap-4 whitespace-nowrap">
    <div class="w-[80px]">
      <var-avatar src="https://varlet.gitee.io/varlet-ui/cat.jpg" size="80"/>
    </div>

    <div class="flex flex-col justify-start items-start">
      <div v-if="!user.is_registered" class="flex gap-2 items-center">
        未授权
        <var-button size="small" type="primary" text outline @click="store.show_register_modal=true">授权</var-button>
      </div>
      <div v-else>
        {{ user.raw_data.nickname }}
      </div>

      <div class="overflow-ellipsis overflow-hidden ... w-full">
        {{ stripAddress(user.address) }}
      </div>
    </div>
  </div>
  <div v-if="user.is_registered" class="flex justify-between items-center px-12 md:px-24">
    <div class="flex flex-col justify-center items-center">
      <div>123</div>
      <div class="text-sm text-gray-500">我的上传</div>
    </div>
    <div>
      <var-divider vertical/>
    </div>
    <div class="flex flex-col justify-center items-center">
      <div>{{ user.raw_data.following_num }}</div>
      <div class="text-sm text-gray-500">我关注的</div>
    </div>
    <div>
      <var-divider vertical/>
    </div>
    <div class="flex flex-col justify-center items-center">
      <div>{{ user.raw_data.follower_num }}</div>
      <div class="text-sm text-gray-500">我的粉丝</div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {stripAddress} from "@/assets/lib/utils";

defineProps<{
  user: User
}>()

const store = UseStore()

defineOptions({
  name: "selfCard"
})
</script>


<style lang="less" scoped>

</style>


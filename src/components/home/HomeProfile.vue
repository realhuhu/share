<template>
  <div>
    <div class="fixed left-0 top-0 w-screen var-elevation--0 h-12 shadow-sm">
    </div>
    <div class="flex flex-col w-screen">
      <div class="flex flex-row justify-start items-start p-6 gap-4 whitespace-nowrap">
        <div class="w-[80px]">
          <var-avatar src="https://varlet.gitee.io/varlet-ui/cat.jpg" size="80"/>
        </div>
        <div>
          <div>阿巴阿巴阿巴</div>
          <div v-if="store.ethereum.address" class="overflow-ellipsis overflow-hidden ... w-full">
            {{ stripAddress(store.ethereum.address) }}
          </div>
        </div>
      </div>

      <div class="flex justify-between items-center px-14">
        <div class="flex flex-col justify-center items-center">
          <div>123</div>
          <div class="text-sm text-gray-500">我的上传</div>
        </div>
        <div>
          <var-divider vertical/>
        </div>
        <div class="flex flex-col justify-center items-center">
          <div>123</div>
          <div class="text-sm text-gray-500">我关注的</div>
        </div>
        <div>
          <var-divider vertical/>
        </div>
        <div class="flex flex-col justify-center items-center">
          <div>123</div>
          <div class="text-sm text-gray-500">我的粉丝</div>
        </div>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {stripAddress} from "@/assets/lib/utils";

const store = UseStore()

defineOptions({
  name: "HomeProfile"
})
</script>


<style lang="less" scoped>
</style>


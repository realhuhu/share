<template>
  <transition enter-active-class="animate__animated animate__fadeInUp"
              leave-active-class="animate__animated animate__fadeOutDown">
    <div class="fixed left-0 md:pl-[64px] bottom-0 w-full flex justify-center items-center"
         v-if="!show_editor">
      <div class="w-[960px] max-w-full shadow-around flex justify-between items-center gap-6 pl-4 bg-white z-30">
        <div @click="show_editor=true"
             class="border-gray-200 border-[1px] px-3 py-1 my-2 rounded flex-grow text-gray-500 cursor-pointer hover:bg-gray-100">
          评论...
        </div>

        <div class="flex justify-end items-center">
          <div class="flex justify-center items-center cursor-pointer hover:bg-gray-100 p-2 md:p-4"
               @click="emits('upAndDown',true)"
               :class="reward_info.up_and_down.toNumber()===1?'text-[#4ebaee]':'text-gray-500'">
            <i-mdi-like-outline class="w-5 h-5 md:w-7 md:h-7"/>
            <div class="text-sm md:text-lg ml-1">{{ reward_info.up_num }}</div>
          </div>
          <div class="flex justify-center items-center cursor-pointer hover:bg-gray-100 p-2 md:p-4"
               @click="emits('upAndDown',false)"
               :class="reward_info.up_and_down.toNumber()===2?'text-[#4ebaee]':'text-gray-500'">
            <i-mdi-dislike-outline class="w-5 h-5  md:w-7 md:h-7"/>
            <div class="text-sm md:text-lg ml-1">{{ reward_info.down_num }}</div>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>


<script lang="ts" setup>
import {Types} from "@/assets/types/ethers/ImplementationInterface";

withDefaults(defineProps<{
  reward_info: Types.RewardDetailInfoStructOutput
}>(), {})

const show_editor = defineModel<boolean>("show_editor", {required: true})
const emits = defineEmits(["upAndDown"])


defineOptions({
  name: "RewardReviewInputBar"
})
</script>


<style lang="less" scoped>
</style>

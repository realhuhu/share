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

        <div class="flex justify-end items-center pr-2">
          <div class="flex justify-center items-center cursor-pointer hover:bg-gray-100 p-2 duration-200"
               @click="emits('upAndDown',true)"
               :class="file_info.up_and_down.toNumber()===1?'text-[#4ebaee]':'text-gray-500'">
            <i-mdi-like-outline class="w-5 h-5"/>
            <div class="text-sm md:text-lg ml-1">{{ file_info.up_num }}</div>
          </div>
          <div class="flex justify-center items-center cursor-pointer hover:bg-gray-100 p-2 duration-200"
               @click="emits('upAndDown',false)"
               :class="file_info.up_and_down.toNumber()===2?'text-[#4ebaee]':'text-gray-500'">
            <i-mdi-dislike-outline class="w-5 h-5"/>
            <div class="text-sm md:text-lg ml-1">{{ file_info.down_num }}</div>
          </div>
          <div class="flex justify-center items-center cursor-pointer hover:bg-gray-100 p-2 duration-200"
               @click="emits('mark')"
               :class="file_info.is_mark?'text-yellow-400':'text-gray-500'">
            <i-clarity-star-line class="w-5 h-5"/>
            <div class="text-sm md:text-lg ml-1">{{ file_info.mark_num }}</div>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>


<script lang="ts" setup>
import {Types} from "@/assets/types/ethers/ImplementationInterface";

withDefaults(defineProps<{
  file_info: Types.FileDetailInfoStructOutput
}>(), {})

const show_editor = defineModel<boolean>("show_editor", {required: true})
const emits = defineEmits(["upAndDown", "mark"])

defineOptions({
  name: "FileReviewInputBar"
})
</script>


<style lang="less" scoped>
</style>

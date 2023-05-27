<template>
  <div class="flex justify-between items-start gap-3">
    <div class="w-12">
      <var-image :src="avatar(comment.author.avatar)" width="48" radius="50%"/>
    </div>

    <div class="break-all flex-grow">
      <div class="flex justify-start items-center gap-2">
        <div class="text-[#4ebaee] font-bold"> {{ comment.author.nickname }}</div>
        <level-chip :level="calcLevel(comment.author.experience.toNumber()).level"/>
      </div>

      <div class="py-2 cursor-pointer" @click="emits('clickRootComment',comment)">
        <div>{{ comment.content }}</div>
        <var-image v-for="(image,k) in comment.images.filter(x=>x.length)" :key="k" :src="`${ipfs_url}ipfs/${image}`"
                   class="max-w-[360px]"/>
      </div>

      <div class="flex justify-between items-center text-gray-500 text-sm">
        <div>{{ datetime(comment.comment_timestamp.toNumber()) }}</div>

        <div class="flex justify-end items-center gap-4">
          <div class="flex justify-center items-center gap-1 cursor-pointer hover:shadow-around"
               :class="comment.up_and_down.toNumber()===1?'text-[#4ebaee]':'text-gray-500'"
               @click="emits('upAndDownRootComment',comment.comment_address,true)">
            <i-mdi-like-outline class="w-5 h-5"/>
            <div>{{ comment.up_num }}</div>
          </div>

          <div class="flex justify-center items-center gap-1 cursor-pointer hover:shadow-around"
               :class="comment.up_and_down.toNumber()===2?'text-[#4ebaee]':'text-gray-500'"
               @click="emits('upAndDownRootComment',comment.comment_address,false)">
            <i-mdi-dislike-outline class="w-5 h-5"/>
            <div>{{ comment.down_num }}</div>
          </div>

          <div class="flex justify-center items-center gap-1 cursor-pointer hover:shadow-around">
            <i-ic-outline-comment class="w-5 h-5"/>
            <div>{{ comment.comment_num }}</div>
          </div>
        </div>

      </div>

      <div v-for="(children_comment,k) in comment.children_comments.filter(x=>x.sub_comment_address!==zero_address)"
           :key="k" class="py-2">
        <div class="flex justify-start items-center gap-2">
          <var-image :src="avatar(children_comment.author.avatar)" width="36" radius="50%"/>
          <div class="flex justify-start items-center gap-2">
            <div class="font-bold">{{ children_comment.author.nickname }}</div>
            <level-chip :level="calcLevel(children_comment.author.experience.toNumber()).level"/>
            <div>{{ children_comment.content }}</div>
          </div>
        </div>
        <div class="flex justify-start items-center gap-6 text-gray-400 text-[10px] pl-11">
          <div>{{ datetime(children_comment.comment_timestamp.toNumber()) }}</div>

          <div class="flex justify-center items-center gap-1">
            <i-mdi-like-outline class="w-5 h-5"/>
            <div>{{ children_comment.up_num }}</div>
          </div>

          <div class="flex justify-center items-center gap-1">
            <i-mdi-dislike-outline class="w-5 h-5"/>
            <div>{{ children_comment.down_num }}</div>
          </div>
        </div>
      </div>

      <div v-if="comment.comment_num>2" class="text-sm p-2 cursor-pointer text-[#4ebaee]">
        查看全部{{ comment.comment_num }}条评论...
      </div>

      <var-divider class="py-2"/>
    </div>

  </div>
</template>


<script lang="ts" setup>

import {Types} from "@/assets/types/ethers/ImplementationContact";
import {avatar, calcLevel, datetime} from "@/assets/lib/utils";
import {ipfs_url, zero_address} from "@/assets/lib/settings";

const props = withDefaults(defineProps<{
  comment: Types.FileRootCommentStructOutput
}>(), {})
const emits = defineEmits(["clickRootComment", "upAndDownRootComment"])


defineOptions({
  name: "RootCommendCard"
})
</script>


<style lang="less" scoped>
</style>

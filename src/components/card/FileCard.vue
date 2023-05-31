<template>
  <var-card
    :src="`${ipfs_url}ipfs/${file_info.cover||cover}`"
    elevation="0"
    layout="row"
    ripple
    @click="router.push(`/file-detail/${file_info.file_address}`)"
    class="cursor-pointer hover:shadow-2xl duration-200"
  >
    <template #title>
      <div class="flex justify-between items-center mt-2 ml-2 gap-1">
        <div class="font-bold line1">{{ file_info.title }}</div>

        <var-tooltip class="flex justify-end items-center text-blue-500 mr-2" :content="`价格：${file_info.price}`">
          <div>{{ file_info.price }}</div>
          <i-tabler-coin class="w-5 h-5"/>
        </var-tooltip>
      </div>
    </template>

    <template #subtitle>
      <div class="flex justify-between items-center">
        <div class="flex justify-start items-center ml-3 text-sm text-gray-500 gap-2">
          <div>{{ file_info.owner }}</div>
          <div>{{ time }}</div>
        </div>

        <var-chip size="mini" color="#4ebaee" text-color="white" class="ml-3">{{ category }}</var-chip>
      </div>
    </template>

    <template #description>
      <div class="mx-3 mt-1 line2 text-sm">{{ file_info.description }}</div>
    </template>

    <template #extra>
      <div class="flex justify-end items-center gap-4 text-sm">
        <div class="flex justify-center items-center gap-1  text-gray-500">
          <i-material-symbols-download/>
          {{ file_info.buyer_num }}
        </div>

        <div class="flex justify-center items-center gap-1"
             :class="file_info.up_and_down.toNumber()===1? 'text-[#4ebaee]':'text-gray-500'">
          <i-mdi-like-outline/>
          {{ file_info.up_num }}
        </div>

        <div class="flex justify-center items-center gap-1"
             :class="file_info.up_and_down.toNumber()===-1? 'text-[#4ebaee]':'text-gray-500'">
          <i-mdi-dislike-outline/>
          {{ file_info.down_num }}
        </div>

        <div class="flex justify-center items-center gap-1 text-gray-500">
          <i-mdi-comment-outline/>
          {{ file_info.comment_num }}
        </div>
      </div>
    </template>
  </var-card>
</template>


<script lang="ts" setup>
import {Types} from "@/assets/types/ethers/ImplementationInterface";

import {cover, ipfs_url} from "@/assets/lib/settings";
import {UseStore} from "@/store";
import {computed} from "vue";
import {useRouter} from "vue-router";
import {datetime} from "@/assets/lib/utils";

const props = withDefaults(defineProps<{
  file_info: Types.FileBriefInfoStructOutput
}>(), {})

const store = UseStore()
const router = useRouter()
const category = computed(() => {
  if (store.categories) {
    for (const i of store.categories) {
      if (i.category_address === props.file_info.category_address) return i.name
    }
  }
  return "未知分类"
})

const time = computed(() => datetime(props.file_info.upload_timestamp.toNumber()))

defineOptions({
  name: "FileCard"
})
</script>


<style lang="less" scoped>
</style>

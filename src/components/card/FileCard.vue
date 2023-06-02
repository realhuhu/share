<template>
  <div class="flex w-full justify-between items-center rounded overflow-hidden cursor-pointer duration-200"
       @click="router.push(`/file-detail/${file_info.file_address}`)">
    <div class="w-32 max-w-[30%] flex-shrink-0">
      <var-image class="w-full h-full object-cover" :src="`${ipfs_url}ipfs/${file_info.cover||cover}`"/>
    </div>

    <div class="flex flex-col flex-grow  justify-between">
      <div class="flex flex-col justify-start items-start p-2">
        <div class="flex justify-between items-center w-full">
          <div class="font-bold line1">{{ file_info.title }}</div>

          <var-tooltip class="flex justify-end items-center text-blue-500" :content="`价格：${file_info.price}`">
            <div>{{ file_info.price }}</div>
            <i-tabler-coin class="w-4 md:w-5"/>
          </var-tooltip>
        </div>

        <div class="flex justify-between items-center w-full">
          <div class="flex justify-start items-center text-sm text-gray-500 gap-2">
            <div>{{ file_info.owner }}</div>
            <div>{{ time }}</div>
          </div>

          <var-chip size="mini" color="#4ebaee" text-color="white" class="ml-3">{{ category }}</var-chip>
        </div>

        <div class="line2 text-sm"> {{ file_info.description }}</div>


      </div>

      <div class="flex justify-end items-center gap-3 md:gap-4 text-sm w-full pb-1 pr-2">
        <div class="flex justify-center items-center gap-1 text-gray-500">
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
    </div>

  </div>
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

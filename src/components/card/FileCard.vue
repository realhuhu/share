<template>
  <var-card
    :subtitle="file_info.description"
    :src="`${ipfs_url}ipfs/${file_info.images[0]||cover}`"
    elevation="0"
    layout="row"
    ripple
    @click="toDetail"
    class="cursor-pointer hover:shadow-2xl duration-200"
  >
    <template #title>
      <div class="flex justify-between items-center h-12 gap-1">
        <div class="flex justify-start items-center gap-1">
          <var-chip size="small" color="#4ebaee" text-color="white" class="font-bold ml-3">{{ category }}</var-chip>
          <div class="font-bold text-lg">{{ file_info.title }}</div>
        </div>
        <var-tooltip class="flex justify-end items-center text-blue-500 mr-2" :content="`价格：${file_info.price}`">
          <div class="text-lg">{{ file_info.price }}</div>
          <i-tabler-coin class="w-5 h-5"/>
        </var-tooltip>
      </div>
    </template>
    <template #extra>
      <div class="flex justify-end items-center gap-4">
        <div class="flex justify-center items-center gap-1  text-gray-500">
          <i-material-symbols-download/>
          {{ file_info.down_num }}
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
import {StoreContact} from "@/assets/types/ethers/ImplementationContact";
import {cover, ipfs_url} from "@/assets/lib/settings";
import {UseStore} from "@/store";
import {computed} from "vue";

const props = withDefaults(defineProps<{
  file_info: StoreContact.FileInfoStructOutput
}>(), {})

const store = UseStore()
const category = computed(() => {
  if (store.categories) {
    for (const i of store.categories) {
      if (i.category_address === props.file_info.category) return i.name
    }
  }
  return "未知分类"
})
const toDetail = () => {
  console.log(1);
}

defineOptions({
  name: ""
})
</script>


<style lang="less" scoped>
</style>

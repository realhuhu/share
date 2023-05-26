<template>
  <div class="rounded-xl md:shadow-around p-6 md:px-16 flex flex-col gap-3">
    <div>
      <div class="text-[24px] font-bold">{{ file_info.title }}</div>
      <div class="text-gray-500 text-sm">{{ stripAddress(file_info.file_address) }}</div>
    </div>

    <div class="flex justify-start items-center gap-3 text-sm text-gray-500">
      <div>{{ datetime(file_info.upload_timestamp.toNumber()) }}</div>
      <div>{{ file_info.up_num }}点赞</div>
      <div>{{ file_info.down_num }}点踩</div>
      <div>{{ file_info.comment_num }}评论</div>
      <div>{{ file_info.buyer_num }}购买</div>
    </div>

    <div>
      {{ file_info.description }}
    </div>

    <div v-if="file_info.is_buy" class="self-center">
      <var-button text outline type="primary" @click="download">
        <i-material-symbols-download/>
        下载
      </var-button>

    </div>
    <div v-else>
      购买
    </div>

    <div>
      <var-chip size="small">{{ category }}</var-chip>
    </div>


  </div>
</template>


<script lang="ts" setup>
import {Types} from "@/assets/types/ethers/ImplementationContact";
import {datetime, stripAddress} from "@/assets/lib/utils";
import {UseStore} from "@/store";
import {computed} from "vue";
import {ipfs_url} from "@/assets/lib/settings";

const props = withDefaults(defineProps<{
  file_info: Types.FileDetailInfoStructOutput
}>(), {})

const store = UseStore()

const category = computed(() => {
  if (store.categories) {
    for (const i of store.categories) {
      if (i.category_address === props.file_info.category_address) return i.name
    }
  }
  return "未知分类"
})

const download = () => {
  window.open(`${ipfs_url}ipfs/${props.file_info.ipfs_address}?filename=${props.file_info.name}`)
}

defineOptions({
  name: "FileInfoCard"
})
</script>


<style lang="less" scoped>
</style>

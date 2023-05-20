<template>
  <var-card
    :title="file_info.title"
    :subtitle="file_info.description"
    :src="`${ipfs_url}ipfs/${file_info.images[0]||cover}`"
    elevation="0"
    layout="row"
  >
    <template #extra>
      <var-button text round>
        <var-icon name="download" @click="download"/>
      </var-button>
      <var-button round text>
        <var-icon name="heart"/>
      </var-button>
    </template>
  </var-card>
</template>


<script lang="ts" setup>
import {StoreContact} from "@/assets/types/ethers/ImplementationContact";
import {DateParser} from "@/assets/lib/utils";
import {computed} from "vue";
import {cover, ipfs_url} from "@/assets/lib/settings";

const props = withDefaults(defineProps<{
  file_info: StoreContact.FileInfoStructOutput
}>(), {})


const upload_time = computed(() => {
  return new DateParser(props.file_info.upload_timestamp.toNumber()).all()
})

const download = () => {
  window.open(`${ipfs_url}ipfs/${props.file_info.ipfs_address}`)
}

defineOptions({
  name: ""
})
</script>


<style lang="less" scoped>
</style>

<template>
  <div class="px-3">
    <div class="font">{{ file_info.title }}</div>
    <div>{{ upload_time }}</div>
    {{file_info.buyer_num}}
  </div>
</template>


<script lang="ts" setup>
import {StoreContact} from "@/assets/types/ethers/ImplementationContact";
import {DateParser} from "@/assets/lib/utils";
import {computed} from "vue";

const props = withDefaults(defineProps<{
  file_info: StoreContact.FileInfoStructOutput
}>(), {})

const upload_time = computed(() => {
  return new DateParser(props.file_info.upload_timestamp.toNumber()).all()
})

defineOptions({
  name: ""
})
</script>


<style lang="less" scoped>
</style>

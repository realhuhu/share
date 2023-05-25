<template>
  <div>
    <head-bar title="我上传的文件" back="/home/resource"/>

    <div class=" flex flex-col items-center justify-center md:mt-16 gap-4 rounded-xl">
      <var-list
        class="w-[720px] max-w-full p-3"
        :finished="finished"
        v-model:loading="loading"
        @load="load"
        :immediate-check="false"
      >
        <div v-for="(file_info,k) in files" :key="k" class="my-3">
          <transition enter-active-class="animate__animated animate__fadeIn" appear>
            <div class="flex flex-col justify-center items-end">
              <div class="text-gray-500">{{ date(file_info.upload_timestamp.toNumber()) }}</div>
              <file-card class="shadow-around" :file_info="file_info as StoreContact.FileBriefInfoStructOutput"/>
            </div>
          </transition>
        </div>
      </var-list>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {ref} from "vue";
import {assertNotEmpty, DateParser} from "@/assets/lib/utils";
import {safeBack} from "@/router";
import {head_address, tail_address, zero_address} from "@/assets/lib/settings";
import {StoreContact} from "@/assets/types/ethers/ImplementationContact";

const store = UseStore()
const cursor = ref<string>()
const reverse = ref(false)
const loading = ref(false)
const finished = ref(false)
const files = ref<StoreContact.FileBriefInfoStructOutput[]>([])
const load = async () => {
  const contract = assertNotEmpty(store.contract, "合约未初始化")
  if (!cursor.value) cursor.value = reverse.value ? tail_address : head_address
  const {file_infos, next} = await contract.getSelfFileBriefInfos(cursor.value, reverse.value)
  for (const file_info of file_infos) {
    if (file_info.file_address === zero_address) {
      finished.value = true
      break
    }
    files.value.push(file_info)
    cursor.value = next
  }
  loading.value = false
}

const date = (timestamp: number) => new DateParser(timestamp).all()

load()

defineOptions({
  name: "SelfUpload"
})
</script>


<style lang="less" scoped>
</style>

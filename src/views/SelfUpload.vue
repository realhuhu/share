<template>
  <div>
    <var-app-bar color="#f2f4f6" text-color="#666" elevation="0">
      我上传的文件
      <template #left>
        <var-button round text color="transparent" text-color="#4ebaee" @click="safeBack('/home/resource')">
          <var-icon name="chevron-left" :size="24"/>
        </var-button>
      </template>
    </var-app-bar>

    <div class=" flex items-center justify-center md:mt-16">
      <div class="w-[720px] flex flex-col gap-4 pt-4 rounded-xl">
        <var-list
          :finished="finished"
          v-model:loading="loading"
          @load="load"
          :immediate-check="false"
        >
          <div v-for="(file_info,k) in files" :key="k">
            <file-card :file_info="file_info as StoreContact.FileInfoStructOutput"/>
          </div>
        </var-list>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {ref} from "vue";
import {assertNotEmpty} from "@/assets/lib/utils";
import {safeBack} from "@/router";
import {head_address, tail_address, zero_address} from "@/assets/lib/settings";
import {StoreContact} from "@/assets/types/ethers/ImplementationContact";

const store = UseStore()
const cursor = ref<string>()
const reverse = ref(false)
const loading = ref(false)
const finished = ref(false)
const files = ref<StoreContact.FileInfoStructOutput[]>([])
const load = async () => {
  const contract = assertNotEmpty(store.contract, "合约未初始化")
  if (!cursor.value) cursor.value = reverse.value ? tail_address : head_address
  const {file_infos, next} = await contract.getSelfFileInfos(cursor.value, reverse.value)
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

load()

defineOptions({
  name: "SelfUpload"
})
</script>


<style lang="less" scoped>
</style>

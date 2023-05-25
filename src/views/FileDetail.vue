<template>
  <div>
    <head-bar title="文件详情" back="/home/resource"/>

    <div class="flex items-center justify-center md:pt-12 md:pt-0">
      <div class="w-[960px] max-w-full md:mt-24 md:px-6 flex flex-col gap-3">
        <transition enter-active-class="animate__animated animate__fadeIn" appear>
          <file-info-card v-if="file_info" :file_info="file_info"/>
        </transition>

        <transition enter-active-class="animate__animated animate__fadeIn" appear>
          <user-simple-card v-if="user_info" :user_info="user_info"/>
        </transition>

        <var-divider class="md:hidden" margin="0"/>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {useRoute} from "vue-router";
import {UseStore} from "@/store";
import {assertNotEmpty} from "@/assets/lib/utils";
import {ref} from "vue";
import {StoreContact} from "@/assets/types/ethers/ImplementationContact";
import FileInfoCard from "@/components/card/FileInfoCard.vue";

const route = useRoute()
const store = UseStore()
const file_info = ref<StoreContact.FileDetailInfoStructOutput>()
const user_info = ref<StoreContact.UserSimpleInfoStructOutput>()
const contract = assertNotEmpty(store.contract, "合约未初始化")
const file_address = typeof route.params.file_address === "string" ? route.params.file_address : route.params.file_address[0]

const init = async () => {
  file_info.value = await contract.getFileDetailInfo(file_address)
  user_info.value = await contract.getOtherSimpleInfo(file_info.value?.owner)
}

init()

defineOptions({
  name: "FileDetail"
})
</script>


<style lang="less" scoped>
</style>

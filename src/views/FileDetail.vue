<template>
  <div>
    <head-bar title="文件详情" back="/home/resource"/>

    <div class="flex flex-col items-center justify-center ">
      <div class="w-[960px] max-w-full md:mt-6 lg:mt-24 md:px-6 flex flex-col gap-1 md:gap-3">
        <transition enter-active-class="animate__animated animate__fadeIn" appear>
          <file-info-card v-if="file_info" :file_info="file_info"/>
        </transition>

        <transition enter-active-class="animate__animated animate__fadeIn" appear>
          <user-simple-card v-if="user_info" v-model:user_info="user_info"/>
        </transition>

        <var-divider class="md:hidden w-full" margin="0"/>

        <transition enter-active-class="animate__animated animate__fadeIn" appear>
          <file-review-card v-if="file_info" v-model:file_info="file_info"/>
        </transition>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {useRoute} from "vue-router";
import {UseStore} from "@/store";
import {assertNotEmpty} from "@/assets/lib/utils";
import {ref} from "vue";
import {via} from "@/assets/lib/settings";
import {Types} from "@/assets/types/ethers/ImplementationInterface";

const route = useRoute()
const store = UseStore()
const file_info = ref<Types.FileDetailInfoStructOutput>()
const user_info = ref<Types.UserSimpleInfoStructOutput>()
const contract = assertNotEmpty(store.contract, "合约未初始化")
const file_address = typeof route.params.file_address === "string" ? route.params.file_address : route.params.file_address[0]

const init = async () => {
  file_info.value = await contract.getFileDetailInfo(via.FILE, file_address)
  user_info.value = await contract.getOtherSimpleInfo(via.USER, file_info.value?.owner)
}

init()

defineOptions({
  name: "FileDetail"
})
</script>


<style lang="less" scoped>
</style>

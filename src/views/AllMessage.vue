<template>
  <div>
    <head-bar title="消息" back="/home/resource"/>
    <div class="flex flex-col items-center justify-center ">
      <div class="w-[960px] max-w-full md:mt-24 md:px-6 flex flex-col md:flex-row">
        <var-tabs
          class="md:!w-[80px] md:!h-[120px] flex"
          :layout-direction="store.is_mobile?'horizontal':'vertical'"
          v-model:active="active">
          <var-tab>评论</var-tab>
          <var-tab>点赞</var-tab>
        </var-tabs>

        <transition enter-active-class="animate__animated animate__fadeIn" appear>
          <reply-message-card v-if="active==0"/>
          <up-message-card v-else-if="active===1"/>
        </transition>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>

import {ref} from "vue";
import {UseStore} from "@/store";
import UpMessageCard from "@/components/card/UpMessageCard.vue";

const store = UseStore()
const active = ref(0)

defineOptions({
  name: "AllMessage"
})
</script>


<style lang="less" scoped>
.tabs-example-vertical {
  width: 80px !important;
  height: 120px !important;
}
</style>

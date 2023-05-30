<template>
  <div>
    <head-bar title="返回" back="/home/resource"/>

    <div class=" flex items-center justify-center md:mt-16">
      <div class="w-screen md:w-[720px] md:shadow-around md:p-12 rounded-3xl">
        <var-tabs class="flex" v-model:active="active">
          <var-tab class="px-6">上传文件</var-tab>
          <var-tab class="px-6">创建悬赏</var-tab>
        </var-tabs>

        <var-divider margin="0"/>

        <var-tabs-items v-model:active="active">
          <var-tab-item>
            <upload-file-card/>
          </var-tab-item>
          <var-tab-item>
            <upload-reward-card/>
          </var-tab-item>
        </var-tabs-items>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import UploadFileCard from "@/components/card/UploadFileCard.vue";
import {ref} from "vue";
import UploadRewardCard from "@/components/card/UploadRewardCard.vue";

const active = ref(0)

defineOptions({
  name: "UploadFileOrReward"
})
</script>


<style lang="less" scoped>
</style>


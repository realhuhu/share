<template>
  <var-popup v-model:show="store.show_default_wallet_modal" class="rounded">
    <div class="w-[90vw] max-w-[600px] flex flex-col justify-center items-center">
      <var-tabs v-model:active="active" class="w-full">
        <var-tab>登录新账号</var-tab>
        <var-tab>解锁账号</var-tab>
      </var-tabs>
      <i-logos-ethereum-color class="h-12 w-12 mt-6"/>
      <var-tabs-items v-model:active="active">
        <var-tab-item>
          <div class="flex flex-col justify-center items-center p-6">
            <div class="px-2 pb-4 w-full">
              <var-input placeholder="请输入秘钥" v-model="private_key"/>
            </div>
            <div class="px-2 pb-4 w-full">
              <var-input placeholder="请输入密码" v-model="password"/>
            </div>
            <div class="px-2 pb-2 w-full">
              <var-button type="success" block @click="save" :disabled="!private_key||!password">保存</var-button>
            </div>
          </div>
        </var-tab-item>
        <var-tab-item>
          <div class="flex flex-col justify-center items-center p-6">
            <div class="px-2 pb-4 w-full">
              <var-input placeholder="请输入密码" v-model="encrypt_key"/>
            </div>
            <div class="px-2 pb-2 w-full">
              <var-button type="success" block @click="save" :disabled="!private_key||!password">解锁</var-button>
            </div>
          </div>
        </var-tab-item>
      </var-tabs-items>
    </div>
  </var-popup>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {ref} from "vue";

const store = UseStore()

const active = ref<0 | 1>(0)
const private_key = ref<string>()
const password = ref<string>()
const encrypt_key = ref<string>()

const save = () => {
  console.log(1);
}

defineOptions({
  name: "DefaultWalletModal"
})
</script>


<style lang="less" scoped>

</style>


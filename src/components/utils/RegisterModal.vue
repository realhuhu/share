<template>
  <var-popup v-model:show="store.showRegisterModal" class="rounded">
    <div class="flex flex-col justify-center items-center w-[90vw] max-w-[600px] p-6">
      <var-divider margin="0">授权以太坊账号</var-divider>
      <i-logos-ethereum-color class="h-12 w-12 mt-6"/>
      <div class="px-2 pb-4 w-full">
        <var-input placeholder="请输入昵称(允许重复)" v-model="name"/>
      </div>

      <div class="px-2 pb-2 w-full">
        <var-button type="success" block @click="register" :disabled="!name">授权</var-button>
      </div>

      <div class="text-xs text-gray-500 px-2">
        将会使用您的账号({{ stripAddress(store.address) }})调用合约，在合约中创立账户
      </div>
    </div>
  </var-popup>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {assertNotEmpty, stripAddress} from "@/assets/lib/utils";
import {ref} from "vue";

const store = UseStore()
const name = ref<string>()
const register = async () => {
  const nickname = assertNotEmpty(name.value, "昵称不能为空")
  const UserContract = assertNotEmpty(store.UserContract, "用户合约为初始化")
  const res = await UserContract.register(nickname)
  await res.wait()
}

defineOptions({
  name: "RegisterModal"
})
</script>


<style lang="less" scoped>

</style>


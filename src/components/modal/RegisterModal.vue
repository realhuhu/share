<template>
  <var-popup v-model:show="store.show_register_modal" class="rounded">
    <div class="flex flex-col justify-center items-center w-[90vw] max-w-[600px] p-6">
      <var-divider margin="0">授权以太坊账号</var-divider>
      <i-logos-ethereum-color class="h-12 w-12 mt-6"/>
      <div class="px-2 pb-4 w-full">
        <var-input placeholder="请输入昵称(允许重复)" v-model="name"/>
      </div>

      <div class="px-2 pb-2 w-full">
        <var-button type="success" block @click="register" :disabled="!name||uploading">
          {{ uploading ? "处理中..." : "授权" }}
        </var-button>
      </div>

      <div v-if="store.contracts_connected" class="text-xs text-gray-500 px-2">
        将会使用您的账号({{ stripAddress((store.user as User).address) }})调用合约，在合约中创立账户
      </div>
    </div>
  </var-popup>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {assertNotEmpty, stripAddress} from "@/assets/lib/utils";
import {ref} from "vue";
import {via} from "@/assets/lib/settings";

const store = UseStore()
const name = ref<string>()
const uploading = ref(false)

const register = async () => {
  const nickname = assertNotEmpty(name.value, "昵称不能为空")
  const contract = assertNotEmpty(store.contract, "用户合约未初始化")
  uploading.value = true
  try {
    const res = await contract.register(via.USER, nickname)
    await res.wait()
    uploading.value = false
    const user = assertNotEmpty(store.user, "用户未初始化")
    await store.refreshUser(user.address)
    store.show_register_modal = false
  } catch {
    uploading.value = false
  }
}

defineOptions({
  name: "RegisterModal"
})
</script>


<style lang="less" scoped>

</style>


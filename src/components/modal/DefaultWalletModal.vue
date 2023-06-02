<template>
  <var-popup v-model:show="store.show_default_wallet_modal" class="rounded">
    <div class="w-[90vw] max-w-[600px] flex flex-col justify-center items-center">
      <var-tabs v-model:active="active" class="w-full">
        <var-tab>注册账号</var-tab>
        <var-tab>登录账号</var-tab>
        <var-tab v-if="encrypt_key">解锁账号</var-tab>
      </var-tabs>
      <i-logos-ethereum-color class="h-12 w-12 mt-6"/>
      <var-tabs-items v-model:active="active">
        <var-tab-item>
          <div class="flex flex-col justify-center items-center p-6">
            <div class="px-2 pb-4 w-full">
              <var-input placeholder="请输入密码" size="small" variant="outlined" v-model="password"/>
            </div>
            <var-button type="success" block @click="fastLogin" :disabled="!password">注册并登录</var-button>
          </div>
        </var-tab-item>

        <var-tab-item>
          <div class="flex flex-col justify-center items-center p-6">
            <div class="px-2 pb-4 w-full">
              <var-input placeholder="请输入秘钥" size="small" variant="outlined" v-model="private_key"/>
            </div>
            <div class="px-2 pb-4 w-full">
              <var-input placeholder="请输入密码" size="small" variant="outlined" v-model="password"/>
            </div>
            <div class="px-2 pb-2 w-full">
              <var-button type="success" block @click="login" :disabled="!private_key||!password">登录</var-button>
            </div>
          </div>
        </var-tab-item>

        <var-tab-item>
          <div class="flex flex-col justify-center items-center p-6">
            <div class="px-2 pb-4 w-full">
              <var-input placeholder="请输入密码" size="small" variant="outlined" v-model="password"/>
            </div>
            <div class="px-2 pb-2 w-full">
              <var-button type="success" block @click="unlock" :disabled="!password">解锁</var-button>
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
import {ethers} from "ethers";
import CryptoJS from "crypto-js"
import {Snackbar} from "@varlet/ui";

const store = UseStore()
const encrypt_key = ref(localStorage.getItem("encrypt_key"))
const active = ref<number>(encrypt_key.value ? 2 : 0)
const private_key = ref<string>()
const password = ref<string>()


const unlock = async () => {
  if (!encrypt_key.value || !password.value) return
  const private_key = CryptoJS.AES.decrypt(encrypt_key.value, password.value).toString(CryptoJS.enc.Utf8)
  console.log(private_key);
  if (private_key) {
    const provider = new ethers.providers.JsonRpcProvider("https://testnet.seutools.com/rpc")
    const wallet = new ethers.Wallet(private_key, provider)
    await store.connectContracts(wallet)
    await store.connectContracts(wallet.connect(provider))
    await store.refreshUser(wallet.address)
    store.ethereum_connected = true
    store.contracts_connected = true
    store.show_default_wallet_modal = false
  } else {
    Snackbar({
      content: "密码错误",
      type: "warning",
      duration: 1000
    })
  }
}

const login = async () => {
  if (!private_key.value || !password.value) return

  const provider = new ethers.providers.JsonRpcProvider("https://testnet.seutools.com/rpc")
  try {
    const wallet = new ethers.Wallet(private_key.value, provider)
    await store.connectContracts(wallet)
    await store.connectContracts(wallet.connect(provider))
    await store.refreshUser(wallet.address)
    store.ethereum_connected = true
    store.contracts_connected = true
    store.show_default_wallet_modal = false
    localStorage.setItem("encrypt_key", CryptoJS.AES.encrypt(wallet.privateKey, password.value).toString())
  } catch {
    Snackbar({
      content: "秘钥错误",
      type: "warning",
      duration: 1000
    })
  }
}

const fastLogin = async () => {
  if (!password.value) return

  const wallet = ethers.Wallet.createRandom()
  const provider = new ethers.providers.JsonRpcProvider("https://testnet.seutools.com/rpc")
  const signer = provider.getSigner()
  await signer.sendTransaction({from: signer.getAddress(), to: wallet.address, value: ethers.utils.parseEther("100")})
  await store.connectContracts(wallet.connect(provider))
  await store.refreshUser(wallet.address)
  localStorage.setItem("encrypt_key", CryptoJS.AES.encrypt(wallet.privateKey, password.value).toString())
  store.ethereum_connected = true
  store.contracts_connected = true
  store.show_default_wallet_modal = false
}

defineOptions({
  name: "DefaultWalletModal"
})
</script>


<style lang="less" scoped>

</style>


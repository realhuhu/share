<template>
  <div>
    <var-app-bar color="#f2f4f6" text-color="#666" elevation="0">
      创建以太坊账号
      <template #left>
        <var-button round text color="transparent" text-color="#4ebaee" @click="safeBack('/home/profile')">
          <var-icon name="chevron-left" :size="24"/>
        </var-button>
      </template>

      <template #right>
        <var-button round text color="transparent">
          <var-icon name="help-circle-outline" :size="24"/>
        </var-button>
      </template>

    </var-app-bar>
    <div class="md:flex md:justify-start md:items-center md:flex-col md:mt-6">
      <div class="md:w-[500px] md:border md:rounded-2xl md:shadow-around">
        <var-tabs color="transparent" class="border-b" v-model:active="active">
          <var-tab>随机生成</var-tab>
          <var-tab>根据密钥</var-tab>
          <var-tab>根据助记词</var-tab>
        </var-tabs>
        <var-tabs-items v-model:active="active">
          <var-tab-item>
            <div class="m-6">
              <transition enter-active-class="animate__animated animate__fadeIn" appear>
                <div class="mb-6" v-if="result">
                  <text-clipboard class="mt-6" title="地址" :text="result.address"/>
                  <text-clipboard class="mt-6" title="私钥" :text="result.private_key"/>
                  <text-clipboard class="mt-6" title="公钥" :text="result.public_key"/>
                  <text-clipboard v-if="result.mnemonic_phrase" class="mt-6" title="助记词"
                                  :text="result.mnemonic_phrase"/>
                </div>
              </transition>
              <var-button type="info" color="#66bb6a" block @click="randomCreate()">点击生成</var-button>
            </div>
          </var-tab-item>
          <var-tab-item>
            <div class="m-6">
              <var-input
                placeholder="请输入密钥"
                class="mb-6 border rounded p-1"
                :hint="false"
                :line="false"
                v-model="private_key"
              />
              <transition enter-active-class="animate__animated animate__fadeIn" appear>
                <div class="mb-6" v-if="result">
                  <text-clipboard class="mt-6" title="地址" :text="result.address"/>
                  <text-clipboard class="mt-6" title="私钥" :text="result.private_key"/>
                  <text-clipboard class="mt-6" title="公钥" :text="result.public_key"/>
                  <text-clipboard v-if="result.mnemonic_phrase" class="mt-6" title="助记词"
                                  :text="result.mnemonic_phrase"/>
                </div>
              </transition>
              <var-button type="info" color="#66bb6a" block @click="randomCreate()">点击生成</var-button>
            </div>
          </var-tab-item>
          <var-tab-item>
            <div class="m-6">
              <var-input
                placeholder="请输入12个助记词"
                class="mb-6 border rounded p-1"
                :hint="false"
                :line="false"
                v-model="mnemonic_phrase"
              />
              <transition enter-active-class="animate__animated animate__fadeIn" appear>
                <div class="mb-6" v-if="result">
                  <text-clipboard class="mt-6" title="地址" :text="result.address"/>
                  <text-clipboard class="mt-6" title="私钥" :text="result.private_key"/>
                  <text-clipboard class="mt-6" title="公钥" :text="result.public_key"/>
                  <text-clipboard v-if="result.mnemonic_phrase" class="mt-6" title="助记词"
                                  :text="result.mnemonic_phrase"/>
                </div>
              </transition>
              <var-button type="info" color="#66bb6a" block @click="randomCreate()">点击生成</var-button>
            </div>
          </var-tab-item>
        </var-tabs-items>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {ref, watch} from "vue";
import {ethers} from "ethers";
import TextClipboard from "@/components/utils/TextClipboard.vue";
import {Snackbar} from "@varlet/ui";
import {safeBack} from "@/router";

const active = ref<0 | 1 | 2>(0)

type Result = {
  public_key: string,
  private_key: string,
  address: string,
  mnemonic_phrase?: string,
}


const result = ref<Result>()
const private_key = ref<string>()
const mnemonic_phrase = ref<string>()
const randomCreate = () => {
  if (result.value) result.value = undefined;
  let wallet

  switch (active.value) {
    case 0:
      wallet = ethers.Wallet.createRandom()
      break
    case 1:
      if (!private_key.value) {
        Snackbar({content: "请输入密钥", type: "warning", duration: 1000})
        return
      }
      try {
        wallet = new ethers.Wallet(private_key.value)
      } catch (e) {
        Snackbar({content: "请输入正确密钥！", type: "warning", duration: 1000})
        return;
      }
      break
    case 2:
      if (!mnemonic_phrase.value) {
        Snackbar({content: "请输入12个助记词", type: "warning", duration: 1000})
        return
      }
      try {
        wallet = ethers.Wallet.fromMnemonic(mnemonic_phrase.value)
      } catch (e) {
        Snackbar({content: "请输入正确助记词！", type: "warning", duration: 1000})
        return;
      }
      break

  }

  result.value = {
    public_key: wallet.publicKey,
    private_key: wallet.privateKey,
    address: ethers.utils.computeAddress(wallet.publicKey),
    mnemonic_phrase: wallet.mnemonic?.phrase
  }
}

watch(active, () => {
  result.value = undefined
})

defineOptions({
  name: "CreateEthAccount"
})

</script>


<style lang="less" scoped>

</style>


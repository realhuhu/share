<template>
  <div class="min-h-[100vh]">
    <div class="lg:flex lg:justify-center">
      <div class="flex flex-col md:mt-10 lg:mt-20 md:border md:mx-[10%] lg:w-[860px] lg:mx-0  md:shadow-around md:rounded-2xl">
        <div v-if="store.contracts_connected">
          <suspense>
            <user-self-card :user="store.user as User"/>
            <template #fallback>
              <var-loading type="wave" class="py-10"/>
            </template>
          </suspense>
        </div>
        <div v-else class="text-center py-10 text-2xl font-bold">
          未连接到钱包
        </div>

        <var-divider margin="0" class="pt-2 lg:pt-6">我的</var-divider>
        <div class="flex justify-start items-center flex-wrap">

          <div class="w-[25%] md:px-10 rounded">
            <div
              class="flex flex-col justify-center items-center py-2 cursor-pointer hover:shadow-around"
              @click="router.push('/self-reward')"
              ripple
            >
              <i-fxemoji-moneybag class="w-8 h-8 md:m-2"/>
              <div class="font-thin text-xs md:text-sm">悬赏</div>
            </div>

          </div>
        </div>

        <var-divider margin="0" class="lg:pt-6">其它</var-divider>

        <div class="flex justify-start items-center flex-wrap">

          <div class="w-[25%] md:px-10 md:pb-5 rounded">
            <div
              class="flex flex-col justify-center items-center py-2 cursor-pointer hover:shadow-around"
              @click="router.push('/create-eth-account')"
              ripple
            >
              <i-logos-ethereum-color class="w-8 h-8 md:m-2"/>
              <div class="font-thin text-xs md:text-sm">以太坊账户</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import {UseStore} from "@/store";
import {useRouter} from "vue-router";
import UserSelfCard from "@/components/card/UserSelfCard.vue";

const store = UseStore()
const router = useRouter()

defineOptions({
  name: "HomeProfile"
})
</script>


<style lang="less" scoped>
</style>


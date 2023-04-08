<template>
  <div>
    <div class="fixed md:hidden left-0 top-0 w-screen var-elevation--0 h-12 shadow-sm">
    </div>

    <div class="lg:flex lg:justify-center">
      <div class="flex flex-col md:mt-20 md:border md:mx-[10%] lg:w-[860px] lg:mx-0  md:shadow-around md:rounded-2xl">
        <div class="flex flex-row justify-start items-start p-6 gap-4 whitespace-nowrap">
          <div class="w-[80px]">
            <var-avatar src="https://varlet.gitee.io/varlet-ui/cat.jpg" size="80"/>
          </div>
          <div>
            <div>阿巴阿巴阿巴</div>
            <div v-if="store.ethereum.address" class="overflow-ellipsis overflow-hidden ... w-full">
              {{ stripAddress(store.ethereum.address) }}
            </div>
          </div>
        </div>

        <div class="flex justify-between items-center px-12 md:px-24">
          <div class="flex flex-col justify-center items-center">
            <div>123</div>
            <div class="text-sm text-gray-500">我的上传</div>
          </div>
          <div>
            <var-divider vertical/>
          </div>
          <div class="flex flex-col justify-center items-center">
            <div>123</div>
            <div class="text-sm text-gray-500">我关注的</div>
          </div>
          <div>
            <var-divider vertical/>
          </div>
          <div class="flex flex-col justify-center items-center">
            <div>123</div>
            <div class="text-sm text-gray-500">我的粉丝</div>
          </div>
        </div>

        <div class="m-6">
          <var-divider margin="0">其它</var-divider>
          <div class="flex justify-start items-center flex-wrap">

            <div class="w-[25%] md:px-10 rounded">
              <div
                class="flex flex-col justify-center items-center py-2 cursor-pointer hover:shadow-around"
                @click="router.push('/create-eth-account')"
                v-ripple
              >
                <i-logos-ethereum-color class="h-8 md:h-12"/>
                <div class="font-thin text-xs md:text-sm">注册以太坊</div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import {UseStore} from "@/store";
import {stripAddress} from "@/assets/lib/utils";
import {useRouter} from "vue-router";

const store = UseStore()
const router = useRouter()

defineOptions({
  name: "HomeProfile"
})
</script>


<style lang="less" scoped>
</style>


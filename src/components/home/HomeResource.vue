<template>
  <div class="flex flex-col items-center justify-center md:pt-0">
    <home-header class="flex md:hidden"/>

    <div class="w-[1280px] max-w-full lg:mt-24 lg:px-6">

      <var-sticky class="md:hidden">
        <var-tabs v-model:active="current_category" class="h-8">
          <var-tab v-for="(category,k) of store.categories" :key="k" :name="category.category_address">
            {{ category.name }} ({{ category.num }})
          </var-tab>
        </var-tabs>
        <var-divider margin="0"/>
      </var-sticky>

      <var-sticky>
        <div class=" bg-white lg:py-2 border-gray-100 border">
          <var-button text v-for="(category,k) of store.categories" :key="k" class="hidden md:inline"
                      @click="current_category=category.category_address"
                      :class="current_category===category.category_address?'text-[#4ebaee] underline':'text-gray-500'">
            {{ category.name }} ({{ category.num }})
          </var-button>
        </div>
      </var-sticky>

      <div class="flex justify-end p-1 lg:py-2 text-sm">
        <var-menu placement="bottom-end" class="cursor-pointer md:hover:bg-gray-100 duration-75"
                  v-model:show="show_menu">
          <div class="flex justify-start items-center text-gray-500">
            {{ orders[current_order].text }}
            <var-icon name="menu-down"/>
          </div>

          <template #menu>
            <div v-for="(order,k) in orders" :key="k" :class="k===current_order?'text-[#4ebaee]':''"
                 class="cursor-pointer hover:bg-blue-100  py-1 px-2 duration-200 text-sm" @click="current_order=k">
              {{ order.text }}
            </div>
          </template>
        </var-menu>
      </div>

      <var-list
        class="w-[1280px] max-w-full pb-24 min-h-screen"
        :finished="finished"
        v-model:loading="loading"
        @load="load"
      >
        <div class="flex items-start justify-start flex-wrap">
          <div v-for="(file_info,k) in files" :key="k" class="lg:w-[50%] w-full p-1 md:p-2">
            <transition enter-active-class="animate__animated animate__fadeIn" appear>
              <file-card class="shadow-around hover:shadow-xl" :file_info="file_info as Types.FileBriefInfoStructOutput"/>
            </transition>
          </div>
        </div>

        <div v-if="!finished&&!loading" class="text-center text-gray-500">下滑加载</div>
      </var-list>
    </div>
  </div>
</template>


<script lang="ts" setup>
import HomeHeader from "@/components/home/HomeHeader.vue";
import {UseStore} from "@/store";
import {ref, watch} from "vue";
import {head_address, tail_address, via, zero_address} from "@/assets/lib/settings";
import {assertNotEmpty} from "@/assets/lib/utils";
import {Types} from "@/assets/types/ethers/ImplementationInterface";


const store = UseStore()
const orders = ref([
  {
    text: "最近上传",
    type: 0,
    reverse: true
  },
  {
    text: "最早上传",
    type: 0,
    reverse: false
  },
  {
    text: "价格降序",
    type: 1,
    reverse: false
  },
  {
    text: "价格升序",
    type: 1,
    reverse: true
  },
  {
    text: "最多下载",
    type: 1,
    reverse: false
  }
])
const current_category = ref(zero_address)
const current_order = ref(0)
const show_menu = ref(false)

const cursor = ref<string>(tail_address)

const files = ref<Types.FileBriefInfoStructOutput[]>([])
const loading = ref(false)
const finished = ref(false)

const clear = () => {
  files.value = []
  loading.value = false
  finished.value = false
  cursor.value = orders.value[current_order.value].reverse ? tail_address : head_address
}
const load = async () => {
  const contract = assertNotEmpty(store.contract, "合约未初始化")
  const {type, reverse} = orders.value[current_order.value]
  const res = await contract.getFileBriefInfos(via.FILE, cursor.value, current_category.value, type, reverse)
  finished.value = res.finished
  cursor.value = res.next
  for (let file_info of res.file_infos) {
    if (file_info.file_address === zero_address) break
    if (files.value.map(x => x.file_address).indexOf(file_info.file_address) !== -1) break
    files.value.push(file_info)
  }
  loading.value = false
}

watch(current_order, async () => {
  show_menu.value = false
  await clear()
  await load()
})

watch(current_category, async () => {
  await clear()
  await load()
})

load()

defineOptions({
  name: "HomeResource"
})
</script>


<style lang="less" scoped>

</style>

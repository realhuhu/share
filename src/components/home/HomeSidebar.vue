<template>
  <div class="fixed h-screen top-0 bg-white w-16 var-elevation--2 flex-col justify-between items-center gap-3 py-2">
    <div class="flex flex-col items-center">
      <var-avatar src="https://varlet.gitee.io/varlet-ui/cat.jpg"/>
      <var-divider/>
      <div class="flex flex-col items-center gap-2">
        <div class="hover:shadow-around cursor-pointer rounded-2xl duration-75 active:bg-gray-100 w-10 h-10"
             @click="replace('/home/resource')">
          <var-tooltip content="资料" placement="right">
            <i-material-symbols-format-list-bulleted
              class="text-gray-500 w-10 h-10 p-1.5 hover:text-gray-700 duration-75"/>
          </var-tooltip>
        </div>
        <div class="hover:shadow-around cursor-pointer rounded-2xl duration-75 active:bg-gray-100 w-10 h-10"
             @click="replace('/home/reward')">
          <var-tooltip content="悬赏" placement="right">
            <i-material-symbols-currency-exchange-rounded
              class="text-gray-500 w-10 h-10 p-1.5 hover:text-gray-700 duration-75"/>
          </var-tooltip>
        </div>
        <div class="hover:shadow-around cursor-pointer rounded-2xl duration-75 active:bg-gray-100 w-10 h-10"
             @click="replace('/home/favorite')">
          <var-tooltip content="收藏" placement="right">
            <i-mdi-cards-heart-outline class="text-gray-500 w-10 h-10 p-1.5 hover:text-gray-700 duration-75"/>
          </var-tooltip>
        </div>
        <div class="hover:shadow-around cursor-pointer rounded-2xl duration-75 active:bg-gray-100 w-10 h-10"
             @click="replace('/home/profile')">
          <var-tooltip content="我的" placement="right">
            <i-pajamas-profile class="text-gray-500 w-10 h-10 p-1.5 hover:text-gray-700 duration-75"/>
          </var-tooltip>
        </div>
      </div>
      <var-divider/>
      <div class="flex flex-col items-center gap-2">
        <div class="hover:shadow-around cursor-pointer rounded-2xl duration-75 active:bg-gray-100 w-10 h-10 gap-2"
             @click="router.push('/search')">
          <var-tooltip content="搜索" placement="right">
            <i-material-symbols-search class="text-gray-700 w-10 h-10 p-1.5 hover:text-gray-900 duration-75"/>
          </var-tooltip>
        </div>
        <div class="hover:shadow-around cursor-pointer rounded-2xl duration-75 active:bg-gray-100 w-10 h-10">
          <var-tooltip content="消息" placement="right">
            <i-mdi-message-processing-outline class="text-gray-700 w-10 h-10 p-1.5 hover:text-gray-900 duration-75"/>
          </var-tooltip>
        </div>
      </div>
    </div>

    <div
      class="flex flex-col items-center justify-center w-12 h-12 rounded-xl hover:shadow-around cursor-pointer duration-75  active:bg-gray-100">
      <i-material-symbols-add class="text-blue-600 w-10 h-8"/>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {withDefaults} from "vue"
import {useRouter} from "vue-router";

interface Props {
  active: number
}

const router = useRouter()
const emits = defineEmits(["update:active"])
withDefaults(defineProps<Props>(), {active: 0})

const replace = (page: HomePagePath) => {
  router.replace(page)
  emits("update:active", ["/home/resource", "/home/reward", "/home/favorite", "/home/profile"].indexOf(page))
}

defineOptions({
  name: "HomeNavbar"
})
</script>


<style lang="less" scoped>

</style>


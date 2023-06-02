<template>
  <div class="h-7 bg-gray-200 rounded-full flex whitespace-nowrap justify-start items-center border-black"
       @click="TODO('敬请期待')">
    <i-material-symbols-search class="ml-1.5"/>
    <div class="text-gray-600 text-sm ml-1.5 overflow-ellipsis overflow-hidden ..."
         v-if="!redirect">{{ default_text }}
    </div>
    <div v-else>233</div>
  </div>
</template>


<script lang="ts" setup>
import {useRouter} from "vue-router";
import {TODO} from "@/assets/lib/utils";

const props = withDefaults(defineProps<{
  default_text?: Nullable<string>
  redirect?: Nullable<string>
}>(), {
  default_text: "点击搜索",
  redirect: null
})

const router = useRouter()

const search = () => {
  if (props.redirect) {
    router.push(props.redirect)
  }
}

defineOptions({
  name: "SearchBar"
})
</script>


<style lang="less" scoped>

</style>


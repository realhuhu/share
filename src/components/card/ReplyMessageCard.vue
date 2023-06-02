<template>
  <var-list
    class="bg-white w-full text-sm"
    :finished="finished"
    v-model:loading="loading"
    @load="load"
  >
    <div v-for="(message,k) in messages" :key="k" @click="toDetail(k)">
      <div class="flex justify-between items-start p-2 gap-4 cursor-pointer hover:bg-gray-100 duration-200 rounded">
        <div class="flex justify-start items-start gap-2 flex-grow">
          <div class="w-10">
            <var-image :src="avatar(message.avatar)" radius="50" width="40"/>
          </div>
          <div class="w-full">
            <div class="font-bold line1">
              {{ message.nickname }}
            </div>
            <div class="mb-2">回复了你的{{ type(message.target_type.toNumber())}}</div>
            <div class="border-l-[2px] border-gray-300 bg-gray-50 p-1">{{ message.content}}</div>
          </div>
        </div>

        <div class="line2 w-16">{{ message.target }}</div>
      </div>
    </div>
  </var-list>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {assertNotEmpty, avatar} from "@/assets/lib/utils";
import {head_address, tail_address, via, zero_address} from "@/assets/lib/settings";
import {ref} from "vue";
import {Types} from "@/assets/types/ethers/ImplementationInterface";
import {useRouter} from "vue-router";

const store = UseStore()
const router = useRouter()
const cursor = ref(head_address)
const messages = ref<Types.ReplyMessageInfoStructOutput[]>([])
const loading = ref(false)
const finished = ref(false)
const contract = assertNotEmpty(store.contract, "合约未初始化")

const load = async () => {
  const res = await contract.getReplyMessages(via.MESSAGE, tail_address)
  for (const reply_message_info of res.reply_message_infos) {
    if (reply_message_info.target_address === zero_address) break
    messages.value.push(reply_message_info)
    cursor.value = res.next
  }
  loading.value = false
  finished.value = res.finished
}

const type = (target_type: number) => {
  switch (target_type) {
    case 0:
      return "文件"
    case 3:
      return "悬赏"
    default:
      return "评论"
  }
}

const toDetail = (k: number) => {
  switch (messages.value[k].target_type.toNumber()) {
    case 0:
    case 1:
    case 2:
      router.push(`/file-detail/${messages.value[k].target_address}`)
      break
    case 3:
    case 4:
    case 5:
      router.push(`/reward-detail/${messages.value[k].target_address}`)
      break
  }
}

defineOptions({
  name: "ReplyMessageCard"
})
</script>


<style lang="less" scoped>
</style>

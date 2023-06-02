<template>
  <div class="flex flex-col items-center justify-center ">
    <head-bar title="返回" back="/home/profile"/>

    <div class="w-[768px] max-w-full md:shadow-around md:mt-12">
      <var-tabs class="flex" v-model:active="active" @change="reload">
        <var-tab>我的关注</var-tab>
        <var-tab>我的粉丝</var-tab>
      </var-tabs>

      <var-list
        class="p-6 bg-white"
        :finished="finished"
        v-model:loading="loading"
        @load="load"
        :immediate-check="false"
      >
        <div v-for="(user_info,k) in users" :key="k">
          <transition enter-active-class="animate__animated animate__fadeIn" appear>
            <div class="flex justify-between items-center">
              <div class="flex justify-start items-center gap-2">
                <var-avatar :src="avatar(user_info.avatar)" size="48"/>
                <div class="flex flex-col justify-center items-start">
                  <div class="font-bold">{{ user_info.nickname }}</div>
                  <div class="text-sm text-gray-500">{{ stripAddress(user_info.user_address) }}</div>
                </div>
              </div>

              <var-button v-if="user_info.is_following" class="mr-2" text outline type="danger"
                          @click="follow(k,false)">取消关注
              </var-button>
              <var-button v-else class="mr-2" text outline type="info" @click="follow(k,true)">关注</var-button>
            </div>
          </transition>
          <var-divider/>
        </div>
      </var-list>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {ref} from "vue";
import {useRoute} from "vue-router";
import {UseStore} from "@/store";
import {assertNotEmpty, avatar, followCallback, stripAddress, wait} from "@/assets/lib/utils";
import {head_address, via, zero_address} from "@/assets/lib/settings";
import {Types} from "@/assets/types/ethers/ImplementationInterface";
import {Dialog} from "@varlet/ui";

const store = UseStore()
const route = useRoute()
const active = ref<number>(route.params.type === "following" ? 1 : 0)
const cursor = ref(head_address)
const users = ref<Types.UserBriefInfoStructOutput[]>([])
const loading = ref(false)
const finished = ref(false)
const contract = assertNotEmpty(store.contract, "合约未初始化")

const load = async () => {
  if (active.value) {
    const res = await contract.getFollowers(via.USER, cursor.value)
    for (const user_info of res.follower_infos) {
      if (user_info.user_address === zero_address) break
      users.value.push(user_info)
      cursor.value = res.next
    }
    loading.value = false
    finished.value = res.finished
  } else {
    const res = await contract.getFollowings(via.USER, cursor.value)
    for (const user_info of res.following_infos) {
      if (user_info.user_address === zero_address) break
      users.value.push(user_info)
      cursor.value = res.next
    }
    loading.value = false
    finished.value = res.finished
  }
}

const follow = async (index: number, is_follow: boolean) => {
  if (is_follow || await Dialog({title: "是否取消关注?"}) === "confirm") {
    if (await wait(contract.follow(via.USER, users.value[index].user_address))) {
      users.value[index] = followCallback(users.value[index])
    }
  }
}

const reload = async () => {
  cursor.value = head_address
  users.value = []
  loading.value = false
  finished.value = false
  await load()
}

load()


defineExpose({active})
</script>


<style lang="less" scoped>
</style>

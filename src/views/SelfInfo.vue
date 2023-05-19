<template>
  <div>
    <div class="fixed left-0 top-0 w-screen h-screen bg-gray-50 z-[-1]"></div>
    <div>
      <var-app-bar color="#f2f4f6" text-color="#666" elevation="0">
        我的信息
        <template #left>
          <var-button round text color="transparent" text-color="#4ebaee" @click="safeBack('/home/profile')">
            <var-icon name="chevron-left" :size="24"/>
          </var-button>
        </template>
      </var-app-bar>
    </div>

    <div v-if="!(<User>store.user).is_registered" class="mt-12 text-center font-bold text-lg">
      请先
      <span class="text-blue-500" @click="store.show_register_modal=true">授权</span>
    </div>

    <var-pull-refresh v-else v-model="refreshing" @refresh="refresh" class="h-[100vh-100px] lg:flex lg:justify-center">
      <div class="md:mt-20 md:border md:mx-[10%] lg:w-[860px] lg:mx-0  md:rounded-2xl">
        <div class="bg-white px-2 py-0.5 mt-2">
          <var-divider margin="0"/>

          <div class="flex justify-between items-center h-20 px-2 cursor-pointer hover:bg-gray-100 duration-75" v-ripple
               @click="edit('avatar')">
            <div class="w-32">头像</div>
            <div class="flex justify-end items-center gap-2">
              <var-avatar :src="store!.user!.avatar_b64 as string" size="60"/>
              <var-icon name="chevron-right"/>
            </div>
          </div>

          <var-divider margin="0"/>

          <div class="flex justify-between items-center h-10 px-2 cursor-pointer hover:bg-gray-100 duration-75" v-ripple
               @click="edit('nickname')">
            <div class="w-32">用户名</div>
            <div class="flex justify-end items-center gap-2">
              <div class="text-gray-500">{{ store!.user!.raw_data!.nickname }}</div>
              <var-icon name="chevron-right"/>
            </div>
          </div>

          <var-divider margin="0"/>

          <div class="flex justify-between items-center min-h-[40px] px-2 cursor-pointer hover:bg-gray-100 duration-75"
               v-ripple @click="edit('signature')">
            <div class="w-32">签名</div>
            <div class="flex justify-end items-center gap-2">
              <div class="text-gray-500">{{ store!.user!.raw_data!.signature || "还没有签名..." }}</div>
              <var-icon name="chevron-right"/>
            </div>
          </div>

          <var-divider margin="0"/>

          <div class="flex justify-between items-center min-h-[40px]  px-2">
            <div class="w-32 text-gray-500">注册日期</div>
            <div class="text-gray-500">
              {{ login_data }}
            </div>
          </div>

          <var-divider margin="0"/>
        </div>

        <div class="bg-white my-2 px-2 py-0.5">
          <var-divider margin="0"/>
          <div class="p-2 h-10 flex items-center justify-between gap-2" v-ripple @click="TODO('敬请期待')">
            <div>东南大学学生身份认证</div>
            <var-icon name="chevron-right"/>
          </div>
          <var-divider margin="0"/>
        </div>

        <div class="text-center my-12 text-gray-400 md:hidden">下拉刷新</div>
      </div>
    </var-pull-refresh>


    <var-popup class="rounded" v-model:show="show_popup" v-if="popup_type">
      <div class="flex flex-col justify-center items-center w-[90vw] max-w-[600px] p-6 gap-3">
        <var-divider margin="0">{{ popup_config[popup_type].title }}</var-divider>
        <var-input
          v-if="popup_type!=='signature'"
          class="w-full"
          variant="outlined"
          :placeholder="popup_config[popup_type].description"
          size="small"
          :maxlength="popup_config[popup_type].maxLength"
          v-model="popup_input"/>
        <var-input
          v-else
          class="w-full"
          variant="outlined"
          :placeholder="popup_config[popup_type].description"
          :maxlength="popup_config[popup_type].maxLength"
          textarea
          v-model="popup_input"/>
        <var-button block type="success" :disabled="!popup_input||uploading" @click="update">
          {{ uploading ? "处理中..." : "确定" }}
        </var-button>
      </div>
    </var-popup>
  </div>
</template>


<script lang="ts" setup>
import {safeBack} from "@/router";
import {UseStore} from "@/store";
import {DateParser, TODO, assertNotEmpty} from "@/assets/lib/utils";
import {computed, ref, watch} from "vue";
import {Snackbar} from "@varlet/ui";

const popup_config_raw = {
  avatar: {
    title: "生成头像",
    description: "输入字符串，将根据字符串生成随机图像",
    maxLength: 10
  },
  nickname: {
    title: "更换昵称",
    description: "输入新昵称",
    maxLength: 10
  },
  signature: {
    title: "修改签名",
    description: "输入新签名",
    maxLength: 32
  }
}
const uploading = ref(false)

const popup_config = ref(popup_config_raw)
const popup_input = ref<string>()
const store = UseStore()
const show_popup = ref(false)
const refreshing = ref(false)
const popup_type = ref<keyof typeof popup_config_raw>()

const edit = (edit_type: keyof typeof popup_config_raw) => {
  show_popup.value = true
  popup_type.value = edit_type
}

const update = async () => {
  if (!popup_input.value) return

  const contract = assertNotEmpty(store.contract, "合约未初始化")
  let handler
  switch (popup_type.value) {
    case "avatar":
      handler = contract.updateAvatar(popup_input.value)
      break
    case "nickname":
      handler = contract.updateNickname(popup_input.value)
      break
    case "signature":
      handler = contract.updateSignature(popup_input.value)
      break
  }
  if (handler) {
    uploading.value = true
    try {
      await handler
      uploading.value = false
      show_popup.value = false
      popup_input.value = undefined
      Snackbar({
        content: "需要等待几秒数据更新",
        type: "success",
        duration: 2000
      })
    } catch {
      uploading.value = false
    }
  }
}

watch(show_popup, (new_value: boolean) => {
  if (!new_value) popup_input.value = undefined
})

const refresh = async () => {
  const user = assertNotEmpty(store.user, "用户数据获取失败")
  await store.refreshUser(user.address)
  refreshing.value = false
}

const login_data = computed(() => new DateParser(store?.user?.raw_data?.login_timestamp.toNumber()).all())

defineOptions({
  name: "SelfInfo"
})
</script>


<style lang="less" scoped>

</style>


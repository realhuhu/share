<template>
  <div class="flex flex-row justify-between items-center pt-6 px-6 gap-4 whitespace-nowrap">
    <div class="w-[80px]">
      <var-avatar :src="avatar" size="80"/>
    </div>

    <div class="flex-grow place-self-start flex flex-col justify-start items-start">
      <div v-if="!user.is_registered" class="flex gap-2 items-center">
        未授权
        <var-button size="small" type="primary" text outline @click="store.show_register_modal=true">授权</var-button>
      </div>
      <div v-else>
        <div class="flex justify-start items-center">
          <div>{{ user.raw_data.nickname }}</div>
          <div class="text-gray-400 text-sm">({{ stripAddress(user.address) }})</div>
        </div>
        <experience-bar :experience="0"/>

        <div class="flex gap-2 py-2">
          <var-tooltip content="硬币数" placement="bottom">
            <var-chip size="small" color="#" class="hover:shadow-around">
              <span>{{ user.raw_data.coins }}</span>
              <template #left>
                <i-tabler-coin class="text-blue-500 w-5 h-5"/>
              </template>
            </var-chip>
          </var-tooltip>

          <var-tooltip content="热心值" placement="bottom">
            <var-chip size="small" class="hover:shadow-around">
              <span>{{ user.raw_data.heart }}</span>
              <template #left>
                <i-material-symbols-local-fire-department-outline class="text-red-500 w-5 h-5"/>
              </template>
            </var-chip>
          </var-tooltip>
        </div>
      </div>
    </div>

    <var-icon name="chevron-right" size="30" @click="router.push('/self-info')"
              class="flex justify-center rounded-full hover:text-blue-500 hover:shadow-around p-2 cursor-pointer"/>
  </div>

  <div v-if="user.is_registered">
    <div class="px-8 pt-1 pb-3 text-gray-500 md:px-12 md:pt-3">{{ user.raw_data.signature }}</div>
    <div class="hidden md:block px-12 py-6">
      <var-divider margin="0" dashed/>
    </div>
    <div class="flex justify-between items-center px-12 md:px-24 ">
      <div class="flex flex-col justify-center items-center cursor-pointer p-2 hover:text-blue-500" @click="router.push('/self-upload')">
        <div>{{ user.raw_data.uploaded_file_num }}</div>
        <div class="text-sm text-gray-500">我的上传</div>
      </div>
      <div>
        <var-divider vertical/>
      </div>
      <div class="flex flex-col justify-center items-center">
        <div>{{ user.raw_data.following_num }}</div>
        <div class="text-sm text-gray-500">我关注的</div>
      </div>
      <div>
        <var-divider vertical/>
      </div>
      <div class="flex flex-col justify-center items-center">
        <div>{{ user.raw_data.follower_num }}</div>
        <div class="text-sm text-gray-500">我的粉丝</div>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {stripAddress} from "@/assets/lib/utils";
import {computed} from "vue";
import {useRouter} from "vue-router";

const props = defineProps<{
  user: User
}>()

const avatar = computed(() => {
  return props.user.is_registered ? props.user.avatar_b64 : "https://varlet.gitee.io/varlet-ui/cat.jpg"
})

const store = UseStore()
const router = useRouter()

defineOptions({
  name: "selfCard"
})
</script>


<style lang="less" scoped>

</style>


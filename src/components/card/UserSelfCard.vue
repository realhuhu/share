<template>
  <div class="flex flex-row justify-between items-center p-4 md:p-6 gap-4 whitespace-nowrap">
    <div class="w-[80px]">
      <var-avatar :src="avatar" class="w-20 h-20"/>
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
        <experience-bar :experience="user.raw_data.experience.toNumber()"/>

        <div class="flex gap-2 py-2">
          <var-tooltip content="硬币数" placement="bottom">
            <var-chip size="small" class="hover:shadow-around">
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
    <div class="text-gray-500 px-5 md:px-7 lg:px-9">{{ user.raw_data.signature || "还没有签名..." }}</div>
    <div class="hidden md:block px-12 py-4">
      <var-divider margin="0" dashed/>
    </div>
    <div class="flex justify-between items-center text-gray-500 px-12 md:px-24 ">
      <div class="flex flex-col justify-center items-center cursor-pointer p-2 hover:text-blue-500"
           @click="router.push('/self-upload')">
        <div>{{ user.raw_data.uploaded_file_num }}</div>
        <div class="text-sm">我的上传</div>
      </div>
      <div>
        <var-divider vertical/>
      </div>
      <div class="flex flex-col justify-center items-center cursor-pointer p-2 hover:text-blue-500"
           @click="router.push('/follow/follower')">
        <div>{{ user.raw_data.following_num }}</div>
        <div class="text-sm">我关注的</div>
      </div>
      <div>
        <var-divider vertical/>
      </div>
      <div class="flex flex-col justify-center items-center cursor-pointer p-2 hover:text-blue-500"
           @click="router.push('/follow/following')">
        <div>{{ user.raw_data.follower_num }}</div>
        <div class="text-sm">我的粉丝</div>
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

const avatar = computed(() => props.user.is_registered ? props.user.avatar_b64 : "https://varlet.gitee.io/varlet-ui/cat.jpg")

const store = UseStore()
const router = useRouter()

defineOptions({
  name: "UserSelfCard.vue"
})
</script>


<style lang="less" scoped>

</style>


<template>
  <div class="navbar-wrapper fixed w-screen bottom-0 z-10">
    <var-bottom-navigation :active="active" @change="emits('update:active',$event)">
      <var-bottom-navigation-item
          label="资料"
          icon="format-list-checkbox"
          @click="router.replace('/home/resource')"
      />
      <var-bottom-navigation-item
          label="悬赏"
          icon="cart-outline"
          @click="router.replace('/home/reward')"
      />
      <var-bottom-navigation-item
          label="消息"
          icon="message-processing-outline"
          @click="router.replace('/home/favorite')"
      />
      <var-bottom-navigation-item
          label="我的"
          icon="account-circle-outline"
          @click="router.replace('/home/profile')"
      />

      <template #fab>
        <var-icon name="plus" size="30"/>
      </template>
    </var-bottom-navigation>
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
defineOptions({
  name: "HomeNavbar"
})
</script>


<style lang="less" scoped>

</style>


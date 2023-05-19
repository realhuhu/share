<template>
  <div class="fixed w-screen left-0 bottom-0 z-10 shadow-x">
    <var-bottom-navigation :active="active">
      <var-bottom-navigation-item
        label="资料"
        icon="format-list-checkbox"
        @click="replace('/home/resource')"
      />
      <var-bottom-navigation-item
        label="悬赏"
        icon="cart-outline"
        @click="replace('/home/reward')"
      />
      <var-bottom-navigation-item
        label="收藏"
        icon="heart-outline"
        @click="replace('/home/favorite')"
      />
      <var-bottom-navigation-item
        label="我的"
        icon="account-circle-outline"
        @click="replace('/home/profile')"
      />
      <template #fab>
        <var-icon name="plus" size="30" @click="router.push('/upload-file')"/>
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


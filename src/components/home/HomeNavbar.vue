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
        <var-icon name="plus" size="30" @click="router.push('/upload')"/>
      </template>
    </var-bottom-navigation>
  </div>
</template>


<script lang="ts" setup>
import {useRouter} from "vue-router";


const active = defineModel<number>("active", {required: true, default: 0})
const router = useRouter()


const replace = (page: HomePagePath) => {
  router.replace(page)
  active.value = ["/home/resource", "/home/reward", "/home/favorite", "/home/profile"].indexOf(page)
}

defineOptions({
  name: "HomeNavbar"
})
</script>


<style lang="less" scoped>

</style>


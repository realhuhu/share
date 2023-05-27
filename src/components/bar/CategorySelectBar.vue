<template>
  <var-select v-if="store.categories" placeholder="分类" variant="outlined" v-model="category">
    <var-option v-for="category in store.categories.filter(x=>x.category_address!==zero_address)"
                :label="category.name" :value="category.category_address" :key="category.category_address"/>
  </var-select>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {zero_address} from "@/assets/lib/settings";

const category = defineModel("category", {required: true})
const store = UseStore()


defineOptions({
  name: "CategorySelectBar"
})
</script>


<style lang="less" scoped>
</style>

<template>
  <var-select v-if="store.categories" placeholder="分类" variant="outlined" v-model="_category">
    <var-option v-for="category in store.categories.filter(x=>x.category_address!==zero_address)"
                :label="category.name" :value="category.category_address" :key="category.category_address"/>
  </var-select>
</template>


<script lang="ts" setup>
import {UseStore} from "@/store";
import {computed} from "vue";
import {zero_address} from "@/assets/lib/settings";

const props = defineProps(["category"])
const emits = defineEmits(["update:category"])

const store = UseStore()

const _category = computed({
  get: () => props.category,
  set: val => emits("update:category", val)
})

defineOptions({
  name: "CategorySelectBar"
})
</script>


<style lang="less" scoped>
</style>

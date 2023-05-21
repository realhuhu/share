<template>
  <div class="w-44" v-if="rank">
    <div class="flex items-end justify-between">
      <level-chip :level="rank.level"/>
      <div class="text-gray-500 text-xs py-0.5">{{ rank.experience }}/{{ rank.total }}</div>
    </div>
    <var-progress :value="100*(rank.experience>rank.total?1:rank.experience/rank.total)"/>
  </div>
</template>


<script lang="ts" setup>
import {ref} from "vue";
import {calcLevel} from "@/assets/lib/utils";
import LevelChip from "@/components/utils/LevelChip.vue";

const props = defineProps<{
  experience: number
}>()


const rank = ref(calcLevel(props.experience))


defineOptions({
  name: "ExperienceBar"
})
</script>


<style lang="less" scoped>

</style>


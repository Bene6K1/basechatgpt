<template>
  <AnimatePresence mode="sync">
    <motion.div
      v-if="IsKeysMenuOpen"
      class="absolute bottom-[50px] -translate-x-1/2 left-1/2 overflow-hidden"
      :initial="{ opacity: 0 }"
      :animate="{ opacity: 1 }"
      :exit="{ opacity: 0 }"
      :transition="{ duration: 0.25 }"
    >
      <div
        class="border rounded-[6px] px-[12px] py-[6px] flex gap-[12px] w-full h-full overflow-hidden relative border-[#1F2022] bg-[#000000BF]">
        <template v-for="(item, index) in KeysMenu" :key="index">
          <div class="flex items-center gap-x-[8px]">
            <div
              class="min-w-[22px] w-max h-[22px] flex items-center justify-center rounded-[1px] bg-[#FFFFFF] px-[6px]"
            >
              <p class="font-['Montserrat-Bold'] text-sm text-[#000] uppercase">
                {{ item.key }}
              </p>
            </div>
            <p class="font-['Montserrat-Regular'] text-sm text-[#FFFFFF]/80">
              {{ item.description }}
            </p>
          </div>
        </template>
      </div>
    </motion.div>
  </AnimatePresence>
</template>

<script setup>
  import { AnimatePresence, motion } from "motion-v";
  import { useDefaultData } from "@store/index";
  import { storeToRefs } from "pinia";

  const StoreData = useDefaultData();
  const { IsKeysMenuOpen, KeysMenu } = storeToRefs(StoreData);
</script>
<template>
  <AnimatePresence mode="sync">
    <motion.div v-if="IsContextMenu" class="absolute top-1/6 right-1/6 w-[350px] border-[#1F2022] border bg-[#151618] overflow-hidden" style="border-radius: calc(0.5rem - 1px);" :initial="{ opacity: 0, scale: 0.75 }" :animate="{ opacity: 1, scale: 1 }" :exit="{ opacity: 0, scale: 0.75 }" :transition="{ duration: 0.2 }">
      <div class="w-full h-max flex items-center justify-between border-b-[#1F2022] border-b p-2.5">
        <p class="font-semibold text-base text-[#f3f4f6]">{{ ConextMenu.header }}</p>
        <div class="w-max h-max p-1 cursor-pointer" @click="CloseContextMenu">
          <i class="fa-regular fa-xmark w-[20px] h-[20px] text-[#d1d5dc] text-[20px]"></i>
        </div>
      </div>
      <div class="w-full h-max max-h-[460px] overflow-y-auto overflow-x-hidden scroll-smooth scroll-style">
        <template v-for="(item, index) in ConextMenu.items" :key="index">
          <div class="w-full h-max flex flex-col items-start cursor-pointer hover:bg-[#202225] transition-all duration-300 p-2.5 gap-1" @click="SelectedItem(item.id, ConextMenu.id);">
            <div class="w-max h-max pt-1 flex items-center gap-x-1.5">
              <div class="pl-1 w-max h-max">
                <i :class="`fa-solid fa-${item.icon} w-[18px] h-[18px] text-[#e5e7eb] text-[18px]`"></i>
              </div>
              <p class="font-semibold text-base text-[#e5e7eb]">{{ item.label }}</p>
            </div>
            <p class="text-sm text-[#d1d5dc]/[80%]">{{ item.description }}</p>
          </div>
          <hr class="border-[#1F2022]" v-if="index !== ConextMenu.items.length - 1" />
        </template>
      </div>
    </motion.div>
  </AnimatePresence>
</template>

<script setup>
  import { AnimatePresence, motion } from 'motion-v';
  import { useDefaultData } from '@store/index';
  import { storeToRefs } from 'pinia';
  import { FetchNUI } from '@utils/index';

  const StoreData = useDefaultData();
  const { IsContextMenu, ConextMenu } = storeToRefs(StoreData);

  const CloseContextMenu = () => {
    IsContextMenu.value = false;
    FetchNUI('CLOSE_CONTEXT_MENU');
  };

  const SelectedItem = (itemId, contextId) => {
    IsContextMenu.value = false;
    FetchNUI('SELECTED_CONTEXT_MENU_ITEM', {
      itemId: itemId,
      contextId: contextId,
    });
  };
</script>

<style scoped>
.scroll-style::-webkit-scrollbar {
  width: 0px;
}
</style>
<template>
  <AnimatePresence mode="sync">
    <motion.div v-if="IsHotwireOpen" class="w-[946px] h-[754px] bg-[#0C1319F7] rounded-[14px] overflow-hidden relative" :initial="{ opacity: 0, scale: 0.75 }" :animate="{ opacity: 1, scale: 1 }" :exit="{ opacity: 0, scale: 0.75 }" :transition="{ duration: 0.2 }">
      <div class="w-full h-full" style="background-image: url('/images/hotwire-bg.png'); background-size: cover; background-position: center;mix-blend-mode: color-dodge;">
      </div>
      <div class="w-[355px] h-[87px] bg-[#1482E1] rounded-[355px] absolute left-[-97px] top-[-72px] z-10" style="filter: blur(89.5px);"></div>
      <div class="w-full h-[208px] absolute top-0 left-0 z-[1]" style="background: linear-gradient(180deg, #0C1319 0%, rgba(12, 19, 25, 0.00) 100%);"></div>
      <div class="w-full flex items-center justify-between absolute top-[0] left-[0] px-[34px] pt-[34px] z-[1000000000000]">
        <div class="flex items-center">
          <div class="w-[30px] h-[30px] flex items-center justify-center rounded-[2px] border-[.5px] border-solid border-[#FFFFFF] mr-[10px]" style="background: radial-gradient(50% 50% at 50% 50%, rgba(255, 255, 255, 0.25) 0%, rgba(153, 153, 153, 0.25) 100%);">
            <img src="/svgs/console.svg" alt="console-icon" class="w-[16px] h-[16px] object-contain" draggable="false" />
          </div>
          <div class="flex items-center gap-x-[9px]">
            <p class="font-['Purista-Medium'] text-[#FFFFFF] text-[32px] leading-tight" style="text-shadow: 0 0 23.2px rgba(255, 255, 255, 0.55);">{{ Locales.hotwire.game_name }}</p>
            <p class="w-[290px] text-[#FFFFFFA8] font-['Purista-Medium'] text-[12px] leading-tight line-clamp-2">{{ Locales.hotwire.game_description }}</p>
          </div>
        </div>
        <div class="w-[30px] h-[30px] flex items-center justify-center rounded-[2px] border-[.5px] border-solid border-[#FF363A]" style="background: radial-gradient(50% 50% at 50% 50%, rgba(255, 54, 58, 0.25) 0%, rgba(255, 54, 58, 0.25) 100%);box-shadow: 0 4px 31.7px 0 rgba(255, 54, 58, 0.55);" @click="CloseHotwire()">
          <img src="/svgs/exit.svg" alt="x-icon" class="w-[14px] h-[14px] object-contain" draggable="false" >
        </div>
      </div>
      <div class="w-[662px] h-[575px] absolute bottom-[68px] left-1/2 -translate-x-1/2 z-[100] flex items-center gap-x-[108px]">
        <img src="/images/yellow-cable.png" alt="yellow-cable" class="absolute top-[20px] left-[19px] z-[1]" draggable="false" />
        <img src="/images/purple-cable.png" alt="purple-cable" class="absolute top-[20px] left-[174px] z-[1]" draggable="false" />
        <img v-if="!showingCables.blue_to_blue" id="blue_draggable_1" src="/images/bottom-blue-line.png" alt="bottom-blue-line" class="absolute top-[350px] left-[3.5px] z-50 cursor-move" draggable="false" />
        <img v-if="!showingCables.blue_to_blue" id="blue_draggable_2" src="/images/top-blue-line.png" alt="top-blue-line" class="absolute top-[20px] left-[286px] z-50 cursor-move" draggable="false" />
        <img v-if="!showingCables.green_to_green" id="green_draggable_1" src="/images/bottom-green-line.png" alt="bottom-green-line" class="absolute top-[350px] left-[620px] z-50 cursor-move" draggable="false" />
        <img v-if="!showingCables.white_to_white" id="white_draggable_2" src="/images/top-green-line.png" alt="top-green-line" class="absolute top-[20px] left-[594px] z-50 cursor-move" draggable="false" />
        <img v-if="!showingCables.white_to_white" id="white_draggable_1" src="/images/bottom-white-line.png" alt="bottom-white-line" class="absolute top-[418px] left-[449px] z-50 cursor-move" draggable="false" />
        <img v-if="!showingCables.green_to_green" id="green_draggable_2" src="/images/top-white-line.png" alt="top-white-line" class="absolute top-[20px] left-[469px] z-50 cursor-move" draggable="false" />
        <img v-if="showingCables.blue_to_blue" src="/images/blue-to-blue-cable.png" alt="blue-to-blue-cable" class="absolute top-[20px] left-[19px] z-[1]" draggable="false" />
        <img v-if="showingCables.green_to_green" src="/images/white-to-green-cable.png" alt="white-to-green-cable" class="absolute top-[20px] left-[478px] z-[1]" draggable="false" />
        <img v-if="showingCables.white_to_white" src="/images/green-to-white-cable.png" alt="green-to-white-cable" class="absolute top-[20px] left-[480px] z-[1]" draggable="false" />
        <div class="flex flex-col items-center gap-y-[483px]">
          <div class="w-[46px] h-[46px] rounded-full border-x-[1.5px] border-t-[1.5px] border-b-[1.5px] border-b-transparent border-solid border-[#FFFFFF40] flex items-center justify-center">
            <div class="w-[16px] h-[16px] rounded-full bg-[#FFF]"></div>
          </div>
          <div class="w-[46px] h-[46px] rounded-full border-x-[1.5px] border-b-[1.5px] border-t-[1.5px] border-t-transparent border-solid border-[#FFFFFF40] flex items-center justify-center">
            <div class="w-[16px] h-[16px] rounded-full bg-[#FFF]"></div>
          </div>
        </div>
        <div class="flex flex-col items-center gap-y-[483px]">
          <div class="w-[46px] h-[46px] rounded-full border-x-[1.5px] border-t-[1.5px] border-b-[1.5px] border-b-transparent border-solid border-[#FFFFFF40] flex items-center justify-center">
            <div class="w-[16px] h-[16px] rounded-full bg-[#FFF]"></div>
          </div>
          <div class="w-[46px] h-[46px] rounded-full border-x-[1.5px] border-b-[1.5px] border-t-[1.5px] border-t-transparent border-solid border-[#FFFFFF40] flex items-center justify-center">
            <div class="w-[16px] h-[16px] rounded-full bg-[#FFF]"></div>
          </div>
        </div>
        <div class="flex flex-col items-center gap-y-[483px]">
          <div class="w-[46px] h-[46px] rounded-full border-x-[1.5px] border-t-[1.5px] border-b-[1.5px] border-b-transparent border-solid border-[#FFFFFF40] flex items-center justify-center">
            <div class="w-[16px] h-[16px] rounded-full bg-[#FFF]"></div>
          </div>
          <div class="w-[46px] h-[46px] rounded-full border-x-[1.5px] border-b-[1.5px] border-t-[1.5px] border-t-transparent border-solid border-[#FFFFFF40] flex items-center justify-center">
            <div class="w-[16px] h-[16px] rounded-full bg-[#FFF]"></div>
          </div>
        </div>
        <div class="flex flex-col items-center gap-y-[483px]">
          <div class="w-[46px] h-[46px] rounded-full border-x-[1.5px] border-t-[1.5px] border-b-[1.5px] border-b-transparent border-solid border-[#FFFFFF40] flex items-center justify-center">
            <div class="w-[16px] h-[16px] rounded-full bg-[#FFF]"></div>
          </div>
          <div class="w-[46px] h-[46px] rounded-full border-x-[1.5px] border-b-[1.5px] border-t-[1.5px] border-t-transparent border-solid border-[#FFFFFF40] flex items-center justify-center">
            <div class="w-[16px] h-[16px] rounded-full bg-[#FFF]"></div>
          </div>
        </div>
        <div class="flex flex-col items-center gap-y-[483px]">
          <div class="w-[46px] h-[46px] rounded-full border-x-[1.5px] border-t-[1.5px] border-b-[1.5px] border-b-transparent border-solid border-[#FFFFFF40] flex items-center justify-center">
            <div class="w-[16px] h-[16px] rounded-full bg-[#FFF]"></div>
          </div>
          <div class="w-[46px] h-[46px] rounded-full border-x-[1.5px] border-b-[1.5px] border-t-[1.5px] border-t-transparent border-solid border-[#FFFFFF40] flex items-center justify-center">
            <div class="w-[16px] h-[16px] rounded-full bg-[#FFF]"></div>
          </div>
        </div>
      </div>
    </motion.div>
  </AnimatePresence>
</template>

<script setup>
import { AnimatePresence, motion } from 'motion-v';
import { onMounted, onUnmounted, ref } from 'vue';
import { useDefaultData } from '@store/index';
import { storeToRefs } from 'pinia';
import { FetchNUI } from '@utils/index';

const StoreData = useDefaultData();
const { IsHotwireOpen, Locales } = storeToRefs(StoreData);

const showingCables = ref({
  blue_to_blue: false,
  green_to_green: false,
  white_to_white: false,
});

const originalPositions = ref({
  blue_draggable_1: { x: 3.5, y: 350 },
  blue_draggable_2: { x: 286, y: 20 },
  green_draggable_1: { x: 620, y: 350 },
  green_draggable_2: { x: 469, y: 20 },
  white_draggable_1: { x: 449, y: 418 },
  white_draggable_2: { x: 594, y: 20 },
});

let draggedElement = null;
let dragOffset = { x: 0, y: 0 };
let successfulConnection = false;

const handleMouseDown = (e) => {
  if (e.target.id && e.target.id.includes('draggable')) {
    draggedElement = e.target;
    draggedElement.style.position = 'absolute'
    draggedElement.style.zIndex = '1000'
    successfulConnection = false;

    const rect = draggedElement.getBoundingClientRect();
    const container = e.target.closest('[class*="w-[662px]"]');
    if (!container) return;

    const containerRect = container.getBoundingClientRect();

    dragOffset.x = e.clientX - rect.left;
    dragOffset.y = e.clientY - rect.top;

    document.addEventListener('mousemove', handleMouseMove);
    document.addEventListener('mouseup', handleMouseUp);
    e.preventDefault()
  }
};

const handleMouseMove = (e) => {
  if (draggedElement) {
    const container = draggedElement.closest('[class*="w-[662px]"]');
    if (!container) return;

    const containerRect = container.getBoundingClientRect();

    let newX = e.clientX - containerRect.left - dragOffset.x;
    let newY = e.clientY - containerRect.top - dragOffset.y;

    newX = Math.max(0, Math.min(newX, containerRect.width - draggedElement.offsetWidth));
    newY = Math.max(0, Math.min(newY, containerRect.height - draggedElement.offsetHeight));

    draggedElement.style.left = newX + 'px';
    draggedElement.style.top = newY + 'px';

    checkCollisions();
  }
}

const handleMouseUp = () => {
  if (draggedElement) {
    if (!successfulConnection) {
      const draggedId = draggedElement.id;
      const originalPos = originalPositions.value[draggedId];

      if (originalPos) {
        draggedElement.style.left = originalPos.x + 'px';
        draggedElement.style.top = originalPos.y + 'px';
      }
    }

    draggedElement.style.zIndex = '1';
    draggedElement = null;
    document.removeEventListener('mousemove', handleMouseMove);
    document.removeEventListener('mouseup', handleMouseUp);
  }
};

const checkCollisions = () => {
  if (!draggedElement) return;

  const draggedRect = draggedElement.getBoundingClientRect();
  const draggedId = draggedElement.id;

  const pairs = {
    'blue_draggable_1': 'blue_draggable_2',
    'blue_draggable_2': 'blue_draggable_1',
    'green_draggable_1': 'green_draggable_2',
    'green_draggable_2': 'green_draggable_1',
    'white_draggable_1': 'white_draggable_2',
    'white_draggable_2': 'white_draggable_1'
  };

  const targetId = pairs[draggedId];
  if (!targetId) return;

  const targetElement = document.getElementById(targetId);
  if (!targetElement) return;

  const targetRect = targetElement.getBoundingClientRect();

  const draggedCenterX = draggedRect.left + draggedRect.width / 2;
  const draggedCenterY = draggedRect.top + draggedRect.height / 2;
  const targetCenterX = targetRect.left + targetRect.width / 2;
  const targetCenterY = targetRect.top + targetRect.height / 2;

  const distance = Math.sqrt(
    Math.pow(draggedCenterX - targetCenterX, 2) +
    Math.pow(draggedCenterY - targetCenterY, 2)
  );

  if (distance < 50) {
    showingCables.value[`${draggedId.split('_')[0]}_to_${targetId.split('_')[0]}`] = true;
    successfulConnection = true;

    setTimeout(() => {
      CheckWinner()
    }, 3000);
  }
};

const CheckWinner = () => {
  if (showingCables.value.blue_to_blue && showingCables.value.green_to_green && showingCables.value.white_to_white) {
    FetchNUI('HOTWIRE_SUCCESS');
    IsHotwireOpen.value = false;
    ResetCables();
  };
};

const CloseHotwire = () => {
  IsHotwireOpen.value = false;
  FetchNUI('CLOSE_HOTWIRE_GAME');
  ResetCables();
};

const ResetCables = () => {
  showingCables.value = {
    blue_to_blue: false,
    green_to_green: false,
    white_to_white: false,
  };

  Object.keys(originalPositions.value).forEach(key => {
    const element = document.getElementById(key);
    if (element) {
      element.style.left = originalPositions.value[key].x + 'px';
      element.style.top = originalPositions.value[key].y + 'px';
    }
  });
};

onMounted(() => {
  document.addEventListener('mousedown', handleMouseDown);
})

onUnmounted(() => {
  document.removeEventListener('mousedown', handleMouseDown);
  document.removeEventListener('mousemove', handleMouseMove);
  document.removeEventListener('mouseup', handleMouseUp);
})
</script>
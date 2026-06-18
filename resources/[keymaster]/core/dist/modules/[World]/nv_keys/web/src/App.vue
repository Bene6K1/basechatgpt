<template>
  <div class="w-screen h-screen items-center justify-center overflow-hidden flex">
    <ContextMenu />
    <VehicleKeys />
    <Hotwire />
  </div>
</template>

<script setup>
  import messageEvents from '@utils/message';
  import keydownEvents from '@utils/keydown';
  import { onMounted } from 'vue';
  import { useDefaultData } from '@store/index';
  import { storeToRefs } from 'pinia';

  const StoreData = useDefaultData();
  const {} = storeToRefs(StoreData);

  import VehicleKeys from './components/VehicleKey/index.vue';
  import ContextMenu from './components/Contextmenu/index.vue';
  import Hotwire from './components/Hotwire/index.vue';

  onMounted(() => {
    messageEvents();
    keydownEvents();
  });
</script>
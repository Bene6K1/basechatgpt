<script setup lang="ts">
import { ref } from "vue";
import { useScriptStore } from "@/stores/script";
import { storeToRefs } from "pinia";
import useNui from "./composables/useNui";
import NotificationContainer from "./components/NotificationContainer.vue";

const { config } = storeToRefs(useScriptStore());

const bottomLeftContainer = ref<InstanceType<typeof NotificationContainer>>();

interface NotifyOptions {
  position?: 'tl' | 'tc' | 'tr' | 'lc' | 'rc' | 'bl' | 'bc' | 'br';
}

// Convertir les types NEVA vers les types RxNotify
const convertNevaType = (type: string | null): "info" | "warn" | "success" | "error" => {
  if (!type) return 'info';
  if (type === 'warn' || type === 'warning') return 'warn';
  if (type === 'error') return 'error';
  if (type === 'success') return 'success';
  return 'info';
};

// Gérer SendNotif:Classic (notification simple)
useNui("SendNotif:Classic", (data: any) => {
  if (!bottomLeftContainer.value) return;

  // Extraire le type depuis l'image si possible
  let notifType: "info" | "warn" | "success" | "error" = 'info';
  if (data.image) {
    if (data.image.includes('success')) notifType = 'success';
    else if (data.image.includes('error')) notifType = 'error';
    else if (data.image.includes('warning') || data.image.includes('warn')) notifType = 'warn';
    else notifType = 'info';
  }

  // Convertir le temps (en secondes) en millisecondes
  const duration = data.time ? data.time * 1000 : 8500;

  // Conserver le HTML avec les codes couleur
  const htmlContent = data.content || '';

  bottomLeftContainer.value.addNotification({
    title: 'NOTIFICATIONS',
    text: htmlContent,
    type: notifType,
    duration: duration,
    image: data.image || null,
    isHtml: true,
    options: {
      position: 'bl'
    }
  });
});

// Gérer SendNotif:Big (notification avancée)
useNui("SendNotif:Big", (data: any) => {
  if (!bottomLeftContainer.value) return;

  let notifType: "info" | "warn" | "success" | "error" = 'info';
  if (data.icontop) {
    if (data.icontop.includes('success')) notifType = 'success';
    else if (data.icontop.includes('error')) notifType = 'error';
    else if (data.icontop.includes('warning') || data.icontop.includes('warn')) notifType = 'warn';
    else notifType = 'info';
  }

  const duration = data.time ? data.time * 1000 : 8500;

  // Construire le texte avec les différentes parties
  let title = data.texttop || 'NOTIFICATIONS';
  let text = '';
  
  if (data.textmid) {
    text += data.textmid;
  }
  if (data.textbottom) {
    const htmlText = data.textbottom || '';
    if (text) text += ' - ' + htmlText;
    else text = htmlText;
  }

  bottomLeftContainer.value.addNotification({
    title: title,
    text: text || title,
    type: notifType,
    duration: duration,
    image: data.icontop || null,
    isHtml: true,
    options: {
      position: 'bl'
    }
  });
});

// Gérer Notifications:Hide et Notifications:Show
let notificationsVisible = true;

useNui("Notifications:Hide", () => {
  notificationsVisible = false;
  if (bottomLeftContainer.value) {
    // Cacher toutes les notifications
    document.querySelectorAll('.notification-container').forEach(el => {
      (el as HTMLElement).style.display = 'none';
    });
  }
});

useNui("Notifications:Show", () => {
  notificationsVisible = true;
  if (bottomLeftContainer.value) {
    // Afficher toutes les notifications
    document.querySelectorAll('.notification-container').forEach(el => {
      (el as HTMLElement).style.display = 'flex';
    });
  }
});
</script>

<template>
  <div class="dark" v-if="notificationsVisible">
    <NotificationContainer ref="bottomLeftContainer" position="bottom-left" />
  </div>
</template>

<style>
@import './assets/css/index.css';
</style>

<script setup lang="ts">
import { ref, computed, onUnmounted } from 'vue';
import { storeToRefs } from 'pinia';
import { useScriptStore } from '@/stores/script';

export interface NotificationOptions {
  confetti?: boolean;
  position?: 'tl' | 'tc' | 'tr' | 'lc' | 'rc' | 'bl' | 'bc' | 'br';
}

export interface Notification {
  id: string;
  title: string;
  text: string;
  type: 'info' | 'warning' | 'success' | 'error';
  duration?: number;
  timestamp: number;
  options?: NotificationOptions;
  image?: string;
  isHtml?: boolean;
  count?: number;
}

const props = defineProps<{
  position: 'top-right' | 'top-left' | 'top-center' | 'bottom-right' | 'bottom-left' | 'bottom-center' | 'left-center' | 'right-center';
}>();

const { config } = storeToRefs(useScriptStore());
const notifications = ref<Notification[]>([]);
const timers = new Map<string, NodeJS.Timeout>();
const progressWidths = ref<Map<string, number>>(new Map());

const positionClasses = computed(() => {
  const positions = {
    'top-right': 'top-4 right-4',
    'top-left': 'top-4 left-4',
    'top-center': 'top-4 left-1/2 transform -translate-x-1/2',
    'bottom-right': 'bottom-4 right-4',
    'bottom-left': 'bottom-[220px] left-[28px]',
    'bottom-center': 'bottom-4 left-1/2 transform -translate-x-1/2',
    'left-center': 'top-1/2 left-4 transform -translate-y-1/2',
    'right-center': 'top-1/2 right-4 transform -translate-y-1/2'
  };
  return positions[props.position] || positions['bottom-left'];
});

const getBadgeText = (type: string) => {
  const badges = {
    success: 'SUCCESS',
    error: 'ERROR',
    warning: 'WARNING',
    info: 'INFO'
  };
  return badges[type] || 'INFO';
};

const getDefaultImage = (type: string) => {
  const resourceName = 'notif'; // Nom de la ressource
  return `nui://${resourceName}/images/logo.png`;
};

const getNotificationStyles = computed(() => (type: string) => {
  return {};
});

const getAnimationClass = () => {
  if (props.position.includes('left')) return 'animate-slide-left';
  if (props.position.includes('right')) return 'animate-slide-right';
  if (props.position.includes('top')) return 'animate-slide-top';
  if (props.position.includes('bottom')) return 'animate-slide-bottom';
  return 'animate-slide-left';
};

const addNotification = (notification: Omit<Notification, 'id' | 'timestamp'>) => {
  // Vérifier si une notification identique existe déjà
  const existingIndex = notifications.value.findIndex(n => 
    n.text === notification.text && 
    n.title === notification.title && 
    n.type === notification.type
  );

  if (existingIndex !== -1) {
    // Notification identique trouvée, incrémenter le compteur
    const existing = notifications.value[existingIndex];
    existing.count = (existing.count || 1) + 1;
    existing.timestamp = Date.now(); // Mettre à jour le timestamp
    
    // Réinitialiser la barre de progression
    progressWidths.value.set(existing.id, 100);
    
    // Réinitialiser le timer
    const timer = timers.get(existing.id);
    if (timer) {
      clearTimeout(timer);
      timers.delete(existing.id);
    }
    
    if (existing.duration && existing.duration > 0) {
      const startTime = Date.now();
      const updateProgress = () => {
        const elapsed = Date.now() - startTime;
        const remaining = existing.duration! - elapsed;
        const width = Math.max(0, (remaining / existing.duration!) * 100);
        
        if (width > 0) {
          progressWidths.value.set(existing.id, width);
          requestAnimationFrame(updateProgress);
        } else {
          removeNotification(existing.id);
        }
      };
      requestAnimationFrame(updateProgress);
    }
    return;
  }

  // Nouvelle notification
  const id = Math.random().toString(36).substring(7);
  const newNotification: Notification = {
    ...notification,
    id,
    timestamp: Date.now(),
    duration: notification.duration || 8500,
    count: 1
  };

  notifications.value.push(newNotification);
  progressWidths.value.set(id, 100);

  // Calculate height based on text content and adjust font size if needed
  setTimeout(() => {
    const element = document.getElementById(`notification-${id}`);
    if (element) {
      const messageEl = element.querySelector('.text-message') as HTMLElement;
      if (messageEl) {
        const originalFontSize = 13;
        const lineHeight = parseFloat(getComputedStyle(messageEl).lineHeight) || 19.5; // 13px * 1.5
        let scrollHeight = messageEl.scrollHeight;
        
        // Si le texte dépasse légèrement (entre 1 et 2 lignes), réduire la taille
        if (scrollHeight > lineHeight && scrollHeight < lineHeight * 2.2) {
          let fontSize = originalFontSize;
          let attempts = 0;
          const maxAttempts = 20;
          const minFontSize = 10;
          
          // Réduire progressivement la taille jusqu'à ce que ça rentre
          while (scrollHeight > lineHeight && attempts < maxAttempts && fontSize > minFontSize) {
            fontSize -= 0.1;
            messageEl.style.fontSize = `${fontSize}px`;
            // Forcer le recalcul
            void messageEl.offsetHeight;
            scrollHeight = messageEl.scrollHeight;
            
            if (scrollHeight <= lineHeight) {
              break;
            }
            attempts++;
          }
        }
        
        const messageHeight = messageEl.scrollHeight;
        const minCardHeight = Math.max(70, 40 + messageHeight + 10);
        element.style.minHeight = `${minCardHeight}px`;
      }
    }
  }, 10);

  if (newNotification.duration && newNotification.duration > 0) {
    const startTime = Date.now();
    const updateProgress = () => {
      const elapsed = Date.now() - startTime;
      const remaining = newNotification.duration! - elapsed;
      const width = Math.max(0, (remaining / newNotification.duration!) * 100);
      
      if (width > 0) {
        progressWidths.value.set(id, width);
        requestAnimationFrame(updateProgress);
      } else {
        removeNotification(id);
      }
    };
    requestAnimationFrame(updateProgress);
  }
};

const getOutAnimationClass = () => {
  if (props.position.includes('left')) return 'animate-out-left';
  if (props.position.includes('right')) return 'animate-out-right';
  if (props.position.includes('top')) return 'animate-out-top';
  if (props.position.includes('bottom')) return 'animate-out-bottom';
  return 'animate-out-left';
};

const removeNotification = (id: string) => {
  const timer = timers.get(id);
  if (timer) {
    clearTimeout(timer);
    timers.delete(id);
  }

  const index = notifications.value.findIndex(n => n.id === id);
  if (index > -1) {
    const element = document.getElementById(`notification-${id}`);
    const outClass = getOutAnimationClass();
    if (element && !element.classList.contains(outClass)) {
      element.classList.remove('animate-slide-left', 'animate-slide-right', 'animate-slide-top', 'animate-slide-bottom');
      element.classList.add(outClass);
      setTimeout(() => {
        const currentIndex = notifications.value.findIndex(n => n.id === id);
        if (currentIndex > -1) {
          notifications.value.splice(currentIndex, 1);
          progressWidths.value.delete(id);
        }
      }, 300);
    } else if (!element) {
      notifications.value.splice(index, 1);
      progressWidths.value.delete(id);
    }
  }
};

defineExpose({
  addNotification
});

onUnmounted(() => {
  timers.forEach(timer => clearTimeout(timer));
  timers.clear();
  progressWidths.value.clear();
});
</script>

<template>
  <div :class="['notification-container', positionClasses]">
    <TransitionGroup name="notification">
      <div
        v-for="notification in notifications"
        :key="notification.id"
        :id="`notification-${notification.id}`"
        :class="['notification-card', getAnimationClass()]"
        role="alert"
      >
        <!-- Background container -->
        <div class="notification-background">
          <div class="bar-bg"></div>
          <div 
            class="bar-progress" 
            :style="{ width: `${progressWidths.get(notification.id) || 100}%` }"
          ></div>
        </div>

        <!-- Blur circle behind logo -->
        <div class="blur-circle"></div>
        
        <!-- Logo -->
        <img 
          v-if="notification.image" 
          class="logo-img" 
          :src="notification.image" 
          alt="Logo" 
        />
        <img 
          v-else-if="getDefaultImage(notification.type)"
          class="logo-img" 
          :src="getDefaultImage(notification.type)" 
          alt="Logo" 
        />
        
        <!-- Title -->
        <div class="text-title">{{ notification.title || 'NOTIFICATIONS' }}</div>
        
        <!-- Message -->
        <div 
          class="text-message" 
          v-if="notification.isHtml"
          v-html="notification.text"
        ></div>
        <div 
          class="text-message" 
          v-else
        >{{ notification.text }}</div>
        
        <!-- Badge -->
        <div class="badge-text">{{ getBadgeText(notification.type) }}</div>
        
        <!-- Counter -->
        <div v-if="notification.count && notification.count > 1" class="notification-counter">
          {{ notification.count }}
        </div>
      </div>
    </TransitionGroup>
  </div>
</template>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;500;700&display=swap');

.notification-container {
  @apply fixed z-50 flex flex-col gap-2;
  width: 273px;
}

.notification-card {
  width: 273px;
  min-height: 70px;
  position: relative;
  padding-bottom: 2px; /* Space for progress bar */
}

.notification-background {
  width: 100%;
  min-height: 100%;
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(180deg, rgba(0, 0, 0, 0.85) 0%, rgba(0, 0, 0, 0.6) 100%);
  border-radius: 6px;
  overflow: hidden;
  z-index: 0;
}

.bar-bg {
  width: 100%;
  height: 2px;
  left: 0;
  bottom: 0;
  position: absolute;
  background: rgba(255, 255, 255, 0.1);
  z-index: 1;
}

.bar-progress {
  width: 80%;
  height: 2px;
  left: 0;
  bottom: 0;
  position: absolute;
  background: rgba(255, 255, 255, 0.8);
  box-shadow: 0 0 4px rgba(255, 255, 255, 0.5);
  z-index: 1;
  transition: width 0.05s linear;
}

.blur-circle {
  width: 34px;
  height: 34px;
  left: -12px;
  top: 50%;
  transform: translateY(-50%);
  position: absolute;
  background: rgba(255, 255, 255, 0.1);
  box-shadow: 0 0 20px 5px rgba(255, 255, 255, 0.15);
  border-radius: 50%;
  filter: blur(8px);
  z-index: 2;
}

.logo-img {
  width: 34px;
  height: 34px;
  left: 15px;
  top: 50%;
  transform: translateY(-50%);
  position: absolute;
  object-fit: contain;
  z-index: 3;
  filter: drop-shadow(0 0 2px rgba(0, 0, 0, 0.5));
}

.text-title {
  width: auto;
  height: auto;
  left: 65px;
  top: 10px;
  position: absolute;
  text-align: left;
  display: block;
  color: white;
  font-size: 13px;
  font-family: 'Montserrat', sans-serif;
  font-weight: 700;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  z-index: 2;
}

.text-message {
  width: auto;
  max-width: 165px;
  left: 65px;
  top: 33px;
  right: 60px;
  position: absolute;
  text-align: left;
  display: block;
  color: rgba(255, 255, 255, 0.7);
  font-size: 13px;
  font-family: 'Montserrat', sans-serif;
  font-weight: 300;
  letter-spacing: 0.05em;
  z-index: 2;
  word-wrap: break-word;
  word-break: break-word;
  line-height: 1.5;
  white-space: normal;
}

.text-message :deep(span[style*="color"]) {
  /* Les spans avec des couleurs inline doivent utiliser leur propre couleur */
  opacity: 1 !important;
}

.badge-text {
  width: auto;
  height: auto;
  right: 15px;
  left: auto;
  top: 13px;
  position: absolute;
  text-align: right;
  color: rgba(255, 255, 255, 0.5);
  font-size: 9px;
  font-family: 'Montserrat', sans-serif;
  font-weight: 500;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  z-index: 2;
}

.notification-counter {
  position: absolute;
  top: 5px;
  right: 5px;
  color: white;
  font-size: 11px;
  font-weight: 700;
  font-family: 'Montserrat', sans-serif;
  z-index: 4;
  text-align: center;
}

@keyframes slideInLeft {
  from { 
    opacity: 0; 
    transform: translateX(-20px); 
  }
  to { 
    opacity: 1; 
    transform: translateX(0); 
  }
}
@keyframes slideOutLeft {
  from { 
    opacity: 1; 
    transform: translateX(0); 
  }
  to { 
    opacity: 0; 
    transform: translateX(-20px); 
  }
}

@keyframes slideInRight {
  from { 
    opacity: 0; 
    transform: translateX(20px); 
  }
  to { 
    opacity: 1; 
    transform: translateX(0); 
  }
}
@keyframes slideOutRight {
  from { 
    opacity: 1; 
    transform: translateX(0); 
  }
  to { 
    opacity: 0; 
    transform: translateX(20px); 
  }
}

@keyframes slideInTop {
  from { 
    opacity: 0; 
    transform: translateY(-20px); 
  }
  to { 
    opacity: 1; 
    transform: translateY(0); 
  }
}
@keyframes slideOutTop {
  from { 
    opacity: 1; 
    transform: translateY(0); 
  }
  to { 
    opacity: 0; 
    transform: translateY(-20px); 
  }
}

@keyframes slideInBottom {
  from { 
    opacity: 0; 
    transform: translateY(20px); 
  }
  to { 
    opacity: 1; 
    transform: translateY(0); 
  }
}
@keyframes slideOutBottom {
  from { 
    opacity: 1; 
    transform: translateY(0); 
  }
  to { 
    opacity: 0; 
    transform: translateY(20px); 
  }
}

.animate-slide-left {
  animation: slideInLeft 0.3s ease-out;
}
.animate-slide-right {
  animation: slideInRight 0.3s ease-out;
}
.animate-slide-top {
  animation: slideInTop 0.3s ease-out;
}
.animate-slide-bottom {
  animation: slideInBottom 0.3s ease-out;
}

.animate-out-left {
  animation: slideOutLeft 0.25s ease-in;
}
.animate-out-right {
  animation: slideOutRight 0.25s ease-in;
}
.animate-out-top {
  animation: slideOutTop 0.25s ease-in;
}
.animate-out-bottom {
  animation: slideOutBottom 0.25s ease-in;
}

.notification-enter-active,
.notification-leave-active {
  transition: all 0.3s ease-out;
}

.notification-enter-from {
  opacity: 0;
  transform: translateX(-20px);
}

.notification-leave-to {
  opacity: 0;
  transform: translateX(-20px);
}

.notification-move {
  transition: transform 0.3s ease-out;
}
</style>

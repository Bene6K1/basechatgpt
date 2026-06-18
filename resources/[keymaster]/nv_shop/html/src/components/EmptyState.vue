<template>
  <div class="empty-state">
    <div class="empty-icon">
      <i :class="icon"></i>
    </div>
    <div class="empty-title">{{ title }}</div>
    <div v-if="message" class="empty-message">{{ message }}</div>
    <button v-if="buttonText" class="empty-button" @click="handleClick">
      {{ buttonText }}
    </button>
  </div>
</template>

<script setup lang="ts">
interface Props {
  icon: string
  title: string
  message?: string
  buttonText?: string
}

defineProps<Props>()

const emit = defineEmits<{
  buttonClick: []
}>()

const handleClick = () => {
  emit('buttonClick')
}
</script>

<style scoped>
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 40px;
  text-align: center;
  min-height: 300px;
}

.empty-icon {
  width: 80px;
  height: 80px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 24px;
  font-size: 64px;
  color: rgba(255, 255, 255, 0.15);
  animation: fadeInScale 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

.empty-title {
  font-family: 'Bebas Neue', sans-serif;
  font-size: 24px;
  color: #ffffff;
  letter-spacing: 1px;
  margin-bottom: 12px;
  animation: fadeInUp 0.5s cubic-bezier(0.4, 0, 0.2, 1) 0.1s both;
}

.empty-message {
  font-family: 'Geist', sans-serif;
  font-size: 14px;
  color: #c6c9ca;
  line-height: 1.6;
  max-width: 400px;
  margin-bottom: 24px;
  animation: fadeInUp 0.5s cubic-bezier(0.4, 0, 0.2, 1) 0.2s both;
}

.empty-button {
  position: relative;
  padding: 12px 32px;
  background: radial-gradient(
    circle at 50% 0%,
    rgba(94, 94, 94, 0.4) 0%,
    rgba(44, 44, 44, 0.4) 100%
  );
  border: 1px solid #5e5e5e;
  border-radius: 6px;
  font-family: 'Bebas Neue', sans-serif;
  font-size: 16px;
  letter-spacing: 1px;
  color: #ffffff;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  overflow: hidden;
  animation: fadeInUp 0.5s cubic-bezier(0.4, 0, 0.2, 1) 0.3s both;
}

.empty-button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(
    90deg,
    transparent,
    rgba(255, 255, 255, 0.1),
    transparent
  );
  transition: left 0.5s;
}

.empty-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
  border-color: #7e7e7e;
}

.empty-button:hover::before {
  left: 100%;
}

.empty-button:active {
  transform: translateY(0);
}

@keyframes fadeInScale {
  from {
    opacity: 0;
    transform: scale(0.8);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Responsive */
@media (max-width: 900px) {
  .empty-state {
    padding: 40px 20px;
    min-height: 250px;
  }

  .empty-icon {
    width: 64px;
    height: 64px;
    font-size: 48px;
    margin-bottom: 20px;
  }

  .empty-title {
    font-size: 20px;
  }

  .empty-message {
    font-size: 13px;
  }
}
</style>

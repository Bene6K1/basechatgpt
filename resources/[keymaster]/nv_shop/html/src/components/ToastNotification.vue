<template>
  <TransitionGroup name="toast" tag="div" class="toast-container">
    <div
      v-for="toast in toasts"
      :key="toast.id"
      :class="['toast', `toast-${toast.type}`]"
    >
      <div class="toast-icon">
        <i :class="getIcon(toast.type)"></i>
      </div>
      <div class="toast-content">
        <div class="toast-title">{{ toast.title }}</div>
        <div v-if="toast.message" class="toast-message">{{ toast.message }}</div>
      </div>
      <button class="toast-close" @click="removeToast(toast.id)">
        <i class="fa-solid fa-xmark"></i>
      </button>
    </div>
  </TransitionGroup>
</template>

<script setup lang="ts">
import { ref } from 'vue'

interface Toast {
  id: number
  type: 'success' | 'error' | 'info' | 'warning'
  title: string
  message?: string
  duration?: number
}

const toasts = ref<Toast[]>([])
let toastId = 0

const getIcon = (type: string) => {
  const icons = {
    success: 'fa-solid fa-circle-check',
    error: 'fa-solid fa-circle-xmark',
    info: 'fa-solid fa-circle-info',
    warning: 'fa-solid fa-triangle-exclamation'
  }
  return icons[type as keyof typeof icons] || icons.info
}

const addToast = (toast: Omit<Toast, 'id'>) => {
  const id = toastId++
  const duration = toast.duration || 3000

  toasts.value.push({ ...toast, id })

  setTimeout(() => {
    removeToast(id)
  }, duration)
}

const removeToast = (id: number) => {
  const index = toasts.value.findIndex(t => t.id === id)
  if (index > -1) {
    toasts.value.splice(index, 1)
  }
}

defineExpose({
  addToast
})
</script>

<style scoped>
.toast-container {
  position: absolute;
  top: 20px;
  right: 20px;
  z-index: 10000;
  display: flex;
  flex-direction: column;
  gap: 12px;
  pointer-events: none;
}

.toast {
  display: flex;
  align-items: center;
  gap: 12px;
  min-width: 320px;
  max-width: 420px;
  padding: 16px;
  background: rgba(30, 30, 30, 0.95);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
  pointer-events: auto;
  animation: slideIn 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.toast-icon {
  flex-shrink: 0;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
}

.toast-success .toast-icon {
  color: #4caf50;
}

.toast-error .toast-icon {
  color: #f44336;
}

.toast-info .toast-icon {
  color: #2196f3;
}

.toast-warning .toast-icon {
  color: #ff9800;
}

.toast-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.toast-title {
  font-family: 'Bebas Neue', sans-serif;
  font-size: 16px;
  color: #ffffff;
  letter-spacing: 0.5px;
}

.toast-message {
  font-family: 'Geist', sans-serif;
  font-size: 13px;
  color: #c6c9ca;
  line-height: 1.4;
}

.toast-close {
  flex-shrink: 0;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: none;
  border: none;
  color: rgba(255, 255, 255, 0.5);
  cursor: pointer;
  transition: color 0.2s;
  font-size: 16px;
}

.toast-close:hover {
  color: #ffffff;
}

/* Transition animations */
.toast-enter-active {
  animation: slideIn 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.toast-leave-active {
  animation: slideOut 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

@keyframes slideIn {
  from {
    transform: translateX(400px);
    opacity: 0;
  }
  to {
    transform: translateX(0);
    opacity: 1;
  }
}

@keyframes slideOut {
  from {
    transform: translateX(0) scale(1);
    opacity: 1;
  }
  to {
    transform: translateX(400px) scale(0.9);
    opacity: 0;
  }
}

/* Responsive */
@media (max-width: 900px) {
  .toast-container {
    top: 10px;
    right: 10px;
    left: 10px;
  }

  .toast {
    min-width: auto;
    max-width: 100%;
  }
}
</style>

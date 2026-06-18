<template>
  <div class="skeleton-card">
    <div class="skeleton-image"></div>
    <div class="skeleton-content">
      <div class="skeleton-title"></div>
      <div class="skeleton-description"></div>
      <div class="skeleton-footer">
        <div class="skeleton-price"></div>
        <div class="skeleton-button"></div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// Composant simple sans logique
</script>

<style scoped>
.skeleton-card {
  background: radial-gradient(
    circle at 50% 0%,
    rgba(44, 44, 44, 0.5) 0%,
    rgba(22, 22, 22, 0.5) 100%
  );
  border: 1px solid #2c2c2c;
  border-radius: 8px;
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 16px;
  overflow: hidden;
  position: relative;
}

.skeleton-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(
    90deg,
    transparent,
    rgba(255, 255, 255, 0.05),
    transparent
  );
  animation: shimmer 2s infinite;
}

@keyframes shimmer {
  0% {
    left: -100%;
  }
  100% {
    left: 100%;
  }
}

.skeleton-image {
  width: 100%;
  height: 180px;
  background: rgba(94, 94, 94, 0.2);
  border-radius: 6px;
  animation: pulse 1.5s ease-in-out infinite;
}

.skeleton-content {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.skeleton-title {
  width: 70%;
  height: 20px;
  background: rgba(94, 94, 94, 0.2);
  border-radius: 4px;
  animation: pulse 1.5s ease-in-out infinite;
  animation-delay: 0.1s;
}

.skeleton-description {
  width: 90%;
  height: 14px;
  background: rgba(94, 94, 94, 0.15);
  border-radius: 4px;
  animation: pulse 1.5s ease-in-out infinite;
  animation-delay: 0.2s;
}

.skeleton-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 8px;
}

.skeleton-price {
  width: 60px;
  height: 24px;
  background: rgba(94, 94, 94, 0.2);
  border-radius: 4px;
  animation: pulse 1.5s ease-in-out infinite;
  animation-delay: 0.3s;
}

.skeleton-button {
  width: 140px;
  height: 36px;
  background: rgba(94, 94, 94, 0.2);
  border-radius: 6px;
  animation: pulse 1.5s ease-in-out infinite;
  animation-delay: 0.4s;
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}

/* Responsive */
@media (max-width: 1200px) {
  .skeleton-image {
    height: 160px;
  }
}

@media (max-width: 900px) {
  .skeleton-image {
    height: 140px;
  }
}
</style>

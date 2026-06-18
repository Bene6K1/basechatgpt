import { ref } from "vue";
import { defineStore } from "pinia";

export const useScriptStore = defineStore("script", () => {
  const config = ref({
    Position: 'bl', // bottom-left par défaut
    DefaultDisplayTime: 8500,
    Colors: {
      background: '#1A1B26',
      textPrimary: '#F7FAFC',
      textSecondary: '#A0AEC0',
      success: '#10B981',
      warning: '#F59E0B',
      error: '#EF4444',
      info: '#3B82F6'
    }
  });

  return {
    config,
  };
});

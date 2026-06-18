import { useDefaultData } from "@store/index";
import { storeToRefs } from "pinia";
import { FetchNUI } from "@utils/index";

export default function () {
  const StoreData = useDefaultData();
  const { IsKeysMenuOpen, IsContextMenu } = storeToRefs(StoreData);

  window.addEventListener("keydown", async ({ key }) => {
    if (key.toLowerCase() === 'Escape') {
      if (IsKeysMenuOpen.value) {
        IsKeysMenuOpen.value = false;
      }
      if (IsContextMenu.value) {
        IsContextMenu.value = false;
        FetchNUI('CLOSE_CONTEXT_MENU');
      }
    }
  });
};
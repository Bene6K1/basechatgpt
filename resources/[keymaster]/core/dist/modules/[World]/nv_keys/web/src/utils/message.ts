import { useDefaultData } from "@store/index";
import { storeToRefs } from "pinia";
import { FetchNUI } from "@utils/index";

export default function () {
  const StoreData = useDefaultData();
  const { IsContextMenu, ConextMenu, IsKeysMenuOpen, IsHotwireOpen, Locales, KeysMenu } = storeToRefs(StoreData);

  window.addEventListener("message", async ({ data }) => {
    switch (data.action) {
      case "OPEN_CONTEXT_MENU":
        IsContextMenu.value = true;
        break;
      case "CLOSE_CONTEXT_MENU":
        IsContextMenu.value = false;
        break;
      case "SET_CONTEXT_MENU":
        ConextMenu.value = data.contextMenu;
        break;
      case "RESET_CONTEXT_MENU":
        ConextMenu.value = {
          id: 'reset',
          header: 'Locksmith Menu',
          items: [],
        };
        break;
      case "SET_LOCALES":
        Locales.value = data.locales;
        FetchNUI('SET_LOCALES', {});

        for (const item of KeysMenu.value) {
          item.description = data.locales.keys_menu[item.id];
        };
        break;
      case "OPEN_KEYS_MENU":
        IsKeysMenuOpen.value = true;
        break;
      case "CLOSE_KEYS_MENU":
        IsKeysMenuOpen.value = false;
        break;
      case "PLAY_SOUND":
        const soundUrl = `https://cfx-nui-nv_keys/web/build/sounds/${data.soundfile}.ogg`;
        const sound = new Audio(soundUrl);
        sound.volume = 0.2;
        sound.play();

        sound.onended = () => {
          sound.remove();
        };
        break;
      case "OPEN_HOTWIRE_GAME":
        IsHotwireOpen.value = true;
        break;
      case "CLOSE_HOTWIRE_GAME":
        IsHotwireOpen.value = false;
        break;
      default:
        console.warn(`Unknown action received: ${data.action}`);
        break;
    }
  });
};
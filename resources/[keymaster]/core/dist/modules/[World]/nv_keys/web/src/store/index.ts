import { defineStore } from 'pinia';
import type { ContextMenu, KeysMenu } from '../types/index';

export const useDefaultData = defineStore("DefaultData", {
  state: () => ({
    IsContextMenu: false as boolean,
    IsHotwireOpen: false as boolean,
    Locales: {} as any,
    ConextMenu: {
      id: 'locksmith',
      header: 'Locksmith Menu',
      items: [
        {
          id: 'create_new_key',
          label: 'Create New Key',
          description: 'You can only create a spare key without changing the lock mechanism.',
          icon: 'key',
        },
        {
          id: 'create_new_lock',
          label: 'Create New Lock',
          description: 'You can create a new lock by changing the lock mechanism. It will not work with old keys.',
          icon: 'lock',
        },
      ],
    } as ContextMenu,
    IsKeysMenuOpen: false as boolean,
    KeysMenu: [
      {
        id: 'toggle_doors_lock',
        key: 'l',
        description: 'Toggle Doors Lock',
      },
      {
        id: 'show_key_actions',
        key: 'h',
        description: 'Show Key Actions',
      },
    ] as KeysMenu[],
  }),
  actions: {
  }
});
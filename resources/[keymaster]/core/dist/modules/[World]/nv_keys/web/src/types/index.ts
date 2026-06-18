export interface ContextMenu {
  id: string;
  header: string;
  items: {
    id: string;
    label: string;
    description: string;
    icon: string;
  }[];
};

export interface KeysMenu {
  id: string;
  key: string;
  description: string;
};
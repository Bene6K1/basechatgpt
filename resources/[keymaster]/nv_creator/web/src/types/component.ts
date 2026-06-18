/**
 * Type décrivant un composant skinchanger
 */
export interface ComponentData {
  name: string;
  label: string;
  min: number;
  max: number;
  value: number;
  zoomOffset: number;
  camOffset: number;
  componentId?: number;
  textureof?: string;
}
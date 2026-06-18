export interface InputContainerProps {
  label: string;
  placeholder?: string;
  value: string;
  onlyNumbers?: boolean;
  type?: 'text' | 'date' | 'email' | 'password' | 'range';
  min?: number;
  max?: number;
  step?: number;
  defaultValue?: number;
  details?: boolean;
  onChange: (value: string | number) => void;
  dontShowValue?: boolean;
}

export interface RangeSliderProps {
  min?: number;
  max?: number;
  value?: number;
  defaultValue?: number;
  step?: number;
  details?: boolean;
  onChange?: (value: number) => void;
  dontShowValue?: boolean;
}
import React from 'react';
import { InputContainerProps } from '@/types';
import RangeSlider from '@/components/RangeSlider';
import "@/styles/inputContainer.scss";

const InputContainer: React.FC<InputContainerProps> = ({
  label,
  placeholder = 'Votre nom',
  value,
  onlyNumbers = false,
  type = 'text',
  min = 0,
  max = 100,
  step = 1,
  defaultValue,
  details=false,
  onChange,
  dontShowValue
}) => {
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const inputValue = e.target.value;
    if (onlyNumbers && !/^\d*$/.test(inputValue)) return;
    onChange(inputValue);
  };

  if (type === 'range') {
    const numericValue = Number(value) || defaultValue || min;
    
    return (
      <div className="input">
        <div className="input__title">{label}: {numericValue}</div>
        <RangeSlider
          min={min}
          max={max}
          step={step}
          value={numericValue}
          defaultValue={defaultValue}
          onChange={(num) => onChange(num)}
          details={details}
          dontShowValue={dontShowValue}
        />
      </div>
    );
  }

  const inputType = onlyNumbers ? 'text' : type;

  return (
    <div className="input">
      <div className="input__title">{label}</div>
      <input
        className="input__search"
        type={inputType}
        placeholder={placeholder}
        value={value}
        onChange={handleChange}
      />
    </div>
  );
};

export default InputContainer;
import React, { useState, useEffect, ChangeEvent } from 'react';
import { RangeSliderProps } from '@/types';

const RangeSlider: React.FC<RangeSliderProps> = ({
  min = 0,
  max = 100,
  value,
  defaultValue,
  step = 1,
  details = false,
  onChange,
  dontShowValue
}) => {
  const [internalValue, setInternalValue] = useState<number>(
    value ?? defaultValue ?? min
  );

  useEffect(() => {
    if (typeof value === 'number') {
      setInternalValue(value);
    }
  }, [value]);

  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    const newVal = Number(e.target.value);
    if (onChange) {
      onChange(newVal);
    }
    if (value === undefined) {
      setInternalValue(newVal);
    }
  };

  const percent = ((internalValue - min) / (max - min)) * 100;

  const trackStyle: React.CSSProperties = {
    background: `linear-gradient(to right, #6B6B6B 0%, #929292 ${percent}%, #202020 ${percent}%, #202020 100%)`,
    borderRadius: '10px'
  };

  return (
    <div className="input-slider" style={{ width: '100%' }}>
      <input
        type="range"
        className="input-slider__input"
        min={min}
        max={max}
        step={step}
        value={internalValue}
        onChange={handleChange}
        style={trackStyle}
        aria-valuemin={min}
        aria-valuemax={max}
        aria-valuenow={internalValue}
      />
      {!details ? (
        <div className="input-slider__value" aria-live="polite">
          {dontShowValue ? '' : internalValue}
        </div>
      ) : (
        <div className="input-slider__values" aria-live="polite">
          <div className="input-slider__value">{min}</div>
          <div className="input-slider__value">{internalValue}</div>
          <div className="input-slider__value">{max}</div>
        </div>
      )}
    </div>
  );
};

export default RangeSlider;

import React, { FC } from 'react';
import { NumericFormat } from 'react-number-format';
import cx from 'classnames';

import './NumericInput.scss';

interface INumericInputProps {
  onChange: any;
  id: string;
  name: string;
  value?: any;
  placeholder?: string;
  iStyle?: 'one' | 'two';
  className?: string;
}

const NumericInput: FC<INumericInputProps> = ({
  onChange,
  id,
  name,
  value,
  placeholder,
  iStyle,
  className,
}) => {
  return (
    <NumericFormat
      prefix="$"
      thousandSeparator
      allowNegative={false}
      onChange={onChange}
      id={id}
      name={name}
      value={value}
      defaultValue={15125}
      placeholder={placeholder}
      className={cx(
        'numeric-input',
        {
          [`numeric-input--style-${iStyle}`]: iStyle,
        },
        className,
      )}
    />
  );
};

export default NumericInput;

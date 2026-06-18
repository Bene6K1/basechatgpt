import React, { FC } from 'react';
import cx from 'classnames';

import './Input.scss';

interface IInputProps extends React.InputHTMLAttributes<HTMLInputElement> {
  value?: any;
  iStyle?: 'one' | 'two';
  className?: string;
}

const Input: FC<IInputProps> = ({ value, iStyle, className, ...res }) => {
  return (
    <input
      type="text"
      className={cx(
        'input',
        {
          [`input--style-${iStyle}`]: iStyle,
        },
        className,
      )}
      defaultValue={value}
      {...res}
    />
  );
};

export default Input;

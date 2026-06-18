import React, { FC } from 'react';
import cx from 'classnames';

import './Button.scss';

interface IButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  theme?: 'blue' | 'purple' | 'red';
  size?: 'default' | 'medium' | 'big';
  rounded?: boolean;
  minWidth?: boolean;
  className?: string;
  iconOnly?: boolean;
  onClick?: () => void;
  children: React.ReactNode;
}

const Button: FC<IButtonProps> = ({
  theme,
  size = 'default',
  rounded,
  minWidth,
  className,
  iconOnly,
  onClick,
  children,
  ...res
}) => {
  return (
    <button
      onClick={onClick}
      className={cx(
        'button',
        {
          [`button--${theme}`]: theme,
          [`button--${size}`]: size,
          'button--rounded': rounded,
          'button--min-width': minWidth,
          'button--icon-only': iconOnly,
        },
        className,
      )}
      {...res}
    >
      {children}
    </button>
  );
};

export default Button;

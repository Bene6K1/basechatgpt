import React, { FC } from 'react';
import cx from 'classnames';

import './Badge.scss';

interface IBadgeProps {
  children: React.ReactNode;
  className?: string;
  theme?: 'green' | 'light-green';
  size?: 'long' | 'square';
}

const Badge: FC<IBadgeProps> = ({ children, className, theme, size }) => {
  return (
    <span
      className={cx(
        'badge',
        {
          [`badge--${theme}`]: theme,
          [`badge--size-${size}`]: size,
        },
        className,
      )}
    >
      {children}
    </span>
  );
};

export default Badge;

import React, { FC } from 'react';
import cx from 'classnames';

import './Label.scss';

interface ILabelProps {
  theme: 'blue' | 'orange';
  className?: string;
  children: React.ReactNode;
}

const Label: FC<ILabelProps> = ({ theme, className, children }) => {
  return (
    <span
      className={cx(
        'label',
        {
          [`label--theme-${theme}`]: theme,
        },
        className,
      )}
    >
      {children}
    </span>
  );
};

export default Label;

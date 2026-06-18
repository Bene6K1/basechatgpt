import React, { FC } from 'react';
import cx from 'classnames';

import './HelpMessage.scss';

interface IHelpMessageProps {
  status: 'error' | 'success';
  className?: string;
  children: React.ReactNode;
}

const HelpMessage: FC<IHelpMessageProps> = ({ status, className, children }) => {
  return (
    <span
      className={cx(
        'help-message',
        {
          [`help-message--${status}`]: status,
        },
        className,
      )}
    >
      {children}
    </span>
  );
};

export default HelpMessage;

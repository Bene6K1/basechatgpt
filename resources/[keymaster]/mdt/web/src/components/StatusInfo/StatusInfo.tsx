import React, { FC } from 'react';
import { X, Lock } from '@phosphor-icons/react';
import cx from 'classnames';

import './StatusInfo.scss';

interface IStatusInfo {
  status: 'error' | 'lock';
  text: string;
}

const StatusInfo: FC<IStatusInfo> = ({ status, text }) => {
  return (
    <div
      className={cx('status-info', {
        [`status-info--${status}`]: status,
      })}
    >
      <div className="status-info__icon">
        {status === 'error' && <X />}
        {status === 'lock' && <Lock />}
      </div>

      <p className="status-info__text">{text}</p>
    </div>
  );
};

export default StatusInfo;

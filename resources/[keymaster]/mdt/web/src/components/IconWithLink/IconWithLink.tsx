import React, { FC } from 'react';
import cx from 'classnames';

import './IconWithLink.scss';

interface IconWithLinkProps {
  icon: any;
  count?: any;
  className?: string;
  onClick?: React.MouseEventHandler;
}

const IconWithLink: FC<IconWithLinkProps> = ({ icon, count, className, onClick }) => {
  return (
    <button onClick={onClick} className={cx('icon-with-link', className)}>
      <img src={icon} alt="" className="icon-with-link__img" />
      {count > 0 && <span className="icon-with-link__count">{count >= 99 ? '99+' : count}</span>}
    </button>
  );
};

export default IconWithLink;

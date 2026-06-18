import React, { FC } from 'react';
import cx from 'classnames';

import './Avatar.scss';

interface IAvatarProps {
  image: any;
  circle?: 'blue' | 'pink' | 'yellow' | any;
  className?: string;
}

const Avatar: FC<IAvatarProps> = ({ image, circle, className }) => {
  return (
    <div className={cx('avatar', className)}>
      <img src={image} alt="" className="avatar__img" />

      {circle && (
        <div
          className={cx('avatar__circle', {
            [`avatar__circle--${circle}`]: circle,
          })}
        ></div>
      )}
    </div>
  );
};

export default Avatar;

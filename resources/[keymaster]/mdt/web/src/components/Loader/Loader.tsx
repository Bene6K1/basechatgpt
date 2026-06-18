import React, { FC } from 'react';
import { RotatingLines } from 'react-loader-spinner';
import cx from 'classnames';

interface ILoaderProps {
  nonePadding?: boolean;
  hideText?: boolean;
}

const Loader: FC<ILoaderProps> = ({ nonePadding, hideText }) => {
  return (
    <div
      className={cx('d-flex flex-column justify-content-center align-items-center', {
        'p-5': !nonePadding,
      })}
    >
      <RotatingLines strokeColor="gray" strokeWidth="4" width="24" />
      {!hideText && <span className="section-text section-text--small mt-1">Chargement...</span>}
    </div>
  );
};

export default Loader;

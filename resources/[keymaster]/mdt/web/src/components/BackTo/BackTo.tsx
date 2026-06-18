import React, { FC } from 'react';
import { CaretLeft } from '@phosphor-icons/react';
import { Link } from 'react-router-dom';

import './BackTo.scss';

interface IBackToProps {
  pageName: string;
  href: string;
}

const BackTo: FC<IBackToProps> = ({ pageName, href }) => {
  return (
    <Link to={`/${href}`} className="back-to">
      <div className="back-to__icon">
        <CaretLeft />
      </div>

      <span className="back-to__text">Back to {pageName}</span>
    </Link>
  );
};

export default BackTo;

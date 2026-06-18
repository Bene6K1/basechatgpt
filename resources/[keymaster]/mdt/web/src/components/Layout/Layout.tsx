import React, { FC, useState } from 'react';
import { ToastContainer } from 'react-toastify';

import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import SearchModal from '@/components/SearchModal';
import CardCorners from '@/components/CardCorners';
import './Layout.scss';

interface ILayoutProps {
  children: React.ReactNode;
}

const Layout: FC<ILayoutProps> = ({ children }) => {
  const [showSearchModal, setShowSearchModal] = useState<boolean>(false);

  return (
    <div className="layout">
      <ToastContainer />
      <SearchModal show={showSearchModal} setShow={setShowSearchModal} />

      <div className="layout__sidebar card-with-corners">
        <CardCorners color="rgba(255, 255, 255, 0.5)" />
        <Sidebar setShowSearchModal={setShowSearchModal} />
      </div>

      <div className="layout__main">
        <div className="layout__header card-with-corners card-with-corners--no-border">
          {/* <CardCorners color="rgba(255, 255, 255, 0.5)" />R */}
          <Header />
        </div>

        <div className="layout__content theme-scrollbar">{children}</div>
      </div>
    </div>
  );
};

export default Layout;

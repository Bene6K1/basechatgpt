import React, { FC } from 'react';
import { NavLink } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';

import Badge from '@/components/Badge';
import PanicButton from '@/components/PanicButton';

import profileImage from '@/assets/images/sidebar-profile.png';
import searchIcon from '@/assets/icons/search.svg';
import appsIcon from '@/assets/icons/apps.svg';
import recordsIcon from '@/assets/icons/records.svg';
import wantedIcon from '@/assets/icons/wanted.svg';
import finesIcon from '@/assets/icons/fines.svg';
import departmentIcon from '@/assets/icons/department.svg';
import cameraIcon from '@/assets/icons/camera.svg';
import locationIcon from '@/assets/icons/location.svg';
import './Sidebar.scss';

interface ISidebarProps {
  setShowSearchModal: any;
}

const Sidebar: FC<ISidebarProps> = ({ setShowSearchModal }) => {
  const info = useSelector((state: RootState) => state.globalSlice.info);
  const { policeAvatar, policeName, policeRank, totalWantedsCount } = info;

  return (
    <aside className="sidebar">
      <div className="sidebar__header">
        <div className="d-flex align-items-center sidebar__profile-section">
          <div className="sidebar__profile">
            <img
              src={policeAvatar || profileImage}
              alt="Profile"
              className="sidebar__profile-img"
            />
          </div>

          <div className="d-flex flex-column">
            <h3 className="sidebar__title">
              <span className="text-regular text-light-gray">Bienvenue,</span>
              <br />
              {policeName}
            </h3>
            <p className="sidebar__label">Police - {policeRank}</p>
          </div>
        </div>

        <div className="theme-divider sidebar__divider"></div>
      </div>

      <div className="sidebar__main">
        <div className="sidebar__search">
          <button onClick={() => setShowSearchModal(true)} className="sidebar__search-button">
            <img src={searchIcon} alt="Icône de recherche" className="sidebar__search-button-icon-img" />
          </button>
          <input
            onClick={() => setShowSearchModal(true)}
            readOnly={true}
            type="text"
            className="sidebar__search-input"
            placeholder="Rechercher..."
          />
        </div>
        <ul className="sidebar__list">
          <NavLink
            to="/"
            className={({ isActive }) =>
              `theme-nav-item ${isActive ? 'theme-nav-item--active' : ''}`
            }
          >
            <img src={appsIcon} alt="" className="sidebar__list-icon-img" />
            <span className="theme-nav-item__text">Accueil</span>
          </NavLink>

          <NavLink
            to="/records"
            className={({ isActive }) =>
              `theme-nav-item ${isActive ? 'theme-nav-item--active' : ''}`
            }
          >
            <img src={recordsIcon} alt="" className="sidebar__list-icon-img" />
            <span className="theme-nav-item__text">Dossiers</span>
          </NavLink>

          <NavLink
            to="/wanteds"
            className={({ isActive }) =>
              `theme-nav-item ${isActive ? 'theme-nav-item--active' : ''}`
            }
          >
            <div className="d-flex justify-content-between align-items-center w-100">
              <div className="d-flex align-items-center sidebar__list__gap">
                <img src={wantedIcon} alt="" className="sidebar__list-icon-img" />
                <span className="theme-nav-item__text">Recherchés</span>
              </div>
              <Badge theme="green" className="ms-2">
                +{totalWantedsCount >= 99 ? '99' : totalWantedsCount}
              </Badge>
            </div>
          </NavLink>

          <NavLink
            to="/fines"
            className={({ isActive }) =>
              `theme-nav-item ${isActive ? 'theme-nav-item--active' : ''}`
            }
          >
            <img src={finesIcon} alt="" className="sidebar__list-icon-img" />
            <span className="theme-nav-item__text">Amendes</span>
          </NavLink>

          <NavLink
            to="/department"
            className={({ isActive }) =>
              `theme-nav-item ${isActive ? 'theme-nav-item--active' : ''}`
            }
          >
            <img src={departmentIcon} alt="" className="sidebar__list-icon-img" />
            <span className="theme-nav-item__text">Département</span>
          </NavLink>

          <NavLink
            to="/cameras"
            className={({ isActive }) =>
              `theme-nav-item ${isActive ? 'theme-nav-item--active' : ''}`
            }
          >
            <img src={cameraIcon} alt="" className="sidebar__list-icon-img" />
            <span className="theme-nav-item__text">Caméras</span>
          </NavLink>

          <NavLink
            to="/live-map"
            className={({ isActive }) =>
              `theme-nav-item ${isActive ? 'theme-nav-item--active' : ''}`
            }
          >
            <img src={locationIcon} alt="" className="sidebar__list-icon-img" />
            <span className="theme-nav-item__text">Carte en direct</span>
          </NavLink>
        </ul>
      </div>

      <div className="sidebar__footer">
        <PanicButton />
      </div>
    </aside>
  );
};

export default Sidebar;

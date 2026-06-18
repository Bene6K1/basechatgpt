import React, { useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setLocales, setIsFetchedLocales } from '@/slices/globalSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Badge from '@/components/Badge';
import Messages from '@/components/Messages';
import Notifications from '@/components/Notifications';

import './Header.scss';

const Header = () => {
  const [pageTitle, setPageTitle] = useState<string>('Homepage');
  const [pageDescription, setPageDescription] = useState<string>(
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
  );
  const location = useLocation();
  const { info, locales, isFetchedLocales } = useSelector((state: RootState) => state.globalSlice);
  const { onlinePolice } = info;
  const dispatch = useDispatch();

  useEffect(() => {
    if (isFetchedLocales === 0) {
      fetchNui('getLocales', '')
        .then((res) => {
          if (res.success) {
            dispatch(setLocales(res.data));
            dispatch(setIsFetchedLocales(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setLocales({
                pageDescription: {
                  none: 'Description de la page non disponible.',
                  homepage: 'Tableau de bord principal du MDT de la police.',
                  records: 'Consultez et gérez les rapports de police.',
                  recordsDetail: 'Détails complets du rapport de police sélectionné.',
                  offenderDetail: 'Informations détaillées sur le suspect.',
                  policeDetail: "Profil et informations sur l'agent de police.",
                  wanteds: 'Liste des personnes recherchées par la police.',
                  fines: 'Gestion des amendes et contraventions.',
                  department: 'Informations sur le département de police.',
                  cameras: 'Accès aux caméras de surveillance de la ville.',
                  liveMap: 'Carte en temps réel des activités policières.',
                },
              }),
            );
            dispatch(setIsFetchedLocales(1));
          } else {
            errorNotify('Error ocurred while fetched data.');
          }
        });
    }
  }, []);

  useEffect(() => {
    const pathName = location.pathname;

    if (pathName === '/') {
      setPageTitle('Accueil');
      setPageDescription(locales.pageDescription.homepage);
    } else if (pathName === '/records') {
      setPageTitle('Rapports');
      setPageDescription(locales.pageDescription.records);
    } else if (pathName.includes('/records/')) {
      setPageTitle('Détails du rapport');
      setPageDescription(locales.pageDescription.recordsDetail);
    } else if (pathName.includes('/offenders/')) {
      setPageTitle('Détails du suspect');
      setPageDescription(locales.pageDescription.offenderDetail);
    } else if (pathName.includes('/polices/')) {
      setPageTitle('Détails du policier');
      setPageDescription(locales.pageDescription.policeDetail);
    } else if (pathName === '/wanteds') {
      setPageTitle('Recherchés');
      setPageDescription(locales.pageDescription.wanteds);
    } else if (pathName === '/fines') {
      setPageTitle('Amendes');
      setPageDescription(locales.pageDescription.fines);
    } else if (pathName === '/department') {
      setPageTitle('Département');
      setPageDescription(locales.pageDescription.department);
    } else if (pathName === '/live-map') {
      setPageTitle('Carte en direct');
      setPageDescription(locales.pageDescription.liveMap);
    } else if (pathName === '/cameras') {
      setPageTitle('Caméras');
      setPageDescription(locales.pageDescription.cameras);
    } else {
      setPageTitle('');
      setPageDescription(locales.pageDescription.none);
    }
  }, [locales, location]);

  return (
    <header className="header">
      <div className="header__left-side">
        <h3 className="header__title">
          <span className="text-regular">MDT</span> {pageTitle || pageTitle}
        </h3>
        <p className="header__text header__text--left-side">{pageDescription}</p>
      </div>

      <div className="header__right-side">
        <Messages className="ms-2" />
        <Notifications className="ms-2" />

        <div className="header__line"></div>

        <div className="d-flex align-items-center me-4">
          <span className="header__text text-nowrap">Policiers en ligne</span>
          <Badge theme="green" size="square" className="ms-2">
            {onlinePolice}
          </Badge>
        </div>

        <div className="d-flex align-items-center">
          <span className="header__text text-nowrap">Statut</span>
          <Badge theme="light-green" size="square" className="ms-2">
            <div className="badge__circle badge__circle--big badge__circle--red-opacity">
              <div className="badge__circle badge__circle--red"></div>
            </div>
          </Badge>
        </div>
      </div>
    </header>
  );
};

export default Header;

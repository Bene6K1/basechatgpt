import React, { FC, useState, useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';
import cx from 'classnames';

import Loader from '@/components/Loader';
import CardCorners from '@/components/CardCorners';

import recordsDarkBlueIcon from '@/assets/icons/records-dark-blue.svg';
import wantedDarkBlueIcon from '@/assets/icons/wanted-dark-blue.svg';
import './GeneralInformation.scss';

interface IGeneralInformationProps {
  className?: string;
}

const GeneralInformation: FC<IGeneralInformationProps> = ({ className }) => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { info } = useSelector((state: RootState) => state.globalSlice);
  const { dailyRecordsCount, dailyWantedsCount, totalRecordsCount, totalWantedsCount } = info;

  useEffect(() => {
    setIsLoading(false);
  }, [info]);

  return (
    <section className='general-information card-with-corners card-with-corners--no-border'>
      <CardCorners color="rgba(255, 255, 255, 0.5)" />
      <div className="general-information__header">
        <div className="general-information__header-left">
          <div className="general-information__header-icon">
            <i className="fa-duotone fa-solid fa-chart-line" style={{ color: "white" }}></i>
          </div>
          <div className="general-information__header-titles">
            <span className="general-information__header-title">Informations générales</span>
            <span className="general-information__header-subtitle">Statistiques du jour</span>
          </div>
        </div>
      </div>

      <div className="general-information__main">
        {isLoading ? (
          <Loader />
        ) : (
          <div className="row g-3">
            <div className="col-md-12 col-lg-6 col-xl-6">
              <div className="general-information__item">
                <div className="general-information__icon general-information__icon--purple">
                  {/* <img src={recordsDarkBlueIcon} alt="" className="general-information__icon-img" /> */}
                  <i className="fa-duotone fa-solid fa-folder general-information__icon-icon"></i>
                </div>

                <div className="d-flex flex-column">
                  <span className="general-information__title">Dossiers du jour</span>
                  <p className="general-information__text">{dailyRecordsCount}</p>
                </div>
              </div>

              <div className="d-flex flex-column mt-4">
                <div
                  className="general-information__progress-line general-information__progress-line--purple"
                  style={{ '--value': '55%' } as React.CSSProperties}
                ></div>

                <p className="general-information__title d-flex align-items-center">
                  Dossiers totaux
                  <span className="general-information__text general-information__text--medium ms-1">
                    {totalRecordsCount}
                  </span>
                </p>
              </div>
            </div>

            <div className="col-md-12 col-lg-6 col-xl-6">
              <div className="general-information__item">
                <div className="general-information__icon general-information__icon--cream">
                  {/* <img src={wantedDarkBlueIcon} alt="" className="general-information__icon-img" /> */}
                  <i className="fa-duotone fa-solid fa-user-magnifying-glass general-information__icon-icon"></i>
                </div>

                <div className="d-flex flex-column">
                  <span className="general-information__title">Recherchés du jour</span>
                  <p className="general-information__text">{dailyWantedsCount}</p>
                </div>
              </div>

              <div className="d-flex flex-column align-items-md-start align-items-lg-end mt-4">
                <div
                  className="general-information__progress-line general-information__progress-line--cream"
                  style={{ '--value': '55%' } as React.CSSProperties}
                ></div>

                <p className="general-information__title d-flex align-items-center text-right">
                  <span className="general-information__text general-information__text--medium me-1">
                    {totalWantedsCount}
                  </span>
                  Recherchés totaux
                </p>
              </div>
            </div>
          </div>
        )}
      </div>
    </section>
  );
};

export default GeneralInformation;

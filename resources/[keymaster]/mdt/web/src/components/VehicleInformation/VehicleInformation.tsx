import React, { FC, useState, useEffect } from 'react';
import { IdentificationBadge, Palette, Car, Camera } from '@phosphor-icons/react';
import { useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';

import Loader from '@/components/Loader';

import ChangeImageModal from '@/modals/ChangeImageModal';

import './VehicleInformation.scss';

interface IVehicleInformationProps {
  data: {
    image: any;
    carName: string;
    numberPlate: string;
    ownerName: string;
  };
}

const VehicleInformation: FC<IVehicleInformationProps> = ({ data }) => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { image, carName, numberPlate, ownerName } = data;
  const dispatch = useDispatch();

  useEffect(() => {
    setIsLoading(false);
  }, [data]);

  return (
    <>
      <ChangeImageModal />

      <section className="vehicle-information">
        <div className="vehicle-information__header">
          <div className="section-line section-line--blue"></div>

          <h3 className="section-title">
            Vehicle: <span className="text-extrabold">{numberPlate || 'null'}</span>
          </h3>
        </div>

        <div className="vehicle-information__main">
          {isLoading ? (
            <Loader />
          ) : (
            <>
              <div className="vehicle-information__image-container mb-4">
                <img src={image} alt="" className="vehicle-information__img" />

                <div className="vehicle-information__inner">
                  <span className="vehicle-information__title">{carName}</span>
                </div>

                <div
                  onClick={() => dispatch(setActiveModal('change-image'))}
                  className="vehicle-information__image-change"
                >
                  <Camera />
                </div>
              </div>

              <div className="row g-3">
                <div className="col-lg-6">
                  <div className="vehicle-information__item">
                    <div className="vehicle-information__item-icon">
                      <IdentificationBadge />
                    </div>

                    <div className="vehicle-information__item-inner">
                      <span className="vehicle-information__text">{ownerName}</span>
                    </div>
                  </div>
                </div>

                <div className="col-lg-6">
                  <div className="vehicle-information__item">
                    <div className="vehicle-information__item-icon">
                      <Car />
                    </div>

                    <div className="vehicle-information__item-inner">
                      <span className="vehicle-information__text">{numberPlate}</span>
                    </div>
                  </div>
                </div>
              </div>
            </>
          )}
        </div>
      </section>
    </>
  );
};

export default VehicleInformation;

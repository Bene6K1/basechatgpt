import React, { FC, useRef } from 'react';
import { Star, MapPin, CaretDown } from '@phosphor-icons/react';
import { useMediaQuery } from 'usehooks-ts';

import Map from '@/components/Map';
import Avatar from '@/components/Avatar';

import './OnDutyCard.scss';

type markerType = {
  id: number;
  position: any;
};

interface IOnDutyCardProps {
  data: {
    avatar: string;
    name: string;
    text: string;
    level: string;
    location: string;
    rankInfo: string;
    dutyTimes: string;
    appointementDate: string;
    marker: markerType;
  };
}

const OnDutyCard: FC<IOnDutyCardProps> = ({ data }) => {
  const ref = useRef<HTMLDivElement>(null);
  const { avatar, name, text, level, location, rankInfo, dutyTimes, appointementDate, marker } =
    data;
  const isLaptop = useMediaQuery('(max-width: 1500px)');

  const handleOpen = () => {
    ref.current?.classList.toggle('is-active');
  };

  return (
    <div ref={ref} className="on-duty-card">
      <div onClick={handleOpen} className="on-duty-card__header">
        <div className="row g-2 align-items-center">
          <div className="col-md-12 col-lg-5 d-flex justify-content-between align-items-center">
            <div className="d-flex align-items-center">
              <Avatar image={avatar} className="mr-15" />

              <div className="d-flex flex-column">
                <span className="on-duty-card__title">{name}</span>
                <p className="on-duty-card__text">{text}</p>
              </div>
            </div>

            <div className="on-duty-card__icon on-duty-card__icon--arrow d-flex d-lg-none">
              <CaretDown weight="bold" />
            </div>
          </div>

          <div className="col-md-12 col-lg-4 on-duty-card__positions">
            <span className="on-duty-card__label">
              <div className="on-duty-card__icon">
                <Star weight="fill" />
              </div>
              {level}
            </span>

            <span className="on-duty-card__label on-duty-card__label--red mt-2">
              <div className="on-duty-card__icon">
                <MapPin weight="fill" />
              </div>
              {location}
            </span>
          </div>

          <div className="col-lg-1 d-none d-lg-flex justify-content-end">
            <div className="on-duty-card__icon--nopadding on-duty-card__icon--arrow">
              <CaretDown weight="bold" />
            </div>
          </div>
        </div>
      </div>

      <div className="on-duty-card__main">
        <div className="on-duty-card__main-inner">
          <div className="row g-3 mb-4">
            <div className="col-md-12 col-lg-4">
              <div className="d-flex align-items-center mb-2">
                <div className="on-duty-card__icon on-duty-card__icon--normal me-2">
                  <Star weight="fill" />
                </div>

                <span className="on-duty-card__text text-semibold">Grade:</span>
              </div>

              <span className="on-duty-card__text text-medium">{rankInfo}</span>
            </div>

            <div className="col-md-12 col-lg-4">
              <div className="d-flex align-items-center mb-2">
                <div className="on-duty-card__icon on-duty-card__icon--normal me-2">
                  <Star weight="fill" />
                </div>

                <span className="on-duty-card__text text-semibold">Horaires:</span>
              </div>

              <span className="on-duty-card__text text-medium">{dutyTimes}</span>
            </div>

            <div className="col-md-12 col-lg-4">
              <div className="d-flex align-items-center mb-2">
                <div className="on-duty-card__icon on-duty-card__icon--normal me-2">
                  <Star weight="fill" />
                </div>

                <span className="on-duty-card__text text-semibold">Nomination:</span>
              </div>

              <span className="on-duty-card__text text-medium">{appointementDate}</span>
            </div>
          </div>

          <div className="on-duty-card__map">
            <Map
              markers={[marker]}
              size="small"
              hideAvatarInMarker={true}
              zoom={1}
              center={
                !isLaptop
                  ? [marker.position[0] - 800, marker.position[1]]
                  : [marker.position[0] - 410, marker.position[1]]
              }
            />
          </div>
        </div>
      </div>
    </div>
  );
};

export default OnDutyCard;

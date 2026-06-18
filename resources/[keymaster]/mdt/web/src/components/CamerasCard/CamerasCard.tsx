import React, { FC } from 'react';
import { fetchNui } from '@/utils/fetchNui';
import { successNotify, errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import CardCorners from '@/components/CardCorners';

import './CamerasCard.scss';

interface ICamerasCardProps {
  data: {
    id: any;
    image: string;
    title: string;
  };
}

const CamerasCard: FC<ICamerasCardProps> = ({ data }) => {
  const { id, image, title } = data;

  const handleOpenCamera = (id: number) => {
    fetchNui('openCamera', { id })
      .then((res) => {
        if (res.success) {
          successNotify(`${title} is successfully opened.}`);
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          successNotify(`${title} is successfully opened.`);
        } else {
          errorNotify('Error occurred while opened the camera.');
        }
      });
  };

  return (
    <div onClick={() => handleOpenCamera(id)} className="cameras-card card-with-corners">
      {/* <CardCorners color="rgba(255, 255, 255, 0.5)" /> */}
      <div className="cameras-card__header">
        <img src={image} alt="" className="cameras-card__img" />
        <div className="cameras-card__overlay">
          <i className="fa-duotone fa-solid fa-video cameras-card__icon"></i>
        </div>
      </div>

      <div className="cameras-card__body">
        <span className="cameras-card__title">{title}</span>
      </div>
    </div>
  );
};

export default CamerasCard;

import React, { FC, useContext } from 'react';
import { Eye } from '@phosphor-icons/react';
import { useNavigate } from 'react-router-dom';
import { useDispatch } from 'react-redux';
import { setEditedWantedId } from '@/slices/globalSlice';

import Avatar from '@/components/Avatar';

import timeIcon from '@/assets/icons/time.svg';
import badgeIcon from '@/assets/icons/badge.svg';
import './HotWantedCard.scss';

interface IHotWantedCard {
  data: {
    id: number;
    avatar: string;
    avatarCircle: string;
    name: string;
    text: string;
    date: string;
    assignedPolice: string;
  };
}

const HotWantedCard: FC<IHotWantedCard> = ({ data }) => {
  const { id, avatar, avatarCircle, name, text, date, assignedPolice } = data;
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const handleView = () => {
    dispatch(setEditedWantedId(id));
    navigate('/wanteds');
  };

  return (
    <div className="hot-wanted-card">
      <div className="row align-items-center h-100">
        <div className="col-5 d-flex align-items-center">
          <Avatar image={avatar} circle={avatarCircle} className="mr-15" />

          <div className="d-flex flex-column align-items-start">
            <span className="hot-wanted-card__title">{name}</span>
            <p className="hot-wanted-card__text">{text}</p>
          </div>
        </div>

        <div className="col-2">
          <div className="d-flex flex-column align-items-center">
            <div className="hot-wanted-card__icon">
              <img src={timeIcon} alt="" className="hot-wanted-card__icon-img" />
            </div>

            <span className="hot-wanted-card__text">{date}</span>
          </div>
        </div>

        <div className="col-2">
          <div className="d-flex flex-column align-items-center">
            <div className="hot-wanted-card__icon">
              <img src={badgeIcon} alt="" className="hot-wanted-card__icon-img" />
            </div>

            <span className="hot-wanted-card__text">{assignedPolice}</span>
          </div>
        </div>

        <div className="col-3 d-flex justify-content-end h-100">
          <div onClick={handleView} className="hot-wanted-card__action">
            <div className="hot-wanted-card__action-icon">
              {/* <Eye /> */}
              <i className="fa-duotone fa-solid fa-eye"></i>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default HotWantedCard;

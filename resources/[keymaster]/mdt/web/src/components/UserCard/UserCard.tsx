import React, { FC } from 'react';
import cx from 'classnames';

import Avatar from '@/components/Avatar';
import './UserCard.scss';

type ranksType = {
  id: any;
  name: string;
};

interface IUserCardProps {
  data: {
    avatar: string;
    name: string;
    text?: string;
    ranks: ranksType[];
    date: string;
    addedBy: string;
  };
  columns: {
    oneColumnTitle: string;
    twoColumnTitle: string;
    threeColumnTitle: string;
  };
  className?: string;
  deleteOnClick?: () => void;
  editOnClick?: () => void;
  viewOnClick?: () => void;
}

const UserCard: FC<IUserCardProps> = ({
  data,
  columns,
  className,
  deleteOnClick,
  editOnClick,
  viewOnClick,
}) => {
  const { avatar, name, text, ranks, date, addedBy } = data;
  const { oneColumnTitle, twoColumnTitle, threeColumnTitle } = columns;

  return (
    <div className={cx('user-card', className)}>
      <div className="row align-items-center g-3">
        <div className="col-4 d-flex align-items-center">
          <Avatar image={avatar} className="mr-15" />

          <div className="d-flex flex-column">
            <span className="user-card__title">{name}</span>
            {text && <p className="user-card__text">{text}</p>}
          </div>
        </div>

        <div className="col-2">
          <div className="d-flex flex-column">
            <span className="user-card__text user-card__text--small">{oneColumnTitle}</span>
            <p className="user-card__text user-card__text--big text-semibold">{ranks[0].name}</p>
          </div>
        </div>

        <div className="col-2">
          <div className="d-flex flex-column">
            <span className="user-card__text user-card__text--small">{twoColumnTitle}</span>
            <p className="user-card__text user-card__text--big text-semibold">{date}</p>
          </div>
        </div>

        <div className="col-2">
          <div className="d-flex flex-column">
            <span className="user-card__text user-card__text--small">{threeColumnTitle}</span>
            <p className="user-card__text user-card__text--big text-semibold">{addedBy}</p>
          </div>
        </div>

        <div className="col-2">
          <div className="user-card__action">
            {deleteOnClick && (
              <div
                onClick={deleteOnClick}
                className="user-card__action-item user-card__action-item--delete"
              >
                <div className="user-card__action-icon">
                  <i className="fa-duotone fa-solid fa-trash"></i>
                </div>
              </div>
            )}

            {editOnClick && (
              <div onClick={editOnClick} className="user-card__action-item">
                <div className="user-card__action-icon">
                  <i className="fa-duotone fa-solid fa-pen"></i>
                </div>
              </div>
            )}

            {viewOnClick && (
              <div onClick={viewOnClick} className="user-card__action-item">
                <div className="user-card__action-icon">
                  <i className="fa-duotone fa-solid fa-eye"></i>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default UserCard;

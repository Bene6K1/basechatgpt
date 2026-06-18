import React, { FC, useState, useRef } from 'react';
import cx from 'classnames';
import { Plus, UserPlus, PencilSimple, Minus } from '@phosphor-icons/react';
import { useOnClickOutside } from 'usehooks-ts';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { addNotifications } from '@/slices/globalSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import IconWithLink from '@/components/IconWithLink';
import CardCorners from '@/components/CardCorners';
import Button from '@/components/Button';
import Loader from '@/components/Loader';

import notificationIcon from '@/assets/icons/bell.svg';
import './Notifications.scss';

interface INotificationsProps {
  className?: string;
}

const Notifications: FC<INotificationsProps> = ({ className }) => {
  const ref = useRef<HTMLDivElement>(null);
  const { notifications } = useSelector((state: RootState) => state.globalSlice);
  const [maxShowData, setMaxShowData] = useState<number>(10);
  const [isLoadMoreComplete, setIsLoadMoreComplete] = useState<boolean>(false);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const dispatch = useDispatch();

  const showData = notifications.slice().reverse().splice(0, maxShowData);

  const handleShow = () => {
    ref.current?.classList.add('is-active');
  };

  const handleClose = () => {
    ref.current?.classList.remove('is-active');
  };

  const handleLoadMore = () => {
    const lastId = showData.at(-1)?.id;
    setIsLoading(true);

    fetchNui('loadNotifications', {
      lastId,
    })
      .then((res) => {
        if (res.success) {
          if (!res.noneData) {
            setTimeout(() => {
              res.data.forEach((item: any) => {
                dispatch(
                  addNotifications({
                    id: item.id,
                    title: item.title,
                    text: item.text,
                    date: item.date,
                    type: item.type,
                  }),
                );
              });
              setIsLoading(false);
              setMaxShowData(
                (current) => (current += res.data.length >= 10 ? 10 : res.data.length),
              );
            }, 500);
          } else {
            setIsLoadMoreComplete(true);
          }
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          setTimeout(() => {
            dispatch(
              addNotifications({
                id: 11,
                title: 'New Records Added',
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                date: '2 week ago',
                type: 'added',
              }),
            );
            setIsLoading(false);
            setMaxShowData((current) => (current += 10));
            setIsLoadMoreComplete(true);
          }, 500);
        } else {
          errorNotify('Error occurred while fetched data.');
        }
      });
  };

  useOnClickOutside(ref, handleClose);

  return (
    <div ref={ref} className={cx('notifications', className)}>
      <IconWithLink
        icon={notificationIcon}
        count={notifications.length}
        className="notifications__action is-active"
        onClick={handleShow}
      />

      <div className="notifications__menu">
        {/* <CardCorners color="rgba(255, 255, 255, 0.5)" /> */}
        <div className="notifications__header">
          <div className="d-flex align-items-center">
            <div className="notifications__icon me-2">
              <img src={notificationIcon} alt="" className="notifications__icon-img" />
            </div>

            <span className="notifications__title">Notifications ({notifications.length})</span>
          </div>
        </div>

        <div className="notifications__main">
          {notifications.length > 0 ? (
            <>
              {showData.map((notification) => (
                <div key={notification.id} className="notifications__item">
                  <div className="d-flex align-items-center">
                    <div
                      className={cx('notifications__icon notifications__icon--item', {
                        'notifications__icon--added': notification.type === 'added',
                        'notifications__icon--user-added': notification.type === 'user-added',
                        'notifications__icon--changed': notification.type === 'changed',
                        'notifications__icon--deleted': notification.type === 'deleted',
                      })}
                    >
                      {notification.type === 'added' && <Plus weight="bold" />}
                      {notification.type === 'user-added' && <UserPlus weight="bold" />}
                      {notification.type === 'changed' && <PencilSimple weight="bold" />}
                      {notification.type === 'deleted' && <Minus weight="bold" />}
                    </div>

                    <div className="d-flex flex-column">
                      <div className="d-flex justify-content-between align-items-center">
                        <span className="notifications__text">{notification.title}</span>
                        <p className="notifications__text notifications__text--xsmall ms-3">
                          {notification.date}
                        </p>
                      </div>
                      <p className="notifications__text notifications__text--small">
                        {notification.text}
                      </p>
                    </div>
                  </div>
                </div>
              ))}
            </>
          ) : (
            <span className="section-text">Aucune notification trouvée.</span>
          )}

          {!isLoadMoreComplete && notifications.length >= 10 && (
            <div onClick={handleLoadMore} className="notifications__load-more">
              <Button className="w-100">
                {isLoading ? <Loader nonePadding={true} hideText={true} /> : <>Charger plus</>}
              </Button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Notifications;

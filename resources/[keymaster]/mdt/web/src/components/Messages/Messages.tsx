import React, { FC, useRef } from 'react';
import cx from 'classnames';
import { Plus, CaretRight } from '@phosphor-icons/react';
import { useOnClickOutside } from 'usehooks-ts';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import IconWithLink from '@/components/IconWithLink';
import CardCorners from '@/components/CardCorners';

import AddMessageModal from '@/modals/AddMessageModal';
import messageIcon from '@/assets/icons/message.svg';
import './Messages.scss';

interface IMessagesProps {
  className?: string;
}

const Messages: FC<IMessagesProps> = ({ className }) => {
  const ref = useRef<HTMLDivElement>(null);
  const { info, messages, permissions } = useSelector((state: RootState) => state.globalSlice);
  const { policeRank } = info;
  const dispatch = useDispatch();

  const handleShow = () => {
    ref.current?.classList.add('is-active');
  };

  const handleClose = () => {
    ref.current?.classList.remove('is-active');
  };

  useOnClickOutside(ref, handleClose);

  return (
    <>
      <AddMessageModal />

      <div ref={ref} className={cx('messages', className)}>
        <IconWithLink
          icon={messageIcon}
          className="messages__action is-active"
          onClick={handleShow}
        />

        <div className="messages__menu">
          {/* <CardCorners color="rgba(255, 255, 255, 0.5)" /> */}
          <div className="messages__header">
            <div className="d-flex align-items-center">
              <div className="messages__icon me-2">
                <img src={messageIcon} alt="" className="messages__icon-img" />
              </div>

              <span className="messages__title">Messages ({messages.length})</span>
            </div>

            {permissions.addMessage.includes(policeRank) && (
              <div
                onClick={() => {
                  handleClose();
                  dispatch(setActiveModal('add-message'));
                }}
                className="messages__action-icon"
              >
                <Plus />
              </div>
            )}
          </div>

          <div className="messages__main">
            {messages.length > 0 ? (
              <>
                {messages.map((message) => (
                  <div key={message.id} className="messages__item">
                    <div className="d-flex align-items-center">
                      <div className="messages__icon messages__icon--item">
                        <img src={messageIcon} alt="" className="messages__icon-img" />
                      </div>

                      <div className="d-flex flex-column">
                        <span className="messages__text">{message.title}</span>
                        <p className="messages__text messages__text--small">{message.text}</p>
                      </div>
                    </div>

                    <div className="messages__arrow-icon">
                      <CaretRight weight="bold" />
                    </div>
                  </div>
                ))}
              </>
            ) : (
              <span className="section-text">Aucun message trouvé.</span>
            )}
          </div>
        </div>
      </div>
    </>
  );
};

export default Messages;

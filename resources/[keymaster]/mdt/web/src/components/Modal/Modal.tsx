import React, { FC, useEffect, useRef } from 'react';
import { useOnClickOutside } from 'usehooks-ts';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';

import './Modal.scss';
import CardCorners from '../CardCorners';

interface IModalProps {
  title: string;
  submitButton: string;
  type?: string;
  onSubmit: any;
  children: React.ReactNode;
}

const Modal: FC<IModalProps> = ({
  title = 'Modal Title',
  submitButton = 'Submit',
  type,
  onSubmit,
  children,
}) => {
  const ref = useRef<HTMLDivElement>(null);
  const refInner = useRef(null);
  const activeModal = useSelector((state: RootState) => state.globalSlice.activeModal);
  const dispatch = useDispatch();

  const handleClose = () => {
    ref.current?.classList.remove('is-active');

    setTimeout(() => {
      dispatch(setActiveModal(''));
    }, 350);
  };

  useEffect(() => {
    if (type === activeModal) {
      setTimeout(() => {
        ref.current?.classList.add('is-active');
      }, 1);
    }
  }, [activeModal]);

  useOnClickOutside(refInner, handleClose);

  return (
    <>
      {type === activeModal && (
        <div ref={ref} className="modal">
          <div ref={refInner} className="modal__inner card-with-corners">
            {/* <CardCorners color='rgba(255, 255, 255, 0.5)'/> */}
            <div className="modal__header">
              <h3 className="modal__title">{title}</h3>

              <div onClick={handleClose} className="modal__close">
                <i className="fa-duotone fa-solid fa-xmark"></i>
              </div>
            </div>

            <div className="modal__main">{children}</div>

            <div className="modal__footer">
              <button onClick={handleClose} className="modal__button me-2">
                Annuler
              </button>
              <button onClick={onSubmit} className="modal__button modal__button--blue">
                {submitButton}
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default Modal;

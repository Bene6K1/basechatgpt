import React, { useEffect, useRef } from 'react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setImageModalData } from '@/slices/globalSlice';
import { useOnClickOutside } from 'usehooks-ts';

import './ImageModal.scss';

const ImageModal = () => {
  const ref = useRef<HTMLDivElement>(null);
  const refInner = useRef<HTMLDivElement>(null);
  const { imageModalData } = useSelector((state: RootState) => state.globalSlice);
  const { active, image, title } = imageModalData;
  const dispatch = useDispatch();

  const handleClose = () => {
    ref.current?.classList.remove('is-active');

    setTimeout(() => {
      dispatch(
        setImageModalData({
          active: false,
          image: '',
          title: '',
        }),
      );
    }, 350);
  };

  useEffect(() => {
    setTimeout(() => {
      ref.current?.classList.add('is-active');
    }, 1);
  }, [imageModalData]);

  useOnClickOutside(refInner, handleClose);

  return (
    <>
      {active && (
        <div ref={ref} className="image-modal">
          <div ref={refInner} className="image-modal__inner">
            {image && title ? (
              <>
                {/* <img src={image} alt="" className="image-modal__img" /> */}
                <div className="image-modal__img" style={{ backgroundImage: `url(${image})` }}></div>
                <span className="image-modal__title">{title}</span>
              </>
            ) : (
              <span className="section-text">Image is not found.</span>
            )}
          </div>
        </div>
      )}
    </>
  );
};

export default ImageModal;

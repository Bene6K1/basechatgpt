import React, { FC, useState, useEffect } from 'react';
import { Camera } from '@phosphor-icons/react';
import { useParams } from 'react-router-dom';
import { fetchNui } from '@/utils/fetchNui';
import { useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { changeImageFromVehicle } from '@/slices/searchSlice';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Modal from '@/components/Modal';
import Input from '@/components/Input';

const ChangeImageModal = () => {
  const [formData, setFormData] = useState({ image: '' });
  const [imageError, setImageError] = useState('');
  const [isImagePreviewActive, setIsImagePreviewActive] = useState<boolean>(false);
  const { id } = useParams();
  const dispatch = useDispatch();

  const handleOnSubmit = () => {
    if (formData.image.length < 1) {
      setImageError('Image field is required.');
    } else {
      setImageError('');
    }

    if (formData.image.length > 0) {
      fetchNui('changeImageFromVehicle', {
        id,
        image: formData.image,
      })
        .then((res) => {
          if (res.success) {
            dispatch(changeImageFromVehicle(res.data.image));
            dispatch(setActiveModal(''));
            setFormData({ image: '' });
            setIsImagePreviewActive(false);
            successNotify('Image is successfully changed.');
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(changeImageFromVehicle(formData.image));
            dispatch(setActiveModal(''));
            setFormData({ image: '' });
            setIsImagePreviewActive(false);
            successNotify('Image is successfully changed.');
          } else {
            errorNotify('Error occurred while changed image.');
          }
        });
    }
  };

  const handleChange = (e: any) => {
    const { name, value } = e.target;
    setFormData((current) => ({ ...current, [name]: value }));

    if (formData.image.length < 0) {
      setImageError('Image field is required.');
    } else {
      setImageError('');
    }
  };

  const handleTakePicture = () => {
    fetchNui('takePicture', '')
      .then((res) => {
        if (res.success) {
          setFormData({ image: res.data.imageURL });
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          setFormData({
            image:
              'https://assetsio.reedpopcdn.com/pariah-gta-online.png?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
          });
        } else {
          errorNotify('Error occurred while took picture.');
        }
      });
  };

  useEffect(() => {
    if (formData.image) {
      const imagePreviewTimeout = setTimeout(() => {
        setIsImagePreviewActive(true);
      }, 500);

      return () => clearTimeout(imagePreviewTimeout);
    }
  }, [formData]);

  return (
    <>
      <Modal
        title="Change Image"
        submitButton="Change Image"
        type="change-image"
        onSubmit={handleOnSubmit}
      >
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="image" className="modal__form-label">
              Image
            </label>

            <div className="d-flex align-items-center">
              <Input
                onChange={handleChange}
                value={formData.image}
                id="image"
                name="image"
                placeholder="Please type the image url."
                className="w-100 me-2"
              />

              <div onClick={handleTakePicture} className="modal__icon-link">
                <Camera />
              </div>
            </div>

            {imageError && (
              <span className="modal__help-message modal__help-message--error">{imageError}</span>
            )}
          </div>

          {isImagePreviewActive && (
            <div className="modal__form-group">
              <label className="modal__form-label">Image Preview</label>

              <div className="d-flex flex-column">
                <img src={formData.image} alt="" className="modal__img modal__img" />
              </div>
            </div>
          )}
        </form>
      </Modal>
    </>
  );
};

export default ChangeImageModal;

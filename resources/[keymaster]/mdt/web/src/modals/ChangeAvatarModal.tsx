import React, { FC, useState, useEffect } from 'react';
import { Camera } from '@phosphor-icons/react';
import { useParams } from 'react-router-dom';
import { fetchNui } from '@/utils/fetchNui';
import { useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { changeAvatarFromUser } from '@/slices/searchSlice';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Modal from '@/components/Modal';
import Input from '@/components/Input';

const ChangeUserAvatarModal = () => {
  const [formData, setFormData] = useState({ image: '' });
  const [imageError, setImageError] = useState('');
  const [isAvatarPreviewActive, setIsAvatarPreviewActive] = useState<boolean>(false);
  const { uid } = useParams();
  const dispatch = useDispatch();

  const handleOnSubmit = () => {
    if (formData.image.length < 1) {
      setImageError('Avatar image field is required.');
    } else {
      setImageError('');
    }

    if (formData.image.length > 0) {
      fetchNui('changeAvatarFromUser', {
        uid,
        image: formData.image,
      })
        .then((res) => {
          if (res.success) {
            dispatch(changeAvatarFromUser(res.data.image));
            dispatch(setActiveModal(''));
            setFormData({ image: '' });
            setIsAvatarPreviewActive(false);
            successNotify('Avatar is successfully changed.');
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(changeAvatarFromUser(formData.image));
            dispatch(setActiveModal(''));
            setFormData({ image: '' });
            setIsAvatarPreviewActive(false);
            successNotify('Avatar is successfully changed.');
          } else {
            errorNotify('Error occurred while changed avatar.');
          }
        });
    }
  };

  const handleChange = (e: any) => {
    const { name, value } = e.target;
    setFormData((current) => ({ ...current, [name]: value }));

    if (formData.image.length < 0) {
      setImageError('Avatar image field is required.');
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
              'https://images.squarespace-cdn.com/content/v1/5446f93de4b0a3452dfaf5b0/1626904421257-T6I5V5IQ4GI2SJ8EU82M/Above+Avalon+Neil+Cybart',
          });
        } else {
          errorNotify('Error occurred while took picture.');
        }
      });
  };

  useEffect(() => {
    if (formData.image) {
      const imagePreviewTimeout = setTimeout(() => {
        setIsAvatarPreviewActive(true);
      }, 500);

      return () => clearTimeout(imagePreviewTimeout);
    }
  }, [formData]);

  return (
    <>
      <Modal
        title="Change Avatar"
        submitButton="Change Avatar"
        type="change-avatar"
        onSubmit={handleOnSubmit}
      >
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="avatar-image" className="modal__form-label">
              Avatar Image
            </label>

            <div className="d-flex align-items-center">
              <Input
                onChange={handleChange}
                value={formData.image}
                id="avatar-image"
                name="image"
                placeholder="Please type the avatar image url."
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

          {isAvatarPreviewActive && (
            <div className="modal__form-group">
              <label className="modal__form-label">Avatar Image Preview</label>

              <div className="d-flex flex-column">
                <img src={formData.image} alt="" className="modal__img modal__img--avatar" />
              </div>
            </div>
          )}
        </form>
      </Modal>
    </>
  );
};

export default ChangeUserAvatarModal;

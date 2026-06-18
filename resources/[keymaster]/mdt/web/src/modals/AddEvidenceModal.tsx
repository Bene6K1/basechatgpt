import React, { FC, useState, useEffect } from 'react';
import { Camera } from '@phosphor-icons/react';
import { useParams } from 'react-router-dom';
import { fetchNui } from '@/utils/fetchNui';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { addEvidencesForRecord } from '@/slices/recordsSlice';
import { addEvidenceToUser } from '@/slices/searchSlice';
import { addEvidenceToWantedDetail } from '@/slices/wantedsSlice';
import { addEvidenceToOffenderDetail } from '@/slices/offendersSlice';
import { addEvidenceToPoliceDetail } from '@/slices/policesSlice';
import { errorNotify, successNotify } from '@/utils/notification';
import { nanoid } from 'nanoid';
import environmentCheck from '@/utils/environmentCheck';

import Modal from '@/components/Modal';
import Input from '@/components/Input';

interface IAddEvidenceModalProps {
  addWhere: string;
}

const AddEvidenceModal: FC<IAddEvidenceModalProps> = ({ addWhere }) => {
  const [formData, setFormData] = useState({ name: '', image: '' });
  const [nameError, setNameError] = useState('');
  const [imageError, setImageError] = useState('');
  const [isImagePreviewActive, setIsImagePreviewActive] = useState<boolean>(false);
  const { id: recordId, uid: userId, id: offenderId, id: policeId } = useParams();
  const { editedWantedId } = useSelector((state: RootState) => state.globalSlice);
  const dispatch = useDispatch();

  const handleOnSubmit = () => {
    if (formData.name.length < 1) {
      setNameError('Name field is required.');
    } else {
      setNameError('');
    }

    if (formData.image.length < 1) {
      setImageError('Image field is required.');
    } else {
      setImageError('');
    }

    if (formData.name.length > 0 && formData.image.length > 0) {
      if (addWhere === 'record-detail') {
        fetchNui('addEvidencesForRecord', {
          recordId,
          name: formData.name,
          image: formData.image,
        })
          .then((res) => {
            if (res.success) {
              dispatch(
                addEvidencesForRecord({
                  id: res.data.id,
                  name: formData.name,
                  image: formData.image,
                }),
              );
              dispatch(setActiveModal(''));
              setFormData({ name: '', image: '' });
              setIsImagePreviewActive(false);
              successNotify('Evidence is successfully added.');
            } else if (res.error) {
              errorNotify(res.message);
            }
          })
          .catch(() => {
            // for only development environment.
            // don't touch these.
            if (environmentCheck(true)) {
              dispatch(
                addEvidencesForRecord({
                  id: nanoid(),
                  name: formData.name,
                  image: formData.image,
                }),
              );
              dispatch(setActiveModal(''));
              setFormData({ name: '', image: '' });
              setIsImagePreviewActive(false);
              successNotify('Evidence is successfully added.');
            } else {
              errorNotify('Error occurred while added evidences.');
            }
          });
      } else if (addWhere === 'user') {
        fetchNui('addEvidenceToUser', {
          uid: userId,
          name: formData.name,
          image: formData.image,
        })
          .then((res) => {
            if (res.success) {
              dispatch(
                addEvidenceToUser({
                  id: res.data.id,
                  name: formData.name,
                  image: formData.image,
                }),
              );
              dispatch(setActiveModal(''));
              setFormData({ name: '', image: '' });
              setIsImagePreviewActive(false);
              successNotify('Evidence is successfully added.');
            } else if (res.error) {
              errorNotify(res.message);
            }
          })
          .catch(() => {
            // for only development environment.
            // don't touch these.
            if (environmentCheck(true)) {
              dispatch(
                addEvidenceToUser({
                  id: nanoid(),
                  name: formData.name,
                  image: formData.image,
                }),
              );
              dispatch(setActiveModal(''));
              setFormData({ name: '', image: '' });
              setIsImagePreviewActive(false);
              successNotify('Evidence is successfully added.');
            } else {
              errorNotify('Error occurred while added evidences.');
            }
          });
      } else if (addWhere === 'wanted-detail') {
        fetchNui('addEvidenceToWanted', {
          wantedId: editedWantedId,
          name: formData.name,
          image: formData.image,
        })
          .then((res) => {
            if (res.success) {
              dispatch(
                addEvidenceToWantedDetail({
                  id: res.data.id,
                  name: formData.name,
                  image: formData.image,
                }),
              );
              dispatch(setActiveModal(''));
              setFormData({ name: '', image: '' });
              setIsImagePreviewActive(false);
              successNotify('Evidence is successfully added.');
            } else if (res.error) {
              errorNotify(res.message);
            }
          })
          .catch(() => {
            // for only development environment.
            // don't touch these.
            if (environmentCheck(true)) {
              dispatch(
                addEvidenceToWantedDetail({
                  id: nanoid(),
                  name: formData.name,
                  image: formData.image,
                }),
              );
              dispatch(setActiveModal(''));
              setFormData({ name: '', image: '' });
              setIsImagePreviewActive(false);
              successNotify('Evidence is successfully added.');
            } else {
              errorNotify('Error occurred while added evidences.');
            }
          });
      } else if (addWhere === 'offender-detail') {
        fetchNui('addEvidenceToOffender', {
          offenderId,
          name: formData.name,
          image: formData.image,
        })
          .then((res) => {
            if (res.success) {
              dispatch(
                addEvidenceToOffenderDetail({
                  id: res.data.id,
                  name: formData.name,
                  image: formData.image,
                }),
              );
              dispatch(setActiveModal(''));
              setFormData({ name: '', image: '' });
              setIsImagePreviewActive(false);
              successNotify('Evidence is successfully added.');
            } else if (res.error) {
              errorNotify(res.message);
            }
          })
          .catch(() => {
            // for only development environment.
            // don't touch these.
            if (environmentCheck(true)) {
              dispatch(
                addEvidenceToOffenderDetail({
                  id: nanoid(),
                  name: formData.name,
                  image: formData.image,
                }),
              );
              dispatch(setActiveModal(''));
              setFormData({ name: '', image: '' });
              setIsImagePreviewActive(false);
              successNotify('Evidence is successfully added.');
            } else {
              errorNotify('Error occurred while added evidences.');
            }
          });
      } else if (addWhere === 'police-detail') {
        fetchNui('addEvidenceToPolice', {
          policeId,
          name: formData.name,
          image: formData.image,
        })
          .then((res) => {
            if (res.success) {
              dispatch(
                addEvidenceToPoliceDetail({
                  id: res.data.id,
                  name: formData.name,
                  image: formData.image,
                }),
              );
              dispatch(setActiveModal(''));
              setFormData({ name: '', image: '' });
              setIsImagePreviewActive(false);
              successNotify('Evidence is successfully added.');
            } else if (res.error) {
              errorNotify(res.message);
            }
          })
          .catch(() => {
            // for only development environment.
            // don't touch these.
            if (environmentCheck(true)) {
              dispatch(
                addEvidenceToPoliceDetail({
                  id: nanoid(),
                  name: formData.name,
                  image: formData.image,
                }),
              );
              dispatch(setActiveModal(''));
              setFormData({ name: '', image: '' });
              setIsImagePreviewActive(false);
              successNotify('Evidence is successfully added.');
            } else {
              errorNotify('Error occurred while added evidences.');
            }
          });
      }
    }
  };

  const handleChange = (e: any) => {
    const { name, value } = e.target;
    setFormData((current) => ({ ...current, [name]: value }));

    if (formData.name.length < 0) {
      setNameError('Name field is required.');
    } else {
      setNameError('');
    }

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
          setFormData({ name: formData.name, image: res.data.imageURL });
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          setFormData({
            name: formData.name,
            image: 'https://geek.com.tr/wp-content/uploads/2023/03/FiveM-Terimleri.webp',
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
        title="Add Evidence"
        submitButton="Create Evidence"
        type="add-evidence"
        onSubmit={handleOnSubmit}
      >
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="evidence-name" className="modal__form-label">
              Evidence Name
            </label>
            <Input
              onChange={handleChange}
              value={formData.name}
              id="evidence-name"
              name="name"
              placeholder="Please type the evidence name."
            />
            {nameError && (
              <span className="modal__help-message modal__help-message--error">{nameError}</span>
            )}
          </div>

          <div className="modal__form-group">
            <label htmlFor="evidence-image" className="modal__form-label">
              Evidence Image
            </label>

            <div className="d-flex align-items-center">
              <Input
                onChange={handleChange}
                value={formData.image}
                id="evidence-image"
                name="image"
                placeholder="Please type the evidence image url."
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
              <label className="modal__form-label">Evidence Image Preview</label>

              <div className="d-flex flex-column">
                <img src={formData.image} alt="" className="modal__img" />
              </div>
            </div>
          )}
        </form>
      </Modal>
    </>
  );
};

export default AddEvidenceModal;

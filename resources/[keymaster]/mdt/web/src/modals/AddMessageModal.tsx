import React, { useState } from 'react';
import { useDispatch } from 'react-redux';
import { setActiveModal, addMessage } from '@/slices/globalSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import { nanoid } from 'nanoid';
import environmentCheck from '@/utils/environmentCheck';

import Modal from '@/components/Modal';
import Input from '@/components/Input';

const AddMessageModal = () => {
  const [formData, setFormData] = useState({ title: '', text: '' });
  const [titleError, setTitleError] = useState<string>('');
  const [messageError, setMessageError] = useState<string>('');
  const dispatch = useDispatch();

  const handleOnSubmit = () => {
    if (formData.title.length < 1) {
      setTitleError('Title field is required.');
    } else {
      setTitleError('');
    }

    if (formData.text.length < 1) {
      setMessageError('Message field is required.');
    } else {
      setMessageError('');
    }

    if (formData.title.length > 0 && formData.text.length > 0) {
      fetchNui('addMessage', {
        title: formData.title,
        text: formData.text,
      })
        .then((res) => {
          if (res.success) {
            dispatch(
              addMessage({
                id: res.data.id,
                title: formData.title,
                text: formData.text,
              }),
            );
            dispatch(setActiveModal(''));
            setFormData({ title: '', text: '' });
            setTitleError('');
            setMessageError('');
            successNotify('Message is successfully added.');
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              addMessage({
                id: nanoid(),
                title: formData.title,
                text: formData.text,
              }),
            );
            dispatch(setActiveModal(''));
            setFormData({ title: '', text: '' });
            setTitleError('');
            setMessageError('');
            successNotify('Message is successfully added.');
          } else {
            errorNotify('Error ocurred while added message.');
          }
        });
    }
  };

  const handleChange = (e: any) => {
    const { name, value } = e.target;
    setFormData((current) => ({ ...current, [name]: value }));

    if (formData.title.length < 1) {
      setTitleError('Title field is required.');
    } else {
      setTitleError('');
    }

    if (formData.text.length < 1) {
      setMessageError('Message field is required.');
    } else {
      setMessageError('');
    }
  };

  return (
    <>
      <Modal
        title="Add Message"
        submitButton="Create a Message"
        type="add-message"
        onSubmit={handleOnSubmit}
      >
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="title" className="modal__form-label">
              Title
            </label>
            <Input
              onChange={handleChange}
              id="title"
              name="title"
              placeholder="Please type the title."
            />
            {titleError && (
              <span className="modal__help-message modal__help-message--error">{titleError}</span>
            )}
          </div>

          <div className="modal__form-group">
            <label htmlFor="message" className="modal__form-label">
              Message
            </label>
            <Input
              onChange={handleChange}
              id="message"
              name="text"
              placeholder="Please type the message."
              className="w-100 me-2"
            />
            {messageError && (
              <span className="modal__help-message modal__help-message--error">{messageError}</span>
            )}
          </div>
        </form>
      </Modal>
    </>
  );
};

export default AddMessageModal;

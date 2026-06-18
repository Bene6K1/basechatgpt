import React, { useState, useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { addFines } from '@/slices/finesSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import { nanoid } from 'nanoid';
import environmentCheck from '@/utils/environmentCheck';

import Modal from '@/components/Modal';
import Input from '@/components/Input';
import NumericInput from '@/components/NumericInput';
import Select from '@/components/Select';

const jailTimeType = [
  {
    id: 'days',
    value: 'Days',
    name: 'Days',
  },
  {
    id: 'weeks',
    value: 'Weeks',
    name: 'Weeks',
  },
  {
    id: 'months',
    value: 'Months',
    name: 'Months',
  },
  {
    id: 'years',
    value: 'Years',
    name: 'Years',
  },
];

const AddFinesModal = () => {
  const [formData, setFormData] = useState({
    name: '',
    jailTime: '',
    jailTimeType: 'Days',
    money: '',
  });
  const [nameError, setNameError] = useState<string>('');
  const [jailTimeError, setJailTimeError] = useState<string>('');
  const [moneyError, setMoneyError] = useState<string>('');
  const dispatch = useDispatch();

  const handleOnSubmit = () => {
    if (formData.name.length < 1) {
      setNameError("Le nom de l'amende est requis.");
    } else {
      setNameError('');
    }

    if (formData.jailTime.length < 1 || formData.jailTimeType.length < 1) {
      setJailTimeError('La durée et le type de peine sont requis.');
    } else {
      setJailTimeError('');
    }

    if (formData.money.length < 1) {
      setMoneyError("Le montant de l'amende est requis.");
    } else {
      setMoneyError('');
    }

    if (
      (formData.name.length > 0 && formData.jailTime.length > 0) ||
      (formData.jailTimeType.length > 0 && formData.money.length > 0)
    ) {
      fetchNui('addFines', {
        name: formData.name,
        jailTime: formData.jailTime,
        jailTimeType: formData.jailTimeType,
        money: formData.money,
      })
        .then((res) => {
          if (res.success) {
            dispatch(
              addFines({
                id: res.data.id,
                lastEdited: res.data.lastEdited,
                jailTimeType: formData.jailTimeType,
                fields: [
                  {
                    text: formData.name,
                  },
                  {
                    text: `${formData.jailTime} ${formData.jailTimeType}`,
                  },
                  {
                    text: formData.money,
                  },
                  {
                    text: res.data.addedBy,
                  },
                ],
              }),
            );
            dispatch(setActiveModal(''));
            setFormData({ name: '', jailTime: '', jailTimeType: '', money: '' });
            successNotify('Fine is successfully added.');
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              addFines({
                id: nanoid(),
                lastEdited: 'Last edited 1 hours ago by Yordi',
                jailTimeType: formData.jailTimeType,
                fields: [
                  {
                    text: formData.name,
                  },
                  {
                    text: `${formData.jailTime} ${formData.jailTimeType}`,
                  },
                  {
                    text: formData.money,
                  },
                  {
                    text: 'Yordi',
                  },
                ],
              }),
            );
            dispatch(setActiveModal(''));
            setFormData({ name: '', jailTime: '', jailTimeType: '', money: '' });
            successNotify('Fine is successfully added.');
          } else {
            errorNotify('Error occurred while added fine.');
          }
        });
    }
  };

  const handleChange = (e: any) => {
    const { name, value } = e.target;
    setFormData((current) => ({ ...current, [name]: value }));
  };

  return (
    <>
      <Modal
        title="Ajouter une amende"
        submitButton="Créer une amende"
        type="add-fines"
        onSubmit={handleOnSubmit}
      >
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="name" className="modal__form-label">
              Nom de l'amende
            </label>
            <Input
              onChange={handleChange}
              id="name"
              name="name"
              placeholder="Veuillez saisir le nom de l'amende."
            />
            {nameError && (
              <span className="modal__help-message modal__help-message--error">{nameError}</span>
            )}
          </div>

          <div className="modal__form-group">
            <label htmlFor="jailTime" className="modal__form-label">
              Durée de peine
            </label>
            <div className="d-flex align-items-center">
              <Input
                onChange={handleChange}
                id="jailTime"
                name="jailTime"
                type="number"
                placeholder="Veuillez saisir la durée de la peine."
                className="w-100 me-3"
              />
              <Select
                onChange={handleChange}
                options={jailTimeType}
                id="jailTimeType"
                small
              />
            </div>
            {jailTimeError && (
              <span className="modal__help-message modal__help-message--error">
                {jailTimeError}
              </span>
            )}
          </div>

          <div className="modal__form-group">
            <label htmlFor="money" className="modal__form-label">
              Montant
            </label>
            <NumericInput
              onChange={handleChange}
              id="money"
              name="money"
              placeholder="Veuillez saisir le montant."
              className="w-100 me-2"
              value={''}
            />
            {moneyError && (
              <span className="modal__help-message modal__help-message--error">{moneyError}</span>
            )}
          </div>
        </form>
      </Modal>
    </>
  );
};

export default AddFinesModal;

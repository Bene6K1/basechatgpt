import React, { useState, useEffect } from 'react';
import Select, { components } from 'react-select';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { addRecords } from '@/slices/recordsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import { nanoid } from 'nanoid';
import environmentCheck from '@/utils/environmentCheck';
import moment from 'moment';

import profileImage from '@/assets/images/sidebar-profile.png';

import Modal from '@/components/Modal';
import Input from '@/components/Input';

const AddAvatarForSelect = (props: any) => {
  const { label, avatar } = props.data;

  return (
    <components.Option className="d-flex align-items-center" {...props}>
      {avatar && (
        <div className="modal-select-option__avatar">
          <img src={avatar} className="modal-select-option__avatar-img" />
        </div>
      )}

      <span className="modal-select-option__name">{label}</span>
    </components.Option>
  );
};

const AddRecordsModal = () => {
  let formattedRanks: any = [];
  const [recordTitle, setRecordTitle] = useState('');
  const [recordTitleError, setRecordTitleError] = useState('');
  const [ranks, setRanks] = useState<{ value: string; label: string }[]>([]);
  const [ranksError, setRanksError] = useState('');
  const { usersForSelect, ranksForSelect } = useSelector((state: RootState) => state.globalSlice);
  const { Option } = components;
  const dispatch = useDispatch();

  const handleSubmit = async () => {
    if (!recordTitle) {
      setRecordTitleError('Suspect field is required.');
    } else {
      setRecordTitleError('');
    }

    if (ranks.length < 1) {
      setRanksError('Ranks field is required.');
    } else {
      setRanksError('');
    }

    if (recordTitle && ranks.length > 0) {
      fetchNui('addRecords', {
        recordTitle,
        ranks: formattedRanks,
      })
        .then((res) => {
          if (res.success) {
            dispatch(
              addRecords({
                id: res.data.id,
                avatar: res.data.avatar,
                name: res.data.name,
                text: `#${res.data.id}`,
                ranks: formattedRanks,
                date: moment().format('DD.MM.YYYY'),
                addedBy: res.data.addedBy,
              }),
            );
            dispatch(setActiveModal(''));
            setRecordTitle('');
            setRanks([]);
            setRecordTitleError('');
            setRanksError('');
            formattedRanks = [];
            successNotify('Record is successfully added.');
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              addRecords({
                id: nanoid(),
                avatar: profileImage,
                name: recordTitle,
                text: '-',
                ranks: formattedRanks,
                date: moment().format('DD.MM.YYYY'),
                addedBy: 'nitroS',
              }),
            );
            dispatch(setActiveModal(''));
            setRecordTitle('');
            setRanks([]);
            setRecordTitleError('');
            setRanksError('');
            formattedRanks = [];
            successNotify('Record is successfully added.');
          } else {
            errorNotify('Error occurred while added record.');
          }
        });
    }
  };

  const handleRecordTitleChange = (e: any) => {
    setRecordTitle(e.target.value);
  };

  const handleRanksChange = (e: any) => {
    setRanks(e);

    if (ranks.length < 0) {
      setRanksError('Ranks field is required.');
    } else {
      setRanksError('');
    }
  };

  useEffect(() => {
    ranks.map((rank: any) => {
      formattedRanks.push({
        id: rank.value,
        name: rank.label,
      });
    });
  }, [ranks]);

  return (
    <>
      <Modal
        title="Ajouter un dossier"
        submitButton="Créer un dossier"
        type="add-records"
        onSubmit={handleSubmit}
      >
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="record-title" className="modal__form-label">
              Titre du dossier
            </label>
            <Input
              onChange={handleRecordTitleChange}
              id="record-title"
              name="record-title"
              placeholder="Veuillez saisir le titre du dossier."
            />
            {recordTitleError && (
              <span className="modal__help-message modal__help-message--error">
                {recordTitleError === 'Suspect field is required.'
                  ? 'Le champ du suspect est requis.'
                  : recordTitleError}
              </span>
            )}
          </div>

          <div className="modal__form-group">
            <label htmlFor="select-ranks" className="modal__form-label">
              Sélectionner les grades
            </label>
            <Select
              isMulti
              options={ranksForSelect}
              onChange={handleRanksChange}
              placeholder="Veuillez sélectionner les grades."
              id="select-ranks"
              className="modal-select-option"
              classNamePrefix="modal-select-option"
            />
            {ranksError && (
              <span className="modal__help-message modal__help-message--error">
                {ranksError === 'Ranks field is required.'
                  ? 'Le champ des grades est requis.'
                  : ranksError}
              </span>
            )}
          </div>
        </form>
      </Modal>
    </>
  );
};

export default AddRecordsModal;

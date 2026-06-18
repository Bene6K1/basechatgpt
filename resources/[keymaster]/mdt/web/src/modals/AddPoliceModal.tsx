import React, { useState, useEffect } from 'react';
import Select, { components } from 'react-select';
import { fetchNui } from '@/utils/fetchNui';
import { useParams } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { addPolices } from '@/slices/recordsSlice';
import { setActiveModal } from '@/slices/globalSlice';
import { errorNotify, successNotify } from '@/utils/notification';
import { nanoid } from 'nanoid';
import environmentCheck from '@/utils/environmentCheck';

import profileImage from '@/assets/images/sidebar-profile.png';
import Modal from '@/components/Modal';

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

const AddPoliceModal = () => {
  let formattedPolices: any = [];
  const [polices, setPolices] = useState<any>([]);
  const [policesError, setPolicesError] = useState<string>('');
  const { id: recordId } = useParams();
  const { usersForSelect } = useSelector((state: RootState) => state.globalSlice);
  const { Option } = components;
  const dispatch = useDispatch();

  const handleOnSubmit = () => {
    if (polices.length < 1) {
      setPolicesError('Polices field is required.');
    } else {
      setPolicesError('');
    }

    if (polices.length > 0) {
      fetchNui('addPolices', {
        recordId,
        polices,
      })
        .then((res) => {
          if (res.success) {
            res.data.map((item: any) => {
              dispatch(
                addPolices({
                  id: item.id,
                  avatar: item.avatar,
                  name: item.name,
                  text: `#${item.id}`,
                  ranks: item.ranks,
                  date: item.date,
                  addedBy: item.addedBy,
                }),
              );
            });
            dispatch(setActiveModal(''));
            setPolices([]);
            formattedPolices = [];
            successNotify('Polices is successfully added.');
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            const dummyData = [
              {
                id: nanoid(),
                avatar: profileImage,
                name: 'Yordi',
                text: '#1',
                ranks: [
                  {
                    id: 1,
                    name: 'Murderer',
                  },
                  {
                    id: 2,
                    name: 'Suspect',
                  },
                  {
                    id: 3,
                    name: 'Smuggling',
                  },
                ],
                date: '11.04.2023',
                addedBy: 'nitroS',
              },
            ];

            dummyData.map((item: any) => {
              dispatch(
                addPolices({
                  id: item.id,
                  avatar: item.avatar,
                  name: item.name,
                  text: `-`,
                  ranks: item.ranks,
                  date: item.date,
                  addedBy: item.addedBy,
                }),
              );
            });
            dispatch(setActiveModal(''));
            setPolices([]);
            formattedPolices = [];
            successNotify('Polices is successfully added.');
          } else {
            errorNotify('Error occurred while added polices.');
          }
        });
    }
  };

  const handleChange = (e: any) => {
    setPolices(e);

    if (polices.length < 0) {
      setPolicesError('Polices field is required.');
    } else {
      setPolicesError('');
    }
  };

  useEffect(() => {
    polices.map((offender: any) => {
      formattedPolices.push({
        id: offender.value,
        name: offender.label,
      });
    });
  }, [polices]);

  return (
    <>
      <Modal
        title="Add Police"
        submitButton="Add Police"
        type="add-police"
        onSubmit={handleOnSubmit}
      >
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="select-offender" className="modal__form-label">
              Select Polices
            </label>
            <Select
              onChange={handleChange}
              isMulti
              options={usersForSelect.filter((u) => u.isPolice === true)}
              components={{ Option: AddAvatarForSelect }}
              formatOptionLabel={(option) => (
                <div className="d-flex align-items-center">
                  <div className="modal-select-option__avatar modal-select-option__avatar--small">
                    <img src={option.avatar} className="modal-select-option__avatar-img" />
                  </div>

                  <span>{option.label}</span>
                </div>
              )}
              placeholder="Please select the polices."
              id="select-offender"
              className="modal-select-option"
              classNamePrefix="modal-select-option"
            />
            {policesError && (
              <span className="modal__help-message modal__help-message--error">{policesError}</span>
            )}
          </div>
        </form>
      </Modal>
    </>
  );
};

export default AddPoliceModal;

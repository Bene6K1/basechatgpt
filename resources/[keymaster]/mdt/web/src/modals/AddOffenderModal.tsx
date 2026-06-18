import React, { useState, useEffect } from 'react';
import Select, { components } from 'react-select';
import { fetchNui } from '@/utils/fetchNui';
import { useParams } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { addOffenders } from '@/slices/recordsSlice';
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

const AddOffenderModal = () => {
  const [offenders, setOffenders] = useState<any>([]);
  const [offendersError, setOffendersError] = useState<string>('');
  const [fines, setFines] = useState<any>([]);
  const [finesError, setFinesError] = useState<string>('');
  const [finesForSelect, setFinesForSelect] = useState<any>([]);
  const { id: recordId } = useParams();
  const { usersForSelect } = useSelector((state: RootState) => state.globalSlice);
  const { Option } = components;
  const dispatch = useDispatch();

  const handleOnSubmit = () => {
    if (offenders.length < 1) {
      setOffendersError('Offenders field is required.');
    } else {
      setOffendersError('');
    }

    if (fines.length < 1) {
      setFinesError('Fines field is required.');
    } else {
      setFinesError('');
    }

    if (offenders.length > 0 && fines.length > 0) {
      fetchNui('addOffenders', {
        recordId,
        offenders,
        fines,
      })
        .then((res) => {
          if (res.success) {
            res.data.map((item: any) => {
              dispatch(
                addOffenders({
                  id: item.id,
                  avatar: item.avatar,
                  name: item.name,
                  text: item.text,
                  ranks: item.ranks,
                  date: item.date,
                  addedBy: item.addedBy,
                }),
              );
            });
            dispatch(setActiveModal(''));
            setOffenders([]);
            successNotify('Offenders is successfully added.');
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
                addOffenders({
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
            setOffenders([]);
            successNotify('Offenders is successfully added.');
          } else {
            errorNotify('Error occurred while added offenders.');
          }
        });
    }
  };

  const handleChange = (e: any) => {
    setOffenders(e);

    if (offenders.length < 0) {
      setOffendersError('Offenders field is required.');
    } else {
      setOffendersError('');
    }
  };

  const handleChangeFines = (e: any) => {
    setFines(e);

    if (fines.length < 0) {
      setFinesError('Fines field is required.');
    } else {
      setFinesError('');
    }
  };

  useEffect(() => {
    fetchNui('getFinesForSelect', '')
      .then((res) => {
        if (res.success) {
          setFinesForSelect(res.data);
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          setFinesForSelect([
            {
              value: 1,
              label: 'MURDER-CAPITAL OFFENSE (1) - 3 Days - $20,000',
            },
            {
              value: 2,
              label: 'MURDER-CAPITAL OFFENSE (2) - 5 Weeks - $50,000',
            },
            {
              value: 3,
              label: 'MURDER-CAPITAL OFFENSE (3) - 25 Years - $150,000',
            },
          ]);
        } else {
          errorNotify('Error ocurred while fetched data.');
        }
      });
  }, []);

  return (
    <>
      <Modal
        title="Add Offender"
        submitButton="Add Offender"
        type="add-offender"
        onSubmit={handleOnSubmit}
      >
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="select-offender" className="modal__form-label">
              Select Offenders
            </label>
            <Select
              onChange={handleChange}
              isMulti
              options={usersForSelect}
              components={{ Option: AddAvatarForSelect }}
              formatOptionLabel={(option) => (
                <div className="d-flex align-items-center">
                  <div className="modal-select-option__avatar modal-select-option__avatar--small">
                    <img src={option.avatar} className="modal-select-option__avatar-img" />
                  </div>

                  <span>{option.label}</span>
                </div>
              )}
              placeholder="Please select the offenders."
              id="select-offender"
              className="modal-select-option"
              classNamePrefix="modal-select-option"
            />
            {offendersError && (
              <span className="modal__help-message modal__help-message--error">
                {offendersError}
              </span>
            )}
          </div>

          <div className="modal__form-group">
            <label htmlFor="select-offender" className="modal__form-label">
              Select Fines
            </label>
            <Select
              onChange={handleChangeFines}
              isMulti
              options={finesForSelect}
              placeholder="Please select the offenders."
              id="select-offender"
              className="modal-select-option"
              classNamePrefix="modal-select-option"
            />
            {finesError && (
              <span className="modal__help-message modal__help-message--error">{finesError}</span>
            )}
          </div>
        </form>
      </Modal>
    </>
  );
};

export default AddOffenderModal;

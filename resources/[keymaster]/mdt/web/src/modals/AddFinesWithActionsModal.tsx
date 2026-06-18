import React, { FC, useState, useEffect } from 'react';
import Select, { components } from 'react-select';
import { fetchNui } from '@/utils/fetchNui';
import { useParams } from 'react-router-dom';
import {  useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { addFinesToOffenderDetail } from '@/slices/offendersSlice';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';
import { nanoid } from 'nanoid';

import Modal from '@/components/Modal';

interface IAddFinesWithActionsModal {
  addWhere: string;
}

const AddFinesWithActionsModal: FC<IAddFinesWithActionsModal> = ({ addWhere }) => {
  const [fines, setFines] = useState<any>([]);
  const [finesError, setFinesError] = useState<string>('');
  const [finesForSelect, setFinesForSelect] = useState<any>([]);
  const { id: offenderId } = useParams();
  const { Option } = components;
  const dispatch = useDispatch();

  const handleOnSubmit = () => {
    if (fines.length < 1) {
      setFinesError('Fines field is required.');
    } else {
      setFinesError('');
    }

    if (fines.length > 0) {
      if (addWhere === 'offender-detail') {
        fetchNui('addFinesToOffender', {
          offenderId,
          fines,
        })
          .then((res) => {
            if (res.success) {
              res.data.map((item: any) => {
                dispatch(
                  addFinesToOffenderDetail({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              successNotify('Fines is successfully added.');
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
                  name: 'MURDER-CAPITAL OFFENSE (1) - 3 Days - $20,000',
                },
                {
                  id: nanoid(),
                  name: 'MURDER-CAPITAL OFFENSE (2) - 5 Weeks - $50,000',
                },
                {
                  id: nanoid(),
                  name: 'MURDER-CAPITAL OFFENSE (3) - 25 Years - $150,000',
                },
              ];

              dummyData.map((item: any) => {
                dispatch(
                  addFinesToOffenderDetail({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              successNotify('Fines is successfully added.');
            } else {
              errorNotify('Error occurred while added fines.');
            }
          });
      }
    }
  };

  const handleChange = (e: any) => {
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
      <Modal title="Add Fines" submitButton="Add Fines" type="add-fines" onSubmit={handleOnSubmit}>
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="select-fines" className="modal__form-label">
              Select Fines
            </label>
            <Select
              onChange={handleChange}
              isMulti
              options={finesForSelect}
              placeholder="Please select the fines."
              id="select-fines"
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

export default AddFinesWithActionsModal;

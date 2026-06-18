import React, { FC, useState, useEffect } from 'react';
import Select from 'react-select';
import { useParams } from 'react-router-dom';
import { fetchNui } from '@/utils/fetchNui';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { addRankToUser } from '@/slices/searchSlice';
import { addRanksForRecord } from '@/slices/recordsSlice';
import { addRankToWantedDetail } from '@/slices/wantedsSlice';
import { addRankToOffenderDetail } from '@/slices/offendersSlice';
import { addRankToPoliceDetail } from '@/slices/policesSlice';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Modal from '@/components/Modal';

interface IAddRanksModalProps {
  addWhere: string;
}

const AddRanksModal: FC<IAddRanksModalProps> = ({ addWhere }) => {
  let formattedRanks: any = [];
  const { editedWantedId, ranksForSelect } = useSelector((state: RootState) => state.globalSlice);
  const [ranks, setRanks] = useState([]);
  const [ranksError, setRanksError] = useState<string>('');
  const { id: recordId, uid: userId, id: offenderId, id: policeId } = useParams();

  const dispatch = useDispatch();

  const handleOnSubmit = async () => {
    if (ranks.length < 1) {
      setRanksError('Ranks field is required.');
    } else {
      setRanksError('');
    }

    if (ranks.length > 0) {
      if (addWhere === 'record-detail') {
        fetchNui('addRanksForRecord', {
          recordId,
          ranks: formattedRanks,
        })
          .then((res) => {
            if (res.success) {
              res.data.map((item: any) => {
                dispatch(
                  addRanksForRecord({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              setRanks([]);
              formattedRanks = [];
              successNotify('Ranks is successfully added.');
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
                  id: 10,
                  name: 'Suspect',
                },
                {
                  id: 11,
                  name: 'Murderer',
                },
              ];

              dummyData.map((item: any) => {
                dispatch(
                  addRanksForRecord({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              setRanks([]);
              formattedRanks = [];
              successNotify('Ranks is successfully added.');
            } else {
              errorNotify('Error occurred while ranks added.');
            }
          });
      } else if (addWhere === 'user') {
        fetchNui('addRankToUser', {
          uid: userId,
          ranks: formattedRanks,
        })
          .then((res) => {
            if (res.data) {
              res.data.map((item: any) => {
                dispatch(
                  addRankToUser({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              setRanks([]);
              formattedRanks = [];
              successNotify('Ranks is successfully added.');
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
                  id: 10,
                  name: 'Suspect',
                },
                {
                  id: 11,
                  name: 'Murderer',
                },
              ];

              dummyData.map((item: any) => {
                dispatch(
                  addRankToUser({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              setRanks([]);
              formattedRanks = [];
              successNotify('Ranks is successfully added.');
            } else {
              errorNotify('Error occurred while added ranks.');
            }
          });
      } else if (addWhere === 'wanted-detail') {
        fetchNui('addRankToWanted', {
          wantedId: editedWantedId,
          ranks: formattedRanks,
        })
          .then((res) => {
            if (res.data) {
              res.data.map((item: any) => {
                dispatch(
                  addRankToWantedDetail({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              setRanks([]);
              formattedRanks = [];
              successNotify('Ranks is successfully added.');
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
                  id: 10,
                  name: 'Suspect',
                },
                {
                  id: 11,
                  name: 'Murderer',
                },
              ];

              dummyData.map((item: any) => {
                dispatch(
                  addRankToWantedDetail({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              setRanks([]);
              formattedRanks = [];
              successNotify('Ranks is successfully added.');
            } else {
              errorNotify('Error occurred while added ranks.');
            }
          });
      } else if (addWhere === 'offender-detail') {
        fetchNui('addRankToOffender', {
          offenderId,
          ranks: formattedRanks,
        })
          .then((res) => {
            if (res.data) {
              res.data.map((item: any) => {
                dispatch(
                  addRankToOffenderDetail({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              setRanks([]);
              formattedRanks = [];
              successNotify('Ranks is successfully added.');
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
                  id: 10,
                  name: 'Suspect',
                },
                {
                  id: 11,
                  name: 'Murderer',
                },
              ];

              dummyData.map((item: any) => {
                dispatch(
                  addRankToOffenderDetail({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              setRanks([]);
              formattedRanks = [];
              successNotify('Ranks is successfully added.');
            } else {
              errorNotify('Error occurred while added ranks.');
            }
          });
      } else if (addWhere === 'police-detail') {
        fetchNui('addRankToOffender', {
          policeId,
          ranks: formattedRanks,
        })
          .then((res) => {
            if (res.data) {
              res.data.map((item: any) => {
                dispatch(
                  addRankToPoliceDetail({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              setRanks([]);
              formattedRanks = [];
              successNotify('Ranks is successfully added.');
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
                  id: 10,
                  name: 'Suspect',
                },
                {
                  id: 11,
                  name: 'Murderer',
                },
              ];

              dummyData.map((item: any) => {
                dispatch(
                  addRankToPoliceDetail({
                    id: item.id,
                    name: item.name,
                  }),
                );
              });
              dispatch(setActiveModal(''));
              setRanks([]);
              formattedRanks = [];
              successNotify('Ranks is successfully added.');
            } else {
              errorNotify('Error occurred while added ranks.');
            }
          });
      }
    }
  };

  const handleChange = (e: any) => {
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
      <Modal title="Add Ranks" submitButton="Add Rank" type="add-ranks" onSubmit={handleOnSubmit}>
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="select-rank" className="modal__form-label">
              Select Ranks
            </label>
            <Select
              onChange={handleChange}
              isMulti
              options={ranksForSelect}
              placeholder="Please select the ranks."
              id="select-rank"
              className="modal-select-option"
              classNamePrefix="modal-select-option"
            />
            {ranksError && (
              <span className="modal__help-message modal__help-message--error">{ranksError}</span>
            )}
          </div>
        </form>
      </Modal>
    </>
  );
};

export default AddRanksModal;

import React, { useState, useEffect } from 'react';
import Select, { components } from 'react-select';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { addWanteds } from '@/slices/wantedsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import { nanoid } from 'nanoid';
import environmentCheck from '@/utils/environmentCheck';
import moment from 'moment';

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

const types = [
  {
    value: 'user',
    label: 'User',
  },
  {
    value: 'vehicle',
    label: 'Vehicle',
  },
];

const AddWantedsModal = () => {
  let formattedRanks: any = [];
  const [suspect, setSuspect] = useState('');
  const [suspectError, setSuspectError] = useState('');
  const [ranks, setRanks] = useState<{ value: string; label: string }[]>([]);
  const [ranksError, setRanksError] = useState('');
  const [type, setType] = useState('user');
  const [typeError, setTypeError] = useState('');
  const [vehicle, setVehicle] = useState('');
  const [vehicleError, setVehicleError] = useState('');
  const { usersForSelect, ranksForSelect, vehiclesForSelect } = useSelector(
    (state: RootState) => state.globalSlice,
  );
  const { Option } = components;
  const dispatch = useDispatch();

  const handleSubmit = async () => {
    if (type.length < 1) {
      return setTypeError('Type field is required.');
    } else {
      setTypeError('');
    }

    if (type === 'user') {
      if (!suspect) {
        setSuspectError('Suspect field is required.');
      } else {
        setSuspectError('');
      }

      if (ranks.length < 1) {
        return setRanksError('Ranks field is required.');
      } else {
        setRanksError('');
      }
    } else if (type === 'vehicle') {
      if (!vehicle) {
        return setVehicleError('Vehicle field is required.');
      } else {
        setVehicleError('');
      }
    }

    fetchNui('addWanteds', {
      type,
      suspectId: suspect,
      ranks: formattedRanks,
      vehiclePlate: vehicle,
    })
      .then((res) => {
        if (res.success) {
          dispatch(
            addWanteds({
              id: res.data.id,
              avatar: res.data.avatar,
              name: res.data.name,
              text: `#${res.data.id}`,
              ranks: res.data.ranks,
              date: moment().format('DD.MM.YYYY'),
              addedBy: res.data.addedBy,
            }),
          );
          dispatch(setActiveModal(''));
          setSuspect('');
          setRanks([]);
          setVehicle('');
          setSuspectError('');
          setRanksError('');
          setVehicleError('');
          formattedRanks = [];
          successNotify('Wanted is successfully added.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(
            addWanteds({
              id: nanoid(),
              avatar: profileImage,
              name: 'Yordi',
              text: '-',
              ranks: [
                {
                  id: 1,
                  name: 'Suspect',
                },
                {
                  id: 2,
                  name: 'Murderer',
                },
                {
                  id: 3,
                  name: 'Smuggling',
                },
              ],
              date: moment().format('DD.MM.YYYY'),
              addedBy: 'nitroS',
            }),
          );
          dispatch(setActiveModal(''));
          setSuspect('');
          setRanks([]);
          setVehicle('');
          setSuspectError('');
          setRanksError('');
          setVehicleError('');
          formattedRanks = [];
          successNotify('Wanted is successfully added.');
        } else {
          errorNotify('Error occurred while added wanted.');
        }
      });
  };

  const handleSuspectChange = (e: any) => {
    setSuspect(e.value);

    if (suspect.length < 0) {
      setSuspectError('Suspect field is required.');
    } else {
      setSuspectError('');
    }
  };

  const handleRanksChange = (e: any) => {
    setRanks(e);

    if (ranks.length < 0) {
      setRanksError('Ranks field is required.');
    } else {
      setRanksError('');
    }
  };

  const handleTypeChange = (e: any) => {
    setType(e.value);

    if (type.length < 0) {
      setTypeError('Type field is required.');
    } else {
      setTypeError('');
    }
  };

  const handleVehicleChange = (e: any) => {
    setVehicle(e.value);

    if (suspect.length < 0) {
      setVehicleError('Suspect field is required.');
    } else {
      setVehicleError('');
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
        title="Ajouter un recherché"
        submitButton="Créer un recherché"
        type="add-wanteds"
        onSubmit={handleSubmit}
      >
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="select-type" className="modal__form-label">
              Sélectionner le type
            </label>
            <Select
              defaultValue={types[0]}
              options={[
                { value: 'user', label: 'Utilisateur' },
                { value: 'vehicle', label: 'Véhicule' },
              ]}
              onChange={handleTypeChange}
              placeholder="Veuillez sélectionner le type."
              id="select-type"
              className="modal-select-option"
              classNamePrefix="modal-select-option"
            />
            {typeError && (
              <span className="modal__help-message modal__help-message--error">
                {typeError === 'Type field is required.' ? 'Le champ type est requis.' : typeError}
              </span>
            )}
          </div>

          {type === 'user' && (
            <>
              <div className="modal__form-group">
                <label htmlFor="select-suspect" className="modal__form-label">
                  Sélectionner le suspect
                </label>
                <Select
                  isMulti={false}
                  options={usersForSelect}
                  onChange={handleSuspectChange}
                  components={{ Option: AddAvatarForSelect }}
                  formatOptionLabel={(option) => (
                    <div className="d-flex align-items-center">
                      <div className="modal-select-option__avatar modal-select-option__avatar--small">
                        <img src={option.avatar} className="modal-select-option__avatar-img" />
                      </div>

                      <span>{option.label}</span>
                    </div>
                  )}
                  placeholder="Veuillez sélectionner le suspect."
                  id="select-suspect"
                  className="modal-select-option"
                  classNamePrefix="modal-select-option"
                />
                {suspectError && (
                  <span className="modal__help-message modal__help-message--error">
                    {suspectError === 'Suspect field is required.'
                      ? 'Le champ suspect est requis.'
                      : suspectError}
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
            </>
          )}
          {type === 'vehicle' && (
            <div className="modal__form-group">
              <label htmlFor="select-vehicle" className="modal__form-label">
                Sélectionner le véhicule
              </label>
              <Select
                isMulti={false}
                options={vehiclesForSelect}
                onChange={handleVehicleChange}
                components={{ Option: AddAvatarForSelect }}
                formatOptionLabel={(option) => (
                  <div className="d-flex align-items-center">
                    <div className="modal-select-option__avatar modal-select-option__avatar--small">
                      <img src={option.avatar} className="modal-select-option__avatar-img" />
                    </div>

                    <span>{option.label}</span>
                  </div>
                )}
                placeholder="Veuillez sélectionner le véhicule."
                id="select-vehicle"
                className="modal-select-option"
                classNamePrefix="modal-select-option"
              />
              {vehicleError && (
                <span className="modal__help-message modal__help-message--error">
                  {vehicleError === 'Vehicle field is required.'
                    ? 'Le champ véhicule est requis.'
                    : vehicleError}
                </span>
              )}
            </div>
          )}
        </form>
      </Modal>
    </>
  );
};

export default AddWantedsModal;

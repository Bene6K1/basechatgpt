import React, { useState, useEffect } from 'react';
import Select, { components } from 'react-select';
import { fetchNui } from '@/utils/fetchNui';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { addBanList } from '@/slices/departmentSlice';
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

const AddBanListModal = () => {
  let formattedBannedUsers: any = [];
  const [bannedUsers, setBannedUsers] = useState<any>([]);
  const [bannedUsersError, setBannedUsersError] = useState<string>('');
  const { usersForSelect } = useSelector((state: RootState) => state.globalSlice);
  const { Option } = components;
  const dispatch = useDispatch();

  const handleOnSubmit = () => {
    if (bannedUsers.length < 1) {
      setBannedUsersError('Banned users field is required.');
    } else {
      setBannedUsersError('');
    }

    if (bannedUsers.length > 0) {
      fetchNui('addBannedUsers', {
        bannedUsers: formattedBannedUsers,
      })
        .then((res) => {
          if (res.success) {
            res.data.map((item: any) => {
              dispatch(
                addBanList({
                  id: item.id,
                  avatar: item.avatar,
                  name: item.name,
                  text: item.text,
                  ranks: item.bans,
                  date: item.status,
                  addedBy: item.rank,
                }),
              );
            });
            dispatch(setActiveModal(''));
            setBannedUsers([]);
            formattedBannedUsers = [];
            successNotify('Banned users is successfully added.');
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
                bans: [
                  {
                    id: 0,
                    name: '10',
                  },
                ],
                status: 'Online',
                rank: 'Beginner',
              },
            ];

            dummyData.map((item: any) => {
              dispatch(
                addBanList({
                  id: item.id,
                  avatar: item.avatar,
                  name: item.name,
                  text: `-`,
                  ranks: item.bans,
                  date: item.status,
                  addedBy: item.rank,
                }),
              );
            });
            dispatch(setActiveModal(''));
            setBannedUsers([]);
            formattedBannedUsers = [];
            successNotify('Banned users is successfully added.');
          } else {
            errorNotify('Error occurred while added banned users.');
          }
        });
    }
  };

  const handleChange = (e: any) => {
    setBannedUsers(e);

    if (bannedUsers.length < 0) {
      setBannedUsersError('Banned users field is required.');
    } else {
      setBannedUsersError('');
    }
  };

  useEffect(() => {
    bannedUsers.map((offender: any) => {
      formattedBannedUsers.push({
        id: offender.value,
        name: offender.label,
      });
    });
  }, [bannedUsers]);

  return (
    <>
      <Modal
        title="Ajouter un utilisateur banni"
        submitButton="Ajouter un utilisateur banni"
        type="add-ban-list"
        onSubmit={handleOnSubmit}
      >
        <form className="modal__form">
          <div className="modal__form-group">
            <label htmlFor="select-offender" className="modal__form-label">
              Sélectionner les utilisateurs bannis
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
              placeholder="Veuillez sélectionner les utilisateurs bannis."
              id="select-offender"
              className="modal-select-option"
              classNamePrefix="modal-select-option"
            />
            {bannedUsersError && (
              <span className="modal__help-message modal__help-message--error">
                {bannedUsersError === 'Banned users field is required.'
                  ? 'Le champ des utilisateurs bannis est requis.'
                  : bannedUsersError}
              </span>
            )}
          </div>
        </form>
      </Modal>
    </>
  );
};

export default AddBanListModal;

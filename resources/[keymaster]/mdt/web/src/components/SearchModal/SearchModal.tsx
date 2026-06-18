import React, { FC, useState, useEffect, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { useOnClickOutside } from 'usehooks-ts';
import { useDispatch } from 'react-redux';
import { setEditedWantedId } from '@/slices/globalSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Loader from '@/components/Loader';
import CardCorners from '@/components/CardCorners';

import profileImage from '@/assets/images/sidebar-profile.png';
import profileImageTwo from '@/assets/images/on-duty-profile-image.png';
import profileImageThree from '@/assets/images/recording-details-profile-image.png';
import carImage from '@/assets/images/car-image.png';
import './SearchModal.scss';

const initialUsers = [
  {
    uid: 1,
    avatar: profileImage,
    name: 'Conor Short',
  },
  {
    uid: 2,
    avatar: profileImageTwo,
    name: 'Catalina Barr',
  },
  {
    uid: 3,
    avatar: profileImageThree,
    name: 'Tiara Dean',
  },
];

const initialVehicles = [
  {
    id: 1,
    ownerUid: 1,
    avatar: carImage,
    plate: 'ABCD1234',
    carName: 'Maserati',
    owner: 'Yordi',
  },
  {
    id: 2,
    ownerUid: 1,
    avatar: carImage,
    plate: 'ABCD1234',
    carName: 'Maserati',
    owner: 'Yordi',
  },
  {
    id: 3,
    ownerUid: 1,
    avatar: carImage,
    plate: 'ABCD1234',
    carName: 'Maserati',
    owner: 'Yordi',
  },
];

const initialRecords = [
  {
    id: 1,
    avatar: profileImage,
    name: 'Fizzfau',
    rank: 'Murderer',
    date: '11.04.2023',
  },
  {
    id: 2,
    avatar: profileImage,
    name: 'Fizzfau',
    rank: 'Murderer',
    date: '11.04.2023',
  },
  {
    id: 3,
    avatar: profileImage,
    name: 'Fizzfau',
    rank: 'Murderer',
    date: '11.04.2023',
  },
];

const initialWanteds = [
  {
    id: 1,
    avatar: profileImage,
    name: 'Fizzfau',
    rank: 'Murderer',
    date: '11.04.2023',
  },
  {
    id: 2,
    avatar: profileImage,
    name: 'Fizzfau',
    rank: 'Murderer',
    date: '11.04.2023',
  },
  {
    id: 3,
    avatar: profileImage,
    name: 'Fizzfau',
    rank: 'Murderer',
    date: '11.04.2023',
  },
];

interface ISearchModalProps {
  show: boolean;
  setShow: any;
}

const SearchModal: FC<ISearchModalProps> = ({ show, setShow }) => {
  const navigate = useNavigate();
  const ref = useRef<HTMLDivElement>(null);
  const refInner = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLInputElement>(null);
  const [value, setValue] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [users, setUsers] = useState<any>([]);
  const [vehicles, setVehicles] = useState<any>([]);
  const [records, setRecords] = useState<any>([]);
  const [wanteds, setWanteds] = useState<any>([]);
  const dispatch = useDispatch();

  const handleFocus = () => {
    ref.current?.classList.add('has-focus-input');
  };

  const handleBlur = () => {
    ref.current?.classList.remove('has-focus-input');
  };

  const handleChange = (event: any) => {
    setValue(event.target.value);
  };

  const handleCloseModal = () => {
    ref.current?.classList.remove('is-active');

    setTimeout(() => {
      setShow(false);
      setIsLoading(true);
      setValue('');
    }, 350);
  };

  const handleNavigate = (path: string) => {
    navigate(path);
    handleCloseModal();
  };

  const handleWantedNavigate = (id: number) => {
    navigate('/wanteds');
    dispatch(setEditedWantedId(id));
    handleCloseModal();
  };

  useEffect(() => {
    if (show) {
      setTimeout(() => {
        ref.current?.classList.add('is-active');
        inputRef.current?.focus();
      }, 1);
    }
  }, [show]);

  useEffect(() => {
    setIsLoading(true);

    if (value.length >= 3) {
      const searchTimeout = setTimeout(() => {
        fetchNui('getSearchResults', {
          value,
        })
          .then((res) => {
            if (res.success) {
              setUsers(res.data.users);
              setVehicles(res.data.vehicles);
              setRecords(res.data.records);
              setWanteds(res.data.wanteds);
              setIsLoading(false);
            } else if (res.error) {
              errorNotify(res.message);
            }
          })
          .catch(() => {
            // for only development environment.
            // don't touch these.
            if (environmentCheck(true)) {
              setUsers(initialUsers);
              setVehicles(initialVehicles);
              setRecords(initialRecords);
              setWanteds(initialWanteds);
              setIsLoading(false);
            } else {
              errorNotify('Error occurred while searched data.');
              handleCloseModal();
            }
          });
      }, 500);

      return () => clearTimeout(searchTimeout);
    }
  }, [value]);

  useOnClickOutside(refInner, handleCloseModal);

  return (
    <>
      {show && (
        <div ref={ref} className="search-modal">
          <div ref={refInner} className="search-modal__inner card-with-corners">
            <div className="search-modal__header">
              <div className="search-modal__header-left">
                {/* <div className="search-modal__header-icon">
                  <i className="fa-duotone fa-solid fa-magnifying-glass" style={{ color: "white" }}></i>
                </div> */}
                <div className="search-modal__header-titles">
                  <span className="search-modal__header-title">Recherche</span>
                  <span className="search-modal__header-subtitle">Rechercher des utilisateurs, véhicules, dossiers...</span>
                </div>
              </div>
            </div>

            <div className="search-modal__search-container">
              <input
                ref={inputRef}
                onFocus={handleFocus}
                onBlur={handleBlur}
                onChange={handleChange}
                autoFocus={true}
                id="search-input"
                type="text"
                className="search-modal__input"
                placeholder="Rechercher..."
              />

              <label htmlFor="search-input" className="search-modal__search-icon">
                <i className="fa-duotone fa-solid fa-magnifying-glass"></i>
              </label>
            </div>

            {value && (
              <div className="search-modal__main">
                {isLoading ? (
                  <Loader />
                ) : (
                  <>
                    {users.length > 0 && (
                      <div className="search-modal__section">
                        <span className="search-modal__title">Users</span>

                        {users.map((user: any) => (
                          <div
                            key={user.uid}
                            onClick={() => handleNavigate(`/search/users/${user.uid}`)}
                            className="search-modal__item"
                          >
                            <div className="d-flex align-items-center">
                              <div className="search-modal__avatar me-2">
                                <img
                                  src={user.avatar}
                                  alt=""
                                  className="search-modal__avatar-img"
                                />
                              </div>

                              <span className="search-modal__text">{user.name}</span>
                            </div>

                            <div className="search-modal__right-arrow">
                              <i className="fa-duotone fa-solid fa-arrow-right"></i>
                            </div>
                          </div>
                        ))}
                      </div>
                    )}

                    {vehicles.length > 0 && (
                      <div className="search-modal__section">
                        <span className="search-modal__title">Vehicles</span>

                        {vehicles.map((vehicle: any) => (
                          <div
                            key={vehicle.id}
                            onClick={() =>
                              handleNavigate(
                                `/search/vehicles/${vehicle.id}?owner_uid=${vehicle.ownerUid}`,
                              )
                            }
                            className="search-modal__item"
                          >
                            <div className="d-flex align-items-center">
                              <div className="search-modal__avatar me-2">
                                <img
                                  src={vehicle.avatar}
                                  alt=""
                                  className="search-modal__avatar-img"
                                />
                              </div>

                              <span className="search-modal__text">{vehicle.plate}</span>
                              <div className="search-modal__circle"></div>
                              <p className="search-modal__text text-regular">
                                Car Name: <span className="text-bold">{vehicle.carName}</span>
                              </p>
                              <div className="search-modal__circle"></div>
                              <p className="search-modal__text text-regular">
                                Owner: <span className="text-bold">{vehicle.owner}</span>
                              </p>
                            </div>

                            <div className="search-modal__right-arrow">
                              <i className="fa-duotone fa-solid fa-arrow-right"></i>
                            </div>
                          </div>
                        ))}
                      </div>
                    )}

                    {records.length > 0 && (
                      <div className="search-modal__section">
                        <span className="search-modal__title">Records</span>

                        {records.map((record: any) => (
                          <div
                            key={record.id}
                            onClick={() => handleNavigate(`/records/${record.id}`)}
                            className="search-modal__item"
                          >
                            <div className="d-flex align-items-center">
                              <div className="search-modal__avatar me-2">
                                <img
                                  src={record.avatar}
                                  alt=""
                                  className="search-modal__avatar-img"
                                />
                              </div>

                              <span className="search-modal__text">{record.name}</span>
                              <div className="search-modal__circle"></div>
                              <p className="search-modal__text text-regular">
                                Rank: <span className="text-bold">{record.rank}</span>
                              </p>
                              <div className="search-modal__circle"></div>
                              <p className="search-modal__text text-regular">
                                Date: <span className="text-bold">{record.date}</span>
                              </p>
                            </div>

                            <div className="search-modal__right-arrow">
                              <i className="fa-duotone fa-solid fa-arrow-right"></i>
                            </div>
                          </div>
                        ))}
                      </div>
                    )}

                    {wanteds.length > 0 && (
                      <div className="search-modal__section">
                        <span className="search-modal__title">Wanteds</span>

                        {wanteds.map((wanted: any) => (
                          <div
                            key={wanted.id}
                            onClick={() => handleWantedNavigate(wanted.id)}
                            className="search-modal__item"
                          >
                            <div className="d-flex align-items-center">
                              <div className="search-modal__avatar me-2">
                                <img
                                  src={wanted.avatar}
                                  alt=""
                                  className="search-modal__avatar-img"
                                />
                              </div>

                              <span className="search-modal__text">{wanted.name}</span>
                              <div className="search-modal__circle"></div>
                              <p className="search-modal__text text-regular">
                                Rank: <span className="text-bold">{wanted.rank}</span>
                              </p>
                              <div className="search-modal__circle"></div>
                              <p className="search-modal__text text-regular">
                                Date: <span className="text-bold">{wanted.date}</span>
                              </p>
                            </div>

                            <div className="search-modal__right-arrow">
                              <i className="fa-duotone fa-solid fa-arrow-right"></i>
                            </div>
                          </div>
                        ))}
                      </div>
                    )}
                  </>
                )}
              </div>
            )}
          </div>
        </div>
      )}
    </>
  );
};

export default SearchModal;

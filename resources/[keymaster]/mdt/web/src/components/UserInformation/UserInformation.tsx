import React, { FC, useState, useEffect } from 'react';
import { useParams, useSearchParams } from 'react-router-dom';
import { FolderMinus, Check, X, Camera } from '@phosphor-icons/react';
import { useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { deleteRankFromUser, deleteEvidenceFromUser } from '@/slices/searchSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Ranks from '@/components/Ranks';
import FoundEvidences from '@/components/FoundEvidences';
import Loader from '@/components/Loader';

import ChangeAvatarModal from '@/modals/ChangeAvatarModal';

import './UserInformation.scss';

interface IUserInformationProps {
  data: {
    avatar: any;
    name: string;
    text: string;
    isWanted: boolean;
    ranks: any;
    labels: any;
    licenses: any;
    evidences: any;
  };
  title?: any;
}

const UserInformation: FC<IUserInformationProps> = ({ data, title }) => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { avatar, name, text, isWanted, ranks, labels, licenses, evidences } = data;
  const [searchParams] = useSearchParams();
  const ownerUserId = searchParams.get('owner_uid');
  const { uid } = useParams();
  const dispatch = useDispatch();

  const handleDeleteRank = (id: number) => {
    fetchNui('deleteRankFromUser', {
      id,
      uid: uid || ownerUserId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteRankFromUser(id));
          successNotify('Rank is sucessfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteRankFromUser(id));
          successNotify('Rank is sucessfully deleted.');
        } else {
          errorNotify('Error occured while deleted rank.');
        }
      });
  };

  const handleDeleteEvidence = (id: number) => {
    fetchNui('deleteEvidenceFromUser', {
      id,
      uid: uid || ownerUserId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteEvidenceFromUser(id));
          successNotify('Evidence is sucessfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteEvidenceFromUser(id));
          successNotify('Evidence is sucessfully deleted.');
        } else {
          errorNotify('Error occured while deleted evidence.');
        }
      });
  };

  useEffect(() => {
    setIsLoading(false);
  }, [data]);

  return (
    <>
      <ChangeAvatarModal />

      <section className="user-information">
        <div className="user-information__header">
          <div className="section-line section-line--blue"></div>

          {title ? (
            <h3 className="section-title" dangerouslySetInnerHTML={{ __html: title }}></h3>
          ) : (
            <h3 className="section-title">
              User: <span className="text-extrabold">{name}</span>
            </h3>
          )}
        </div>

        <div className="user-information__main">
          {isLoading ? (
            <Loader />
          ) : (
            <>
              <div className="d-flex">
                <div className="user-information__avatar mr-15">
                  <img src={avatar} alt="" className="user-information__avatar-img" />

                  <div
                    onClick={() => dispatch(setActiveModal('change-avatar'))}
                    className="user-information__avatar-change"
                  >
                    <Camera />
                  </div>
                </div>

                <div className="d-flex flex-column">
                  <div className="d-flex align-items-center">
                    <span className="user-information__title">{name}</span>

                    {isWanted && <span className="user-information__wanted ms-2">Wanted</span>}
                  </div>

                  <p className="user-information__text">{text}</p>

                  <Ranks
                    data={ranks}
                    addWhere="user"
                    handleRemove={handleDeleteRank}
                    className="mt-1"
                  />

                  <div className="user-information__labels mt-1">
                    {labels.map((label: any, index: any) => (
                      <span
                        key={index}
                        className="user-information__label user-information__label--light-red"
                      >
                        {label.name}
                      </span>
                    ))}
                  </div>
                </div>
              </div>

              <div className="user-information__hr"></div>

              <div className="d-flex flex-column mb-4">
                <div className="d-flex align-items-center mb-15">
                  <div className="section-square section-square--blue"></div>
                  <span className="section-title section-title--medium text-bold">
                    License Information
                  </span>
                </div>

                <div className="user-information__license">
                  <div className="row g-3">
                    {licenses.map((license: any, index: any) => (
                      <div key={index} className="col-lg-6">
                        <div className="user-information__license-item">
                          <div className="user-information__license-icon">
                            <FolderMinus />
                          </div>

                          <div className="user-information__license-inner">
                            <span className="user-information__license-text">{license.name}</span>

                            {license.status === 'success' && (
                              <div className="user-information__license-status user-information__license-status--success">
                                <Check />
                              </div>
                            )}
                            {license.status === 'error' && (
                              <div className="user-information__license-status user-information__license-status--error">
                                <X />
                              </div>
                            )}
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              <FoundEvidences
                data={evidences}
                handleRemove={handleDeleteEvidence}
                addWhere="user"
              />
            </>
          )}
        </div>
      </section>
    </>
  );
};

export default UserInformation;

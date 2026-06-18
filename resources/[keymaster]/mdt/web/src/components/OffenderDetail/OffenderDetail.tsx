import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import {
  setOffenderDetail,
  deleteRankFromOffenderDetail,
  deleteEvidenceFromOffenderDetail,
  deleteFinesFromOffenderDetail,
} from '@/slices/offendersSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import FoundEvidences from '@/components/FoundEvidences';
import FinesWithActions from '@/components/FinesWithActions';
import Ranks from '@/components/Ranks';
import Textarea from '@/components/Textarea';
import Loader from '@/components/Loader';
import HelpMessage from '@/components/HelpMessage';
import CardCorners from '@/components/CardCorners';

import profileImage from '@/assets/images/recording-details-profile-image.png';
import evidenceExampleImage from '@/assets/images/evidence-example-image.webp';
import './OffenderDetail.scss';

const OffenderDetail = () => {
  const { offenderDetail } = useSelector((state: RootState) => state.offendersSlice);
  const [formReportText, setFormReportText] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [isDuplicate, setIsDuplicate] = useState<number>(0);
  const { id, avatar, name, madeBy, ranks, reportText, evidences, fines } = offenderDetail;
  const dispatch = useDispatch();
  const { id: oid } = useParams();

  const handleDeleteRank = (id: number) => {
    fetchNui('deleteRankFromOffender', {
      id,
      offenderId: oid,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteRankFromOffenderDetail(id));
          successNotify('Rank is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteRankFromOffenderDetail(id));
          successNotify('Rank is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted rank.');
        }
      });
  };

  const handleDeleteEvidence = (id: number) => {
    fetchNui('deleteEvidenceFromOffender', {
      id,
      offenderId: oid,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteEvidenceFromOffenderDetail(id));
          successNotify('Evidence is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteEvidenceFromOffenderDetail(id));
          successNotify('Evidence is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted evidence.');
        }
      });
  };

  const handleDeleteFines = (id: number) => {
    fetchNui('deleteFinesFromOffender', {
      id,
      offenderId: oid,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteFinesFromOffenderDetail(id));
          successNotify('Fines is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteFinesFromOffenderDetail(id));
          successNotify('Fines is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted fines.');
        }
      });
  };

  const handleSubmitReportText = () => {
    setIsDuplicate((current: any) => (current += 1));

    if (isDuplicate > 1) return;

    fetchNui('editReportTextFromOffender', {
      id,
      reportText: formReportText,
    })
      .then((res) => {
        if (res.success) {
          successNotify('Report text is succesfully updated.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          successNotify('Report text is succesfully updated.');
        } else {
          errorNotify('Error occurred while updated report text.');
        }
      });
  };

  useEffect(() => {
    setIsLoading(true);

    fetchNui('getOffenderDetail', {
      id: oid,
    })
      .then((res) => {
        if (res.success) {
          dispatch(setOffenderDetail(res.data));
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(
            setOffenderDetail({
              id: 0,
              avatar: profileImage,
              name: 'Yordi',
              madeBy: 'Yordi',
              ranks: [
                {
                  id: 1,
                  name: 'Suspect',
                },
                {
                  id: 2,
                  name: 'Murderer',
                },
              ],
              reportText: 'test',
              evidences: [
                {
                  id: 1,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
                {
                  id: 2,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
                {
                  id: 3,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
              ],
              fines: [
                {
                  id: 1,
                  name: 'MURDER-CAPITAL OFFENSE (1) - 3 Days - $20,000',
                },
                {
                  id: 2,
                  name: 'MURDER-CAPITAL OFFENSE (2) - 5 Weeks - $50,000',
                },
                {
                  id: 3,
                  name: 'MURDER-CAPITAL OFFENSE (3) - 25 Years - $150,000',
                },
              ],
            }),
          );
        } else {
          errorNotify('Error occurred while fetched data.');
        }
      });
  }, []);

  useEffect(() => {
    if (isDuplicate > 2) {
      const resetDuplicate = setTimeout(() => {
        setIsDuplicate(0);
      }, 1000 * 60 * 1);

      return () => clearTimeout(resetDuplicate);
    }
  }, [isDuplicate]);

  useEffect(() => {
    setTimeout(() => {
      setIsLoading(false);
      setFormReportText(reportText);
    }, 300);
  }, [offenderDetail]);

  return (
    <section className="offender-detail card-with-corners card-with-corners--no-border">
      <CardCorners color="rgba(255, 255, 255, 0.5)" />
      <div className="offender-detail__header">
        <div className="offender-detail__header-left">
          <div className="offender-detail__header-icon">
            <i className="fa-duotone fa-solid fa-user-secret" style={{ color: "white" }}></i>
          </div>
          <div className="offender-detail__header-titles">
            <span className="offender-detail__header-title">Détails du contrevenant</span>
            <span className="offender-detail__header-subtitle">Informations et rapports</span>
          </div>
        </div>
      </div>

      <div className="offender-detail__main">
        {isLoading ? (
          <Loader />
        ) : (
          <>
            <div className="d-flex">
              <div className="offender-detail__avatar mr-15">
                <img src={avatar} alt="" className="offender-detail__avatar-img" />
                <span className="offender-detail__avatar-inner">Offender</span>
              </div>

              <div className="d-flex flex-column mt-1">
                <div className="d-flex align-items-center">
                  <p className="offender-detail__text">
                    Name: <span className="text-regular">{name}</span>
                  </p>
                </div>

                <div className="d-flex align-items-center">
                  <p className="offender-detail__text">
                    ID: <span className="text-regular">#{id}</span>
                  </p>
                </div>

                <Ranks
                  data={ranks}
                  handleRemove={handleDeleteRank}
                  addWhere="offender-detail"
                  className="mt-1 offender-detail-ranks"
                />

                <span className="offender-detail__by-made mt-2">
                  Procédure créée par <span className="text-extrabold">{madeBy}</span>
                </span>
              </div>
            </div>

            <div className="offender-detail__hr"></div>

            <div className="d-flex flex-column mb-4">
              <div className="d-flex align-items-center mb-15">
                <div className="offender-detail__header-icon offender-detail__header-icon-litle">
                  <i className="fa-duotone fa-solid fa-file-invoice" style={{ color: "white" }}></i>
                </div>
                <span className="offender-detail__title">
                  Rapport de procès-verbal
                </span>
              </div>

              <Textarea
                value={formReportText}
                setValue={setFormReportText}
                onSubmit={handleSubmitReportText}
              />
              {isDuplicate > 2 && (
                <HelpMessage status="error">
                  Vous mettez à jour trop rapidement, veuillez faire une pause.
                </HelpMessage>
              )}
            </div>

            <FoundEvidences
              data={evidences}
              handleRemove={handleDeleteEvidence}
              addWhere="offender-detail"
            />

            <FinesWithActions
              data={fines}
              handleRemove={handleDeleteFines}
              addWhere="offender-detail"
              className="mt-4"
            />
          </>
        )}
      </div>
    </section>
  );
};

export default OffenderDetail;

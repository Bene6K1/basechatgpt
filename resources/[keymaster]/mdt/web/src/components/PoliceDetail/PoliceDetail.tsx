import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import {
  setPoliceDetail,
  deleteRankFromPoliceDetail,
  deleteEvidenceFromPoliceDetail,
} from '@/slices/policesSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import FoundEvidences from '@/components/FoundEvidences';
import Ranks from '@/components/Ranks';
import Textarea from '@/components/Textarea';
import Loader from '@/components/Loader';
import HelpMessage from '@/components/HelpMessage';
import CardCorners from '@/components/CardCorners';

import profileImage from '@/assets/images/recording-details-profile-image.png';
import evidenceExampleImage from '@/assets/images/evidence-example-image.webp';
import './PoliceDetail.scss';

const PoliceDetail = () => {
  const { policeDetail } = useSelector((state: RootState) => state.policesSlice);
  const [formReportText, setFormReportText] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [isDuplicate, setIsDuplicate] = useState<number>(0);
  const { id, avatar, name, madeBy, ranks, reportText, evidences } = policeDetail;
  const dispatch = useDispatch();
  const { id: policeId } = useParams();

  const handleDeleteRank = (id: number) => {
    fetchNui('deleteRankFromPolice', {
      id,
      policeId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteRankFromPoliceDetail(id));
          successNotify('Rank is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteRankFromPoliceDetail(id));
          successNotify('Rank is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted rank.');
        }
      });
  };

  const handleDeleteEvidence = (id: number) => {
    fetchNui('deleteEvidenceFromPolice', {
      id,
      policeId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteEvidenceFromPoliceDetail(id));
          successNotify('Rank is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteEvidenceFromPoliceDetail(id));
          successNotify('Evidence is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted evidence.');
        }
      });
  };

  const handleSubmitReportText = () => {
    setIsDuplicate((current: any) => (current += 1));

    if (isDuplicate > 1) return;

    fetchNui('editReportTextFromPolice', {
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

    fetchNui('getPoliceDetail', {
      id: policeId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(setPoliceDetail(res.data));
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(
            setPoliceDetail({
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
  }, [policeDetail]);

  return (
    <section className="police-detail card-with-corners card-with-corners--no-border">
      <CardCorners color="rgba(255, 255, 255, 0.5)" />
      <div className="police-detail__header">
        <div className="police-detail__header-left">
          <div className="police-detail__header-icon">
            <i className="fa-duotone fa-solid fa-shield" style={{ color: "white" }}></i>
          </div>
          <div className="police-detail__header-titles">
            <span className="police-detail__header-title">Détails de l'officier</span>
            <span className="police-detail__header-subtitle">Informations et rapports</span>
          </div>
        </div>
      </div>

      <div className="police-detail__main">
        {isLoading ? (
          <Loader />
        ) : (
          <>
            <div className="d-flex">
              <div className="police-detail__avatar mr-15">
                <img src={avatar} alt="" className="police-detail__avatar-img" />
                <span className="police-detail__avatar-inner">Police</span>
              </div>

              <div className="d-flex flex-column mt-1">
                <div className="d-flex align-items-center">
                  <p className="police-detail__text">
                    Name: <span className="text-regular">{name}</span>
                  </p>
                </div>

                <div className="d-flex align-items-center">
                  <p className="police-detail__text">
                    ID: <span className="text-regular">#{id}</span>
                  </p>
                </div>

                <Ranks
                  data={ranks}
                  handleRemove={handleDeleteRank}
                  addWhere="police-detail"
                  hideAddRank={true}
                  hideEditRank={true}
                  className="mt-1 police-detail-ranks"
                />

                <span className="police-detail__by-made mt-2">
                  Procédure créée par <span className="text-extrabold">{madeBy}</span>
                </span>
              </div>
            </div>

            <div className="police-detail__hr"></div>

            <div className="d-flex flex-column mb-4">
              <div className="d-flex align-items-center mb-15">
                <div className="police-detail__header-icon police-detail__header-icon-litle">
                  <i className="fa-duotone fa-solid fa-file-invoice" style={{ color: "white" }}></i>
                </div>
                <span className="police-detail__title">
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
              addWhere="police-detail"
            />
          </>
        )}
      </div>
    </section>
  );
};

export default PoliceDetail;

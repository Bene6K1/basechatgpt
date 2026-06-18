import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { deleteRankForRecord, deleteEvidenceForRecord } from '@/slices/recordsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import FoundEvidences from '@/components/FoundEvidences';
import Ranks from '@/components/Ranks';
import Textarea from '@/components/Textarea';
import Loader from '@/components/Loader';
import HelpMessage from '@/components/HelpMessage';
import CardCorners from '@/components/CardCorners';

import './RecordingDetails.scss';

const RecordingDetails = () => {
  const recordDetail = useSelector((state: RootState) => state.recordsSlice.recordDetail);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [formReportText, setFormReportText] = useState<any>('');
  const [isDuplicate, setIsDuplicate] = useState<number>(0);
  const { avatar, name, date, reportedPolice, reportText, ranks, evidences } = recordDetail;
  const { id: recordId } = useParams();
  const dispatch = useDispatch();

  const handleDeleteRank = (id: number) => {
    fetchNui('deleteRankFromRecord', {
      id,
      recordId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteRankForRecord(id));
          successNotify('Rank is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteRankForRecord(id));
          successNotify('Rank is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted rank.');
        }
      });
  };

  const handleDeleteEvidence = (id: number) => {
    fetchNui('deleteEvidenceFromRecord', {
      id,
      recordId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteEvidenceForRecord(id));
          successNotify('Evidence is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteEvidenceForRecord(id));
          successNotify('Evidence is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted evidence.');
        }
      });
  };

  const handleSubmitReportText = () => {
    setIsDuplicate((current: any) => (current += 1));

    if (isDuplicate > 1) return;

    fetchNui('editReportTextFromRecord', {
      id: recordId,
      reportText: formReportText,
    })
      .then((res) => {
        if (res.success) {
          successNotify('Report text is successfully updated.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          successNotify('Report text is successfully updated.');
        } else {
          errorNotify('Error occurred while updated report text.');
        }
      });
  };

  useEffect(() => {
    if (isDuplicate > 2) {
      const resetDuplicate = setTimeout(() => {
        setIsDuplicate(0);
      }, 1000 * 60 * 1);

      return () => clearTimeout(resetDuplicate);
    }
  }, [isDuplicate]);

  useEffect(() => {
    setIsLoading(false);
    setFormReportText(reportText);
  }, [recordDetail, ranks, evidences]);

  return (
    <div className="recording-details card-with-corners card-with-corners--no-border">
      <CardCorners color="rgba(255, 255, 255, 0.5)" />
      <div className="recording-details__header">
        <div className="recording-details__header-left">
          <div className="recording-details__header-icon">
            <i className="fa-duotone fa-solid fa-file-lines" style={{ color: "white" }}></i>
          </div>
          <div className="recording-details__header-titles">
            <span className="recording-details__header-title">Détails du dossier</span>
            <span className="recording-details__header-subtitle">Informations et rapports</span>
          </div>
        </div>
      </div>

      <div className="recording-details__main">
        {isLoading ? (
          <Loader />
        ) : (
          <>
            <div className="d-flex">
              <div className="recording-details__avatar mr-15">
                <img src={avatar} alt="" className="recording-details__avatar-img" />
                <span className="recording-details__avatar-inner">Police</span>
              </div>

              <div className="d-flex flex-column mt-1">
                <div className="d-flex align-items-center">
                  <p className="recording-details__text">
                    Records Name: <span className="text-regular">{name}</span>
                  </p>
                </div>

                <div className="d-flex align-items-center">
                  <p className="recording-details__text">
                    Records Date: <span className="text-regular">{date}</span>
                  </p>
                </div>

                <div className="d-flex align-items-center">
                  <p className="recording-details__text">
                    Reported Police: <span className="text-regular">{reportedPolice}</span>
                  </p>
                </div>

                <Ranks
                  data={ranks}
                  handleRemove={handleDeleteRank}
                  addWhere="record-detail"
                  className="mt-1 recording-details-ranks"
                />
              </div>
            </div>

            <div className="recording-details__hr"></div>

            <div className="d-flex flex-column mb-4">
              <div className="d-flex align-items-center mb-15">
                <div className="recording-details__header-icon">
                  <i className="fa-duotone fa-solid fa-file-invoice" style={{ color: "white" }}></i>
                </div>
                <span className="recording-details__title">Rapport de procès-verbal</span>
              </div>

              <Textarea
                value={formReportText}
                setValue={setFormReportText}
                onSubmit={handleSubmitReportText}
              />
              {isDuplicate > 2 && (
                <HelpMessage status="error">
                  You{"'"}re updating so fast, please take a break.
                </HelpMessage>
              )}
            </div>

            <FoundEvidences
              data={evidences}
              handleRemove={handleDeleteEvidence}
              addWhere="record-detail"
            />
          </>
        )}
      </div>
    </div>
  );
};

export default RecordingDetails;

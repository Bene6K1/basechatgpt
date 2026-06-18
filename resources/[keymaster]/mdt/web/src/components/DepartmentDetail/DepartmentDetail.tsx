import React, { useState, useEffect } from 'react';
import { Warning, UsersThree, MapPin } from '@phosphor-icons/react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Textarea from '@/components/Textarea';
import Loader from '@/components/Loader';
import HelpMessage from '@/components/HelpMessage';
import CardCorners from '@/components/CardCorners';

import departmentImage from '@/assets/images/department-image.png';
import './DepartmentDetail.scss';

const DepartmentDetail = () => {
  const { department, isFetchedDepartment } = useSelector(
    (state: RootState) => state.departmentSlice,
  );
  const { image, name, totalBans, totalPersonal, location, description } = department;
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [formDescription, setFormDescription] = useState<string>('');
  const [isDuplicate, setIsDuplicate] = useState<number>(0);

  const handleSubmitDescription = () => {
    setIsDuplicate((current: any) => (current += 1));

    if (isDuplicate > 1) return;

    fetchNui('editDescriptionOfDepartment', {
      description: formDescription,
    })
      .then((res) => {
        if (res.success) {
          successNotify('Description is successfully updated.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          successNotify('Description is successfully updated.');
        } else {
          errorNotify('Error occurred while updated description.');
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
    setFormDescription(description);
  }, [department]);

  return (
    <section className="department-detail card-with-corners card-with-corners--no-border">
      <CardCorners color="rgba(255, 255, 255, 0.5)" />
      <div className="department-detail__header">
        <div className="department-detail__header-left">
          <div className="department-detail__header-icon">
            <i className="fa-duotone fa-solid fa-building-shield" style={{ color: "white" }}></i>
          </div>
          <div className="department-detail__header-titles">
            <span className="department-detail__header-title">Département</span>
            <span className="department-detail__header-subtitle">Informations et description</span>
          </div>
        </div>
      </div>

      <div className="department-detail__main">
        {isLoading && isFetchedDepartment === 0 ? (
          <Loader />
        ) : (
          <>
            <div className="department-detail__image-container mb-4">
              <img src={image || departmentImage} alt="" className="department-detail__img" />

              <div className="department-detail__name">{name}</div>
            </div>

            <div className="d-flex flex-column">
              <div className="d-flex align-items-center mb-15">
                <div className="department-detail__header-icon department-detail__header-icon-litle">
                  <i className="fa-duotone fa-solid fa-circle-info" style={{ color: "white" }}></i>
                </div>
                <span className="department-detail__title">
                  Infos du département
                </span>
              </div>

              <div className="row g-2">
                <div className="col-lg-6">
                  <div className="department-detail__item">
                    <div className="department-detail__icon">
                      <Warning weight="fill" />
                    </div>

                    <div className="department-detail__item-inner">
                      <p className="department-detail__text">
                        Total bannissements :{' '}
                        <span className="department-detail__text text-bold">{totalBans}</span>
                      </p>
                    </div>
                  </div>
                </div>

                <div className="col-lg-6">
                  <div className="department-detail__item">
                    <div className="department-detail__icon">
                      <UsersThree weight="fill" />
                    </div>

                    <div className="department-detail__item-inner">
                      <p className="department-detail__text">
                        Effectif total :{' '}
                        <span className="department-detail__text text-bold">{totalPersonal}</span>
                      </p>
                    </div>
                  </div>
                </div>

                <div className="col-lg-12">
                  <div className="department-detail__item">
                    <div className="department-detail__icon">
                      <MapPin weight="fill" />
                    </div>

                    <div className="department-detail__item-inner">
                      <p className="department-detail__text">
                        Localisation :{' '}
                        <span className="department-detail__text text-bold">{location}</span>
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div className="department-detail__hr"></div>

            <div className="d-flex flex-column">
              <div className="d-flex align-items-center mb-15">
                <div className="department-detail__header-icon department-detail__header-icon-litle">
                  <i className="fa-duotone fa-solid fa-file-lines" style={{ color: "white" }}></i>
                </div>
                <span className="department-detail__title">
                  Description du département
                </span>
              </div>

              <Textarea
                value={formDescription}
                setValue={setFormDescription}
                onSubmit={handleSubmitDescription}
              />
              {isDuplicate > 2 && (
                <HelpMessage status="error">
                  Vous mettez à jour trop rapidement, veuillez faire une pause.
                </HelpMessage>
              )}
            </div>
          </>
        )}
      </div>
    </section>
  );
};

export default DepartmentDetail;

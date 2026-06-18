import React, { useState, useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';

import AddFinesModal from '@/modals/AddFinesModal';
import Button from '@/components/Button';
import Table from '@/components/Table';
import Loader from '@/components/Loader';
import CardCorners from '@/components/CardCorners';

import './FinesList.scss';

const FinesList = () => {
  const { fines, isFetched } = useSelector((state: RootState) => state.finesSlice);
  const { info, permissions } = useSelector((state: RootState) => state.globalSlice);
  const { policeRank } = info;
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const dispatch = useDispatch();

  const tableColumns = [
    {
      name: "Nom de l'amende",
    },
    {
      name: 'Durée de peine',
    },
    {
      name: 'Montant',
    },
    {
      name: 'Ajouté par',
    },
  ];

  useEffect(() => {
    setIsLoading(false);
  }, [fines]);

  return (
    <>
      <AddFinesModal />

      <section className="fines-list card-with-corners card-with-corners--no-border">
        <CardCorners color="rgba(255, 255, 255, 0.5)" />

        <div className="fines-list__header">
          <div className="fines-list__header-left">
            <div className="fines-list__header-icon">
              <i className="fa-duotone fa-solid fa-file-invoice-dollar" style={{ color: "white" }}></i>
            </div>
            <div className="fines-list__header-titles">
              <span className="fines-list__header-title">Liste des amendes</span>
              <span className="fines-list__header-subtitle">Gestion des amendes</span>
            </div>
          </div>

          {permissions.addFines.includes(policeRank.toLocaleLowerCase()) && (
            <Button
              onClick={() => dispatch(setActiveModal('add-fines'))}
              theme="purple"
              size="medium"
            >
              <i className="fa-duotone fa-solid fa-plus"></i>
              Ajouter une amende
            </Button>
          )}
        </div>

        <div className="fines-list__main">
          {isLoading && isFetched === 0 ? (
            <Loader />
          ) : (
            <Table columns={tableColumns} data={fines} />
          )}
        </div>
      </section>
    </>
  );
};

export default FinesList;

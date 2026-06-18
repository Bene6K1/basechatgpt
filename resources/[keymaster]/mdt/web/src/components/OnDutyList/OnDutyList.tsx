import React, { useState, useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';

import OnDutyCard from '@/components/OnDutyCard';
import Loader from '@/components/Loader';
import CardCorners from '@/components/CardCorners';

import './OnDutyList.scss';

const OnDutyList = () => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { onDutyList, isFetchedOnDutyList } = useSelector((state: RootState) => state.globalSlice);

  useEffect(() => {
    setIsLoading(false);
  }, [onDutyList]);

  return (
    <section className="on-duty-list card-with-corners card-with-corners--no-border">
      <CardCorners color="rgba(255, 255, 255, 0.5)" />
      <div className="on-duty-list__header">
        <div className="on-duty-list__header-left">
          <div className="on-duty-list__header-icon">
            <i className="fa-duotone fa-solid fa-users" style={{ color: "white" }}></i>
          </div>
          <div className="on-duty-list__header-titles">
            <span className="on-duty-list__header-title">Liste de service</span>
            <span className="on-duty-list__header-subtitle">Officiers en ligne</span>
          </div>
        </div>
      </div>

      <div className="on-duty-list__main">
        {isLoading && isFetchedOnDutyList === 0 ? (
          <Loader />
        ) : (
          <>
            {onDutyList.length > 0 ? (
              <>
                {onDutyList.map((duty) => (
                  <OnDutyCard key={duty.id} data={duty} />
                ))}
              </>
            ) : (
              <span className="section-text">Aucun policier en service trouvé.</span>
            )}
          </>
        )}
      </div>
    </section>
  );
};

export default OnDutyList;

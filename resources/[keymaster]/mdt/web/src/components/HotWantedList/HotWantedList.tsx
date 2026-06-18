import React, { useState, useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';

import HotWantedCard from '@/components/HotWantedCard';
import Loader from '@/components/Loader';
import CardCorners from '@/components/CardCorners';

import './HotWantedList.scss';

const HotWantedList = () => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { hotWantedList, isFetchedHotWantedList } = useSelector(
    (state: RootState) => state.globalSlice,
  );

  useEffect(() => {
    setIsLoading(true);
  }, [hotWantedList]);

  return (
    <section className="hot-wanted-list card-with-corners card-with-corners--no-border">
      <CardCorners color="rgba(255, 255, 255, 0.5)" />
      <div className="hot-wanted-list__header">
        <div className="hot-wanted-list__header-left">
          <div className="hot-wanted-list__header-icon">
            <i className="fa-duotone fa-solid fa-exclamation-triangle" style={{ color: "white" }}></i>
          </div>
          <div className="hot-wanted-list__header-titles">
            <span className="hot-wanted-list__header-title">Recherchés prioritaires</span>
            <span className="hot-wanted-list__header-subtitle">Suspects les plus recherchés</span>
          </div>
        </div>
      </div>

      <div className="hot-wanted-list__main">
        {isLoading && isFetchedHotWantedList === 0 ? (
          <Loader />
        ) : (
          <>
            {hotWantedList.length > 0 ? (
              <>
                {hotWantedList
                  .slice()
                  .reverse()
                  .map((wanted, index) => (
                    <HotWantedCard data={wanted} key={index} />
                  ))}
              </>
            ) : (
              <span className="section-text">Aucun suspect prioritaire recherché trouvé.</span>
            )}
          </>
        )}
      </div>
    </section>
  );
};

export default HotWantedList;

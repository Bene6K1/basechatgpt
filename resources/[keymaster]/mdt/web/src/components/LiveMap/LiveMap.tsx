import React from 'react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';

import Map from '@/components/Map';
import CardCorners from '@/components/CardCorners';
import './LiveMap.scss';

const LiveMap = () => {
  const { activePolices, dispatchs } = useSelector((state: RootState) => state.liveMapSlice);

  return (
    <>
      <section className="live-map card-with-corners card-with-corners--no-border">
        <CardCorners color="rgba(255, 255, 255, 0.5)" />
        <div className="live-map__header">
          <div className="live-map__header-left">
            <div className="live-map__header-icon">
              <i className="fa-duotone fa-solid fa-map-location-dot" style={{ color: "white" }}></i>
            </div>
            <div className="live-map__header-titles">
              <span className="live-map__header-title">Carte en direct</span>
              <span className="live-map__header-subtitle">Suivi en temps réel des unités</span>
            </div>
          </div>
        </div>

        <div className="live-map__main">
          <div className="live-map__inner">
            <Map markers={activePolices} dispatchs={dispatchs} />
          </div>
        </div>
      </section>
    </>
  );
};

export default LiveMap;

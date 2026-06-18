import React, { useState, useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';

import CamerasCard from '@/components/CamerasCard';
import Loader from '@/components/Loader';
import CardCorners from '@/components/CardCorners';

import './Cameras.scss';

const Cameras = () => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { cameras, isFetchedCameras } = useSelector((state: RootState) => state.camerasSlice);

  useEffect(() => {
    setIsLoading(false);
  }, [cameras]);

  return (
    <section className="cameras card-with-corners card-with-corners--no-border">
      <CardCorners color="rgba(255, 255, 255, 0.5)" />
      <div className="cameras__header">
        <div className="cameras__header-left">
          <div className="cameras__header-icon">
            <i className="fa-duotone fa-solid fa-video" style={{ color: "white" }}></i>
          </div>
          <div className="cameras__header-titles">
            <span className="cameras__header-title">Système de caméras</span>
            <span className="cameras__header-subtitle">Liste des caméras disponibles</span>
          </div>
        </div>
      </div>

      <div className="cameras__main">
        {isLoading && isFetchedCameras === 0 ? (
          <Loader />
        ) : (
          <div className="row g-4">
            {cameras.length > 0 &&
              cameras.map((camera) => (
                <div key={camera.id} className="col-md-12 col-lg-4 col-xl-3">
                  <CamerasCard data={camera} />
                </div>
              ))}
          </div>
        )}
      </div>
    </section>
  );
};

export default Cameras;

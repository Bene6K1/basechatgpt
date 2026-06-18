import React from 'react';
import { useParams } from 'react-router-dom';

import PoliceDetail from '@/components/PoliceDetail';
import BackTo from '@/components/BackTo';

const PolicesDetailPage = () => {
  const { id, recordId } = useParams();

  return (
    <>
      <div className="offenders-detail">
        <BackTo pageName="Record Details" href={`records/${recordId}`} />

        <div className="row g-4">
          {id && (
            <div className="col-lg-12 col-xl-6">
              <PoliceDetail />
            </div>
          )}
        </div>
      </div>
    </>
  );
};

export default PolicesDetailPage;

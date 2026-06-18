import React from 'react';
import { useParams } from 'react-router-dom';

import OffenderDetail from '@/components/OffenderDetail';
import BackTo from '@/components/BackTo';

const OffendersDetailPage = () => {
  const { id, recordId } = useParams();

  return (
    <>
      <div className="offenders-detail">
        <BackTo pageName="Record Details" href={`records/${recordId}`} />

        <div className="row g-4">
          {id && (
            <div className="col-lg-12 col-xl-6">
              <OffenderDetail />
            </div>
          )}
        </div>
      </div>
    </>
  );
};

export default OffendersDetailPage;

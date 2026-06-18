import React, { useState, useEffect } from 'react';
import { useAutoAnimate } from '@formkit/auto-animate/react';
import { useParams, useNavigate } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { deleteOffender } from '@/slices/recordsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import AddOffenderModal from '@/modals/AddOffenderModal';
import UserCard from '@/components/UserCard';
import SearchInput from '@/components/SearchInput';
import Button from '@/components/Button';
import Loader from '@/components/Loader';
import CardCorners from '@/components/CardCorners';

import './OffenderList.scss';

const columns = {
  oneColumnTitle: 'Rank',
  twoColumnTitle: 'Date',
  threeColumnTitle: 'Added by',
};

const OffenderList = () => {
  const recordDetail = useSelector((state: RootState) => state.recordsSlice.recordDetail);
  const { offenders } = recordDetail;
  const [searchValue, setSearchValue] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [animationParent] = useAutoAnimate();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { id: recordId } = useParams();

  const handleDelete = (id: number) => {
    fetchNui('deleteOffender', {
      id,
      recordId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteOffender(id));
          successNotify('Offender is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteOffender(id));
          successNotify('Offender is successfully deleted.');
        } else {
          errorNotify('Error occurredd while deleted offender.');
        }
      });
  };

  const filteredOffenders = offenders.filter((item: any) => {
    return item.name.toLowerCase().includes(searchValue.toLowerCase());
  });

  useEffect(() => {
    setIsLoading(false);
  }, [recordDetail, offenders]);

  return (
    <>
      <AddOffenderModal />

      <section className="offender-list card-with-corners card-with-corners--no-border">
        <CardCorners color="rgba(255, 255, 255, 0.5)" />
        <div className="offender-list__header">
          <div className="offender-list__header-left">
            <div className="offender-list__header-icon">
              <i className="fa-duotone fa-solid fa-user-secret" style={{ color: "white" }}></i>
            </div>
            <div className="offender-list__header-titles">
              <span className="offender-list__header-title">Liste des contrevenants</span>
              <span className="offender-list__header-subtitle">Gestion des suspects</span>
            </div>
          </div>
        </div>

        <div className="offender-list__main">
          {isLoading ? (
            <Loader />
          ) : (
            <>
              <div className="d-flex align-items-center mb-3">
                <SearchInput
                  value={searchValue}
                  setValue={setSearchValue}
                  placeholder="Search Offenders"
                />

                <Button
                  onClick={() => dispatch(setActiveModal('add-offender'))}
                  theme="purple"
                  minWidth={true}
                  className="ms-3"
                >
                  <i className="fa-duotone fa-solid fa-plus"></i>
                  Ajouter
                </Button>
              </div>

              <div ref={animationParent} className="offender-list__content">
                {offenders.length > 0 ? (
                  <>
                    {filteredOffenders.map((offender: any) => (
                      <UserCard
                        key={offender.id}
                        data={offender}
                        columns={columns}
                        deleteOnClick={() => handleDelete(offender.id)}
                        editOnClick={() => navigate(`/offenders/${offender.id}/${recordId}`)}
                      />
                    ))}
                  </>
                ) : (
                  <span className="section-text">Offenders is not found.</span>
                )}
                {offenders.length > 0 && filteredOffenders.length === 0 && (
                  <span className="section-text">Searching offender is not found.</span>
                )}
              </div>
            </>
          )}
        </div>
      </section>
    </>
  );
};

export default OffenderList;

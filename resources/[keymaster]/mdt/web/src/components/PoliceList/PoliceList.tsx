import React, { FC, useState, useEffect } from 'react';
import cx from 'classnames';
import { useAutoAnimate } from '@formkit/auto-animate/react';
import { useParams, useNavigate } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { deletePolice } from '@/slices/recordsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import AddPoliceModal from '@/modals/AddPoliceModal';
import UserCard from '@/components/UserCard';
import SearchInput from '@/components/SearchInput';
import Button from '@/components/Button';
import Loader from '@/components/Loader';
import CardCorners from '@/components/CardCorners';

import './PoliceList.scss';

const columns = {
  oneColumnTitle: 'Rank',
  twoColumnTitle: 'Date',
  threeColumnTitle: 'Added by',
};

interface IPoliceListProps {
  className?: string;
}

const PoliceList: FC<IPoliceListProps> = ({ className }) => {
  const recordDetail = useSelector((state: RootState) => state.recordsSlice.recordDetail);
  const { polices } = recordDetail;
  const [searchValue, setSearchValue] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [animationParent] = useAutoAnimate();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { id: recordId } = useParams();

  const filteredPolices = polices.filter((item: any) => {
    return item.name.toLowerCase().includes(searchValue.toLowerCase());
  });

  const handleDelete = (id: number) => {
    fetchNui('deletePolice', {
      id,
      recordId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deletePolice(id));
          successNotify('Police is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deletePolice(id));
          successNotify('Police is successfully deleted.');
        } else {
          errorNotify('Error occurredd while deleted police.');
        }
      });
  };

  useEffect(() => {
    setIsLoading(false);
  }, [recordDetail, polices]);

  return (
    <>
      <AddPoliceModal />

      <section className={cx('police-list card-with-corners card-with-corners--no-border', className)}>
        <CardCorners color="rgba(255, 255, 255, 0.5)" />
        <div className="police-list__header">
          <div className="police-list__header-left">
            <div className="police-list__header-icon">
              <i className="fa-duotone fa-solid fa-shield-check" style={{ color: "white" }}></i>
            </div>
            <div className="police-list__header-titles">
              <span className="police-list__header-title">Liste des policiers</span>
              <span className="police-list__header-subtitle">Agents assignés</span>
            </div>
          </div>
        </div>

        <div className="police-list__main">
          {isLoading ? (
            <Loader />
          ) : (
            <>
              <div className="d-flex align-items-center mb-3">
                <SearchInput
                  value={searchValue}
                  setValue={setSearchValue}
                  placeholder="Search Police"
                />

                <Button
                  onClick={() => dispatch(setActiveModal('add-police'))}
                  theme="purple"
                  minWidth={true}
                  className="ms-3"
                >
                  <i className="fa-duotone fa-solid fa-plus"></i>
                  Ajouter
                </Button>
              </div>

              <div ref={animationParent} className="police-list__content">
                {polices.length > 0 ? (
                  <>
                    {filteredPolices.map((police: any) => (
                      <UserCard
                        key={police.id}
                        data={police}
                        columns={columns}
                        deleteOnClick={() => handleDelete(police.id)}
                        editOnClick={() => navigate(`/polices/${police.id}/${recordId}`)}
                      />
                    ))}
                  </>
                ) : (
                  <span className="section-text">Polices is not found.</span>
                )}
                {polices.length > 0 && filteredPolices.length === 0 && (
                  <span className="section-text">Searching police is not found.</span>
                )}
              </div>
            </>
          )}
        </div>
      </section>
    </>
  );
};

export default PoliceList;

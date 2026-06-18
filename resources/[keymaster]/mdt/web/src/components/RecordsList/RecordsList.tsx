import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAutoAnimate } from '@formkit/auto-animate/react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import { addRecordsAsUnshift, deleteRecords } from '@/slices/recordsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import AddRecordsModal from '@/modals/AddRecordsModal';
import UserCard from '@/components/UserCard';
import Button from '@/components/Button';
import Loader from '@/components/Loader';
import CardCorners from '@/components/CardCorners';

import profileImage from '@/assets/images/sidebar-profile.png';
import './RecordsList.scss';

const columns = {
  oneColumnTitle: 'Grade',
  twoColumnTitle: 'Date',
  threeColumnTitle: 'Ajouté par',
};

const RecordsList = () => {
  const [animationParent] = useAutoAnimate();
  const { records, isFetched } = useSelector((state: RootState) => state.recordsSlice);
  const [maxShowData, setMaxShowData] = useState<number>(10);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [isLoadingLoadMore, setIsLoadingLoadMore] = useState<boolean>(false);
  const [isLoadMoreComplete, setIsLoadMoreComplete] = useState<boolean>(false);
  const navigate = useNavigate();
  const dispatch = useDispatch();

  const showData = records.slice().reverse().splice(0, maxShowData);

  const handleLoadMore = () => {
    const lastId = showData.at(-1)?.id;
    setIsLoadingLoadMore(true);

    fetchNui('loadRecords', {
      lastId,
    })
      .then((res) => {
        if (res.success) {
          if (!res.noneData) {
            setTimeout(() => {
              res.data.forEach((item: any) => {
                dispatch(
                  addRecordsAsUnshift({
                    id: item.id,
                    avatar: item.avatar,
                    name: item.name,
                    text: item.text,
                    ranks: item.ranks,
                    date: item.date,
                    addedBy: item.addedBy,
                  }),
                );
              });
              setIsLoadingLoadMore(false);
              setMaxShowData(
                (current) => (current += res.data.length >= 10 ? 10 : res.data.length),
              );
            }, 500);
          } else {
            setIsLoadMoreComplete(true);
          }
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          setTimeout(() => {
            dispatch(
              addRecordsAsUnshift({
                id: 17,
                avatar: profileImage,
                name: 'Yordi',
                text: '#0',
                ranks: [
                  {
                    id: 1,
                    name: 'Murderer',
                  },
                  {
                    id: 2,
                    name: 'Suspect',
                  },
                  {
                    id: 3,
                    name: 'Smuggling',
                  },
                ],
                date: '11.04.2023',
                addedBy: 'nitroS',
              }),
            );
            setIsLoadingLoadMore(false);
            setMaxShowData((current) => (current += 10));
            setIsLoadMoreComplete(true);
          }, 500);
        } else {
          errorNotify('Error occurred while fetched data.');
        }
      });
  };

  const handleDelete = (id: number) => {
    fetchNui('deleteRecord', {
      id,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteRecords(id));
          successNotify('Record is sucessfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteRecords(id));
          successNotify('Record is sucessfully deleted.');
        } else {
          errorNotify('Error occurred while deleted record.');
        }
      });
  };

  useEffect(() => {
    setIsLoading(false);
  }, [records]);

  return (
    <>
      <AddRecordsModal />

      <section className="records-list card-with-corners card-with-corners--no-border">
        <CardCorners color="rgba(255, 255, 255, 0.5)" />
        <div className="records-list__header">
          <div className="records-list__header-left">
            <div className="records-list__header-icon">
              <i className="fa-duotone fa-solid fa-folder-open" style={{ color: "white" }}></i>
            </div>
            <div className="records-list__header-titles">
              <span className="records-list__header-title">Liste des dossiers</span>
              <span className="records-list__header-subtitle">Gestion des dossiers criminels</span>
            </div>
          </div>

          <Button
            onClick={() => dispatch(setActiveModal('add-records'))}
            theme="purple"
            size="medium"
          >
            Ajouter un dossier
          </Button>
        </div>

        <div ref={animationParent} className="records-list__main">
          {isLoading && isFetched === 0 ? (
            <Loader />
          ) : (
            <>
              {records.length > 0 ? (
                <>
                  {showData.map((record) => (
                    <UserCard
                      key={record.id}
                      data={record}
                      columns={columns}
                      deleteOnClick={() => handleDelete(record.id)}
                      viewOnClick={() => navigate(`/records/${record.id}`)}
                    />
                  ))}
                </>
              ) : (
                <span className="section-text">Aucun dossier trouvé.</span>
              )}
            </>
          )}

          {!isLoadMoreComplete && records.length >= 10 && (
            <div onClick={handleLoadMore} className="records-list__load-more">
              <Button className="w-100">
                {isLoadingLoadMore ? (
                  <Loader nonePadding={true} hideText={true} />
                ) : (
                  <>Charger plus</>
                )}
              </Button>
            </div>
          )}
        </div>
      </section>
    </>
  );
};

export default RecordsList;

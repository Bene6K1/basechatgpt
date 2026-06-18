import React, { useState, useEffect } from 'react';
import { useAutoAnimate } from '@formkit/auto-animate/react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setEditedWantedId, setActiveModal } from '@/slices/globalSlice';
import { deleteWanteds, setIsActiveEditingDeleted } from '@/slices/wantedsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import AddWantedsModal from '@/modals/AddWantedsModal';
import UserCard from '@/components/UserCard';
import Button from '@/components/Button';
import Loader from '@/components/Loader';
import CardCorners from '@/components/CardCorners';

import './WantedList.scss';

const columns = {
  oneColumnTitle: 'Grade',
  twoColumnTitle: 'Date',
  threeColumnTitle: 'Ajouté par',
};

const WantedList = () => {
  const { editedWantedId } = useSelector((state: RootState) => state.globalSlice);
  const { wanteds, isFetched } = useSelector((state: RootState) => state.wantedsSlice);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [animationParent] = useAutoAnimate();
  const dispatch = useDispatch();

  const handleDelete = (id: number) => {
    if (editedWantedId === id) {
      dispatch(setIsActiveEditingDeleted(true));
    }

    fetchNui('deleteWanted', {
      id,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteWanteds(id));
          successNotify('Wanted is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for developement enivorment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteWanteds(id));
          successNotify('Wanted is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted wanted.');
        }
      });
  };

  useEffect(() => {
    setIsLoading(false);
  }, [wanteds]);

  return (
    <>
      <AddWantedsModal />

      <section className="wanted-list card-with-corners card-with-corners--no-border">
        <CardCorners color="rgba(255, 255, 255, 0.5)" />

        <div className="wanted-list__header">
          <div className="wanted-list__header-left">
            <div className="wanted-list__header-icon">
              <i className="fa-duotone fa-solid fa-user-police" style={{ color: "white" }}></i>
            </div>
            <div className="wanted-list__header-titles">
              <span className="wanted-list__header-title">Liste des recherchés</span>
              <span className="wanted-list__header-subtitle">Gestion des suspects</span>
            </div>
          </div>

          <Button
            onClick={() => dispatch(setActiveModal('add-wanteds'))}
            theme="purple"
            size="medium"
          >
            <i className="fa-duotone fa-solid fa-plus"></i>
            Ajouter un recherché
          </Button>
        </div>

        <div ref={animationParent} className="wanted-list__main">
          {isLoading && isFetched === 0 ? (
            <Loader />
          ) : (
            <>
              {wanteds.length > 0 ? (
                <>
                  {wanteds
                    .slice()
                    .reverse()
                    .map((wanted) => (
                      <UserCard
                        key={wanted.id}
                        data={wanted}
                        columns={columns}
                        deleteOnClick={() => handleDelete(wanted.id)}
                        editOnClick={() => dispatch(setEditedWantedId(wanted.id))}
                        className={editedWantedId === wanted.id ? 'is-editing' : ''}
                      />
                    ))}
                </>
              ) : (
                <span className="section-text">Aucun recherché trouvé.</span>
              )}
            </>
          )}
        </div>
      </section>
    </>
  );
};

export default WantedList;

import React, { useState } from 'react';
import { useAutoAnimate } from '@formkit/auto-animate/react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { deleteBanList } from '@/slices/departmentSlice';
import { setActiveModal } from '@/slices/globalSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import AddBanListModal from '@/modals/AddBanListModal';
import UserCard from '@/components/UserCard';
import SearchInput from '@/components/SearchInput';
import Button from '@/components/Button';
import CardCorners from '@/components/CardCorners';

import './DepartmentBanList.scss';

const columns = {
  oneColumnTitle: 'Grade',
  twoColumnTitle: 'Date',
  threeColumnTitle: 'Banni par',
};

const DepartmentBanList = () => {
  const banList = useSelector((state: RootState) => state.departmentSlice.banList);
  const [searchValue, setSearchValue] = useState<string>('');
  const [animationParent] = useAutoAnimate();
  const dispatch = useDispatch();

  const filteredBanList = banList.filter((item) => {
    return item.name.toLowerCase().includes(searchValue.toLowerCase());
  });

  const handleDelete = (id: number) => {
    fetchNui('deleteBanList', {
      id,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteBanList(id));
          successNotify("L'utilisateur banni a été supprimé avec succès.");
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteBanList(id));
          successNotify("L'utilisateur banni a été supprimé avec succès.");
        } else {
          errorNotify("Une erreur s'est produite lors de la suppression de l'utilisateur banni.");
        }
      });
  };

  return (
    <>
      <AddBanListModal />

      <section className="department-ban-list card-with-corners card-with-corners--no-border">
        <CardCorners color="rgba(255, 255, 255, 0.5)" />
        <div className="department-ban-list__header">
          <div className="department-ban-list__header-left">
            <div className="department-ban-list__header-icon">
              <i className="fa-duotone fa-solid fa-user-slash" style={{ color: "white" }}></i>
            </div>
            <div className="department-ban-list__header-titles">
              <span className="department-ban-list__header-title">Liste des bannis</span>
              <span className="department-ban-list__header-subtitle">Gestion des utilisateurs bannis du département</span>
            </div>
          </div>
        </div>

        <div className="department-ban-list__main">
          <div className="d-flex align-items-center mb-3">
            <SearchInput
              value={searchValue}
              setValue={setSearchValue}
              placeholder="Rechercher un utilisateur dans le département"
            />
            <Button
              onClick={() => dispatch(setActiveModal('add-ban-list'))}
              theme="purple"
              className="ms-3"
            >
              Ajouter un utilisateur banni
            </Button>
          </div>

          <div ref={animationParent} className="department-ban-list__content">
            {banList.length > 0 ? (
              <>
                {filteredBanList.map((item) => (
                  <UserCard
                    key={item.id}
                    data={item}
                    columns={columns}
                    deleteOnClick={() => handleDelete(item.id)}
                  />
                ))}
              </>
            ) : (
              <span className="section-text">Aucun utilisateur banni trouvé.</span>
            )}
            {banList.length > 0 && filteredBanList.length === 0 && (
              <span className="section-text">Aucun utilisateur trouvé lors de la recherche.</span>
            )}
          </div>
        </div>
      </section>
    </>
  );
};

export default DepartmentBanList;

import { useEffect, useState } from 'react';
import { useNuiEvent } from '@/lib/hooks';
import { Routes, Route, NavLink, Navigate } from 'react-router-dom';
import { maxValuesAtom, rawComponentsAtom } from '@/data/component';
import { ComponentData } from '@/types';
import { useAtom } from 'jotai';

import '@/styles/creator.scss';
import { isEnvBrowser } from './lib/constants';

import { FaIdCardAlt, FaDna, FaTshirt, FaCheck } from 'react-icons/fa';
import { FaFaceLaugh, FaXmark } from 'react-icons/fa6';
import { BsStars } from 'react-icons/bs';
import CardCorners from '@/components/CardCorners';

import {
  ClothesSelectedAtom,
  dateAtom,
  firstNameAtom,
  genderAtom,
  HeritageAtom,
  lastNameAtom,
  selectedCamAtom,
  sizeAtom
} from '@/data';

// pages
import Identity from '@/pages/Identity';
import Heritage from '@/pages/Heritage';
import Visage from '@/pages/Visage';
import Apparence from '@/pages/Apparence';
import Vetements from '@/pages/Vetements';
import { fetchNui } from './lib';

const App = () => {
  const [creatorVisible, SetCreatorVisible] = useState<boolean>(isEnvBrowser);
  useNuiEvent<boolean>('displayCreator', SetCreatorVisible);

  const [firstName, SetFirstName] = useAtom(firstNameAtom);
  const [lastName, SetLastName] = useAtom(lastNameAtom);
  const [date, SetDate] = useAtom(dateAtom);
  const [size, SetSize] = useAtom(sizeAtom);
  const [gender, SetGender] = useAtom(genderAtom);
  const [isFormValid, SetIsFormValid] = useState(false);

  const [, SetHeritageData] = useAtom(HeritageAtom);
  const [ClothesSelected, SetClothesSelected] = useAtom(ClothesSelectedAtom);

  const [, SetRawComps] = useAtom(rawComponentsAtom);
  const [, SetMaxVals] = useAtom(maxValuesAtom);

  const [selectedCam, setSelectedCam] = useAtom(selectedCamAtom);

  const resetCreator = () => {
    SetFirstName('');
    SetLastName('');
    SetDate('');
    SetSize(140);
    SetGender('male');

    SetHeritageData((prev) => ({
      ...prev,
      skin: 0,
      ressemblance: 0,
      motherId: 21,
      fatherId: 0,
      grandParentsId: 0,
      ressemblance_g: 0,
      selected: 'dad'
    }));

    SetClothesSelected(-1);
  };

  const handleValidate = () => {
    if (!firstName.trim() || !lastName.trim()) {
      console.log('First name and last name are required');
      return;
    }

    if (!date.trim() || !/^\d{2}\/\d{2}\/\d{4}$/.test(date)) {
      console.log('Valid date is required (DD/MM/YYYY)');
      return;
    }

    if (!size || size < 140 || size > 200) {
      console.log('Valid size is required (140-200)');
      return;
    }

    if (!gender) {
      console.log('Gender selection is required');
      return;
    }

    if (ClothesSelected <= 0) {
      console.log('Clothes selection is required');
      return;
    }

    fetchNui("creator:onValidate", {
      firstName,
      lastName,
      date,
      size,
      gender
    });
  };

  const handleCancel = () => {
    fetchNui("creator:onCancel");
  };

  useEffect(() => {
    const nameValid = firstName.trim() !== '' && lastName.trim() !== '';
    const formatValid = /^\d{2}\/\d{2}\/\d{4}$/.test(date);

    let clothesValid = false;
    let ageValid = false;

    if (formatValid) {
      const [day, month, year] = date.split('/').map((n) => parseInt(n, 10));
      const birth = new Date(year, month - 1, day);
      const today = new Date();

      if (
        !(
          birth.getFullYear() !== year ||
          birth.getMonth() !== month - 1 ||
          birth.getDate() !== day
        )
      ) {
        let age = today.getFullYear() - year;
        const mDiff = today.getMonth() - (month - 1);
        if (mDiff < 0 || (mDiff === 0 && today.getDate() < day)) {
          age--;
        }

        if (age > 0 && age < 100) {
          ageValid = true;
        }
      }
    }

    if (ClothesSelected > 0) clothesValid = true;

    SetIsFormValid(nameValid && formatValid && ageValid && clothesValid);
  }, [firstName, lastName, date, ClothesSelected]);

  useNuiEvent<ComponentData[]>('GetData', (data) => {
    SetRawComps(data);
  });

  useNuiEvent<Record<string, number>>('GetMaxVals', (data) => {
    SetMaxVals(data);
  });

  useEffect(() => {
    if (!creatorVisible) {
      resetCreator();
    }
  }, [creatorVisible]);

  useEffect(() => {
    fetchNui("creator:ChangeCam", selectedCam);
  }, [selectedCam]);

  return (
    creatorVisible && (
      <div className="creator-wrapper">
        <div className="creator">
          <div className="creator__bar bg-style card-with-corners">
            <CardCorners />
            <NavLink
              to="/identite"
              className={({ isActive }) =>
                `creator__bar-item${isActive ? ' creator__bar-item--active' : ''}`
              }
            >
              <FaIdCardAlt className="creator__bar-item--icon" />
              <span className="creator__bar-item--label">Identité</span>
            </NavLink>

            <NavLink
              to="/heredite"
              className={({ isActive }) =>
                `creator__bar-item${isActive ? ' creator__bar-item--active' : ''}`
              }
            >
              <FaDna className="creator__bar-item--icon" />
              <span className="creator__bar-item--label">Hérédité</span>
            </NavLink>

            <NavLink
              to="/visage"
              className={({ isActive }) =>
                `creator__bar-item${isActive ? ' creator__bar-item--active' : ''}`
              }
            >
              <FaFaceLaugh className="creator__bar-item--icon" />
              <span className="creator__bar-item--label">Visage</span>
            </NavLink>

            <NavLink
              to="/apparence"
              className={({ isActive }) =>
                `creator__bar-item${isActive ? ' creator__bar-item--active' : ''}`
              }
            >
              <BsStars className="creator__bar-item--icon" />
              <span className="creator__bar-item--label">Apparence</span>
            </NavLink>

            <NavLink
              to="/vetements"
              className={({ isActive }) =>
                `creator__bar-item${isActive ? ' creator__bar-item--active' : ''}`
              }
            >
              <FaTshirt className="creator__bar-item--icon" />
              <span className="creator__bar-item--label">Tenus</span>
            </NavLink>
          </div>

          <div className="creator__content bg-style card-with-corners">
            <CardCorners />
            <Routes>
              <Route path="/" element={<Navigate to="/identite" replace />} />
              <Route path="/identite" element={<Identity />} />
              <Route path="/heredite" element={<Heritage />} />
              <Route path="/visage" element={<Visage />} />
              <Route path="/apparence" element={<Apparence />} />
              <Route path="/vetements" element={<Vetements />} />
            </Routes>
          </div>

          <div className="creator__actions bg-style card-with-corners">
            <CardCorners />
            <div
              className={`creator__actions-item${!isFormValid ? ' disabled' : ''}`}
              onClick={handleValidate}
            >
              <FaCheck className="creator__actions-item--icon" />
              <span className="creator__actions-item--label">Valider</span>
            </div>

            <div className="creator__actions-item red" onClick={handleCancel}>
              <FaXmark className="creator__actions-item--icon" />
              <span className="creator__actions-item--label">Annuler</span>
            </div>
          </div>
        </div>
        <div className='creator-cam bg-style card-with-corners'>
          <CardCorners />
          <div className={`creator-cam__item ${selectedCam === "head" ? "active" : ""}`} onClick={() => setSelectedCam("head")}>
            <img src="../public/cams/head.png" alt="head" />
            <span>Tête</span>
          </div>
          <div className={`creator-cam__item ${selectedCam === "full" ? "active" : ""}`} onClick={() => setSelectedCam("full")}>
            <img src="../public/cams/torso.png" alt="full" />
            <span>Corps</span>
          </div>
          <div className={`creator-cam__item ${selectedCam === "legs" ? "active" : ""}`} onClick={() => setSelectedCam("legs")}>
            <img src="../public/cams/leg.png" alt="legs" />
            <span>Jambes</span>
          </div>
        </div>
      </div>
    )
  );
};

export default App;

import React, { useEffect, useState } from 'react';
import { useAtom } from 'jotai';
import {
  dateAtom,
  firstNameAtom,
  genderAtom,
  lastNameAtom,
  selectedCamAtom,
  sizeAtom,
} from '@/data';
import InputContainer from '@/components/InputContainer';
import PageHeader from '@/components/PageHeader';
import { FaMale, FaFemale, FaIdCardAlt } from 'react-icons/fa';
import { motion } from 'framer-motion';
import { fetchNui } from '@/lib';

const pageVariants = {
  initial: { opacity: 0, y: 20 },
  animate: { opacity: 1, y: 0, transition: { duration: 0.6, ease: 'easeOut' as const } },
  exit: { opacity: 0, y: -20, transition: { duration: 0.4, ease: 'easeIn' as const } },
};

const Identity: React.FC = () => {
  const [firstName, setFirstName] = useAtom(firstNameAtom);
  const [lastName, setLastName] = useAtom(lastNameAtom);
  const [dateIso, setDateIso] = useState('');
  const [dateFormatted, setDateFormatted] = useAtom(dateAtom);
  const [size, setSize] = useAtom(sizeAtom);
  const [gender, setGender] = useAtom(genderAtom);

  const handleDateChange = (value: string) => {
    setDateIso(value);
    if (/^\d{4}-\d{2}-\d{2}$/.test(value)) {
      const [year, month, day] = value.split('-');
      setDateFormatted(`${day}/${month}/${year}`);
    } else {
      setDateFormatted('');
    }
  };

  useEffect(() => {
    if (/^\d{2}\/\d{2}\/\d{4}$/.test(dateFormatted)) {
      const [day, month, year] = dateFormatted.split('/');
      setDateIso(`${year}-${month}-${day}`);
    } else {
      setDateIso('');
    }
  }, [dateFormatted]);

  useEffect(() => {
    fetchNui("creator:changeGender", gender)
  }, [gender])

    const [, setSelectedCam] = useAtom(selectedCamAtom);
    useEffect(() => {
      setSelectedCam('full');
    }, []);

  return (
    <motion.div
      className="container identity"
      variants={pageVariants}
      initial="initial"
      animate="animate"
      exit="exit"
    >
      <PageHeader
        icon={<FaIdCardAlt />}
        title="Identité"
        subtitle="Informations personnelles"
        nomarginbottom
      />

      <InputContainer
        label="Nom"
        placeholder="Entrer votre nom"
        value={firstName}
        onChange={(value) => setFirstName(value.toString())}
      />
      <InputContainer
        label="Prénom"
        placeholder="Entrer votre prénom"
        value={lastName}
        onChange={(value) => setLastName(value.toString())}
      />
      <InputContainer
        label="Date de naissance"
        type="date"
        value={dateIso}
        onChange={(value) => handleDateChange(value as string)}
      />
      <InputContainer
        label="Taille"
        type="range"
        value={size.toString()}
        min={100}
        max={200}
        step={1}
        onChange={(val) => setSize(typeof val === 'number' ? val : parseInt(val))}
        dontShowValue
      />

      <div className="gender">
        <div className="gender__title">Genre</div>
        <div className="gender__genders">
          <motion.div
            className={`gender__genders-item${gender === 'male' ? ' gender__genders-item--active' : ''}`}
            onClick={() => setGender('male')}
          >
            <FaMale />
          </motion.div>
          <motion.div
            className={`gender__genders-item${gender === 'female' ? ' gender__genders-item--active' : ''}`}
            onClick={() => setGender('female')}
          >
            <FaFemale />
          </motion.div>
        </div>
      </div>
    </motion.div>
  );
};

export default Identity;
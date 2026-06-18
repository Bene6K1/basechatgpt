import { useAtom } from 'jotai';
import { ClothesListAtom, ClothesSelectedAtom, selectedCamAtom, genderAtom } from '@/data';
import PageHeader from '@/components/PageHeader';
import { motion } from 'framer-motion';
import { useEffect } from 'react';
import { fetchNui } from '@/lib';
import { FaTshirt } from 'react-icons/fa';

const pageVariants = {
  initial: { opacity: 0, y: 20 },
  animate: { opacity: 1, y: 0, transition: { duration: 0.6, ease: 'easeOut' as const } },
  exit: { opacity: 0, y: -20, transition: { duration: 0.4, ease: 'easeIn' as const } },
};

const Vetements = () => {
  const [clothesList] = useAtom(ClothesListAtom);
  const [clothesSelected, setSelected] = useAtom(ClothesSelectedAtom);
  const [gender] = useAtom(genderAtom);

  const [, setSelectedCam] = useAtom(selectedCamAtom);
  useEffect(() => {
    setSelectedCam("full")
  }, []);

  // Réinitialiser la sélection de tenue quand le genre change
  useEffect(() => {
    setSelected(-1);
  }, [gender, setSelected]);

  const handleClothesClick = async (item: number) => {
    setSelected(item);
    await fetchNui('creator:updateClothes', { 
      selectedClothes: item,
      gender: gender 
    });
  };

  return (
    <motion.div
      className="container"
      variants={pageVariants}
      initial="initial"
      animate="animate"
      exit="exit"
    >
      <PageHeader
        icon={<FaTshirt />}
        title="Tenus"
        subtitle={gender === 'male' ? 'Vêtements homme' : 'Vêtements femme'}
      />
      <div className="clothes">
        {clothesList.map((item, index) => (
          <div 
            key={index} 
            className={`clothes__item${clothesSelected === item ? " active" : ""}`} 
            onClick={() => handleClothesClick(item)}
          >
            {item}
          </div>
        ))}
      </div>
    </motion.div>
  );
};

export default Vetements;
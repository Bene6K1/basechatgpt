import CardCorners from '@/components/CardCorners';
import InputContainer from '@/components/InputContainer';
import PageHeader from '@/components/PageHeader';
import {
  Fathers,
  GrandParents,
  HeritageAtom,
  Mothers,
  selectedCamAtom
} from '@/data';
import { fetchNui } from '@/lib';
import { motion } from 'framer-motion';
import { useAtom } from 'jotai';
import { useEffect } from 'react';
import { FaAngleDoubleLeft, FaAngleDoubleRight, FaDna } from 'react-icons/fa';

const pageVariants = {
  initial: { opacity: 0, y: 20 },
  animate: { opacity: 1, y: 0, transition: { duration: 0.6, ease: 'easeOut' as const } },
  exit: { opacity: 0, y: -20, transition: { duration: 0.4, ease: 'easeIn' as const } }
};

const Heritage = () => {
  const [HeritageData, SetHeritageData] = useAtom(HeritageAtom);

  const tablesMap = {
    dad: Fathers,
    mom: Mothers,
    grandparents: GrandParents
  } as const;

  const idKeyMap = {
    dad: 'fatherId',
    mom: 'motherId',
    grandparents: 'grandParentsId'
  } as const;

  const getParentName = (type?: 'dad' | 'mom' | 'grandparents') => {
    const table = tablesMap[type || HeritageData.selected];
    const idKey = idKeyMap[type || HeritageData.selected];
    const currentId = HeritageData[idKey];
    const item = table.find((p) => p.id === currentId);
    return item?.name ?? '';
  };

  const onChange = (key: string, type: string) => {
    let val = HeritageData[type];
    
    fetchNui('creator:onChange', {
      key: key,
      val: typeof(val) === "string" ? parseInt(val) : val
    });
  };

  const navigate = (direction: -1 | 1) => {
    const table = tablesMap[HeritageData.selected];
    const idKey = idKeyMap[HeritageData.selected] as
      | 'fatherId'
      | 'motherId'
      | 'grandParentsId';

    const currentId = HeritageData[idKey];
    const currentIndex = table.findIndex((p) => p.id === currentId);

    const newIndex = (currentIndex + direction + table.length) % table.length;
    const newId = table[newIndex].id;

    SetHeritageData((prev) => ({
      ...prev,
      [idKey]: newId
    }));

    fetchNui('creator:changeHr', {
      key: HeritageData.selected,
      val: newId
    });
  };

  const [, setSelectedCam] = useAtom(selectedCamAtom);
  useEffect(() => {
    setSelectedCam('head');
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
        icon={<FaDna />}
        title="Hérédité"
        subtitle="Traits génétiques et parents"
      />

      <div className="heritage">
        <div className="heritage__parents">
          <div className="heritage__parents-parent">
            <CardCorners color='rgba(255, 255, 255, 0.5)' />
            <img
              src={`../public/parents/${getParentName().toLowerCase()}.webp`}
              alt={getParentName()}
            />
          </div>
          <div className="heritage__parents-type">
            <div
              className={`heritage__parents-type-item${
                HeritageData.selected === 'dad'
                  ? ' heritage__parents-type-item--active'
                  : ''
              }`}
              onClick={() =>
                SetHeritageData((prev) => ({ ...prev, selected: 'dad' }))
              }
            >
              Père : {getParentName('dad')}
            </div>
            <div
              className={`heritage__parents-type-item${
                HeritageData.selected === 'mom'
                  ? ' heritage__parents-type-item--active'
                  : ''
              }`}
              onClick={() =>
                SetHeritageData((prev) => ({ ...prev, selected: 'mom' }))
              }
            >
              Mère : {getParentName('mom')}
            </div>
            <div
              className={`heritage__parents-type-item${
                HeritageData.selected === 'grandparents'
                  ? ' heritage__parents-type-item--active'
                  : ''
              }`}
              onClick={() =>
                SetHeritageData((prev) => ({
                  ...prev,
                  selected: 'grandparents'
                }))
              }
            >
              Grand-Parent : {getParentName('grandparents')}
            </div>
          </div>
        </div>

        <div className="heritage__slider">
          <div className="heritage__slider-arrow" onClick={() => navigate(-1)}>
            <FaAngleDoubleLeft />
          </div>

          <div className="heritage__slider-value">{getParentName()}</div>

          <div className="heritage__slider-arrow" onClick={() => navigate(1)}>
            <FaAngleDoubleRight />
          </div>
        </div>
      </div>

      <InputContainer
        label="Peau"
        type="range"
        value={HeritageData.skin.toString()}
        min={0}
        max={100}
        step={1}
        onChange={(val) => {
          SetHeritageData((prev) => ({ ...prev, skin: val }));
          onChange('skin_md_weight', 'skin');
        }}
        details
      />

      <InputContainer
        label="Ressemblance Parent"
        type="range"
        value={HeritageData.ressemblance.toString()}
        min={0}
        max={100}
        step={1}
        onChange={(val) => {
          SetHeritageData((prev) => ({ ...prev, ressemblance: val }));
          onChange('face_md_weight', 'ressemblance');
        }}
        details
      />

      <InputContainer
        label="Ressemblance Grand-Parent"
        type="range"
        value={HeritageData.ressemblance_g.toString()}
        min={0}
        max={100}
        step={1}
        onChange={(val) => {
          SetHeritageData((prev) => ({ ...prev, ressemblance_g: val }));
          onChange('face_g_weight', 'ressemblance_g');
        }}
        details
      />
    </motion.div>
  );
};

export default Heritage;

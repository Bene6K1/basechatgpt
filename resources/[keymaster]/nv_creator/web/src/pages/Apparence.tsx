import { useEffect } from 'react';
import { useAtom } from 'jotai';
import {
  rawComponentsAtom,
  componentsAtom,
  AppearanceCategoriesAtom,
  selectedAppearanceAtom,
  AppearanceNameMapping,
  colorFields,
  fivemColors,
  selectedCamAtom
} from '@/data';
import type { ComponentData } from '@/types';
import InputContainer from '@/components/InputContainer';
import PageHeader from '@/components/PageHeader';
import { motion } from 'framer-motion';
import { fetchNui } from '@/lib';
import { BsStars } from 'react-icons/bs';

const pageVariants = {
  initial: { opacity: 0, y: 20 },
  animate: { opacity: 1, y: 0, transition: { duration: 0.6, ease: 'easeOut' as const } },
  exit: { opacity: 0, y: -20, transition: { duration: 0.4, ease: 'easeIn' as const } }
};

const Apparence = () => {
  const [components] = useAtom(componentsAtom);
  const [, setRawComponents] = useAtom(rawComponentsAtom);
  const [selectedCategory, setSelectedCategory] = useAtom(
    selectedAppearanceAtom
  );
  const categories = AppearanceCategoriesAtom;

  useEffect(() => {
    if (!selectedCategory && categories.length > 0) {
      setSelectedCategory(categories[0]);
    }
  }, [selectedCategory, categories, setSelectedCategory]);

  const filteredComponents = components.filter((c: ComponentData) => {
    const names = AppearanceNameMapping[selectedCategory];
    if (names) return names.includes(c.name);
    return c.name.startsWith(`${selectedCategory}_`);
  });

  const handleChange = (name: string, newValue: number) => {
    setRawComponents((prev) =>
      prev.map((comp) =>
        comp.name === name ? { ...comp, value: newValue } : comp
      )
    );

    fetchNui('creator:onChange', {
      key: name,
      val: newValue
    });
  };

  const [, setSelectedCam] = useAtom(selectedCamAtom);
  useEffect(() => {
    setSelectedCam('head');
  }, []);

  return (
    <motion.div
      className="container"
      variants={pageVariants}
      initial="initial"
      animate="animate"
      exit="exit"
    >
      <PageHeader
        icon={<BsStars />}
        title="Apparence"
        subtitle="Style et caractéristiques"
      />
      <div className="apparence">
        <div className="apparence__categories">
          {categories.map((cat) => (
            <div
              key={cat}
              className={`apparence__categories-item${
                cat === selectedCategory
                  ? ' apparence__categories-item--active'
                  : ''
              }`}
              onClick={() => setSelectedCategory(cat)}
            >
              <img src={`../public/visage/${cat}.png`} style={{
                width: '80%',
                height: '80%',
                objectFit: 'cover'
              }} alt={cat} />
            </div>
          ))}
        </div>
        <div className="apparence__components">
          {filteredComponents.map((c: ComponentData) => (
            <div key={c.name}>
              <label className="apparence__components-label">{c.label}:</label>
              {colorFields.includes(c.name) ? (
                <div className="apparence__color-picker">
                  {fivemColors.map((hex, idx) => (
                    <button
                      key={hex}
                      className={`picker-swatch${c.value === idx ? ' selected' : ''}`}
                      style={{ backgroundColor: hex }}
                      onClick={() => handleChange(c.name, idx)}
                      aria-label={hex}
                    />
                  ))}
                </div>
              ) : (
                <InputContainer
                  label=""
                  type="range"
                  value={c.value.toString()}
                  min={c.min}
                  max={c.max}
                  step={1}
                  onChange={(val) => handleChange(c.name, Number(val))}
                  details
                />
              )}
            </div>
          ))}
        </div>
      </div>
    </motion.div>
  );
};

export default Apparence;

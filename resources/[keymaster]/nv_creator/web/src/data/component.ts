import { ComponentData } from '@/types';
import { atom } from 'jotai';

/**
 * Atom « raw » pour stocker les components reçus côté client
 */
export const rawComponentsAtom = atom<ComponentData[]>([]);

/**
 * Atom pour le mapping name → maxValue (tel que vous l’avez déjà)
 */
export const maxValuesAtom = atom<Record<string, number>>({});

/**
 * Atom dérivé qui injecte dans chaque component son max issu de maxValuesAtom
 */
export const componentsAtom = atom<ComponentData[]>((get) => {
  const comps = get(rawComponentsAtom);
  const maxs = get(maxValuesAtom);
  return comps.map((c) => ({
    ...c,
    max: maxs[c.name] ?? c.max
  }));
});

/**
 * Data pour l’onglet Visage
 */

export const FaceCategoriesAtom = [
  'nose',
  'cheeks',
  'lip',
  'jaw',
  'chin',
  'eye',
  'eyebrows'
];
export const selectedFaceAtom = atom<string>('nose');

/**
 * Data pour l’onglet Apparence
 */
export const AppearanceCategoriesAtom = [
  'hair',
  'beard',
  'makeup',
  'lipstick',
  'blush',
  'taches',
  'imperfection'
] as const;

export const AppearanceNameMapping: Record<string, string[]> = {
  taches: ['sun_1', 'sun_2', 'moles_1', 'moles_2'],
  imperfection: [
    'blemishes_1',
    'blemishes_2',
    'age_1',
    'age_2',
    'complexion_1',
    'complexion_2'
  ]
};

export const colorFields = [
  'hair_color_1',
  'hair_color_2',
  'beard_3',
  'beard_4',
  'eyebrows_3',
  'eyebrows_4',
  'makeup_3',
  'makeup_4',
  'lipstick_3',
  'lipstick_4',
];

export const selectedAppearanceAtom = atom<string>('hair');

export const fivemColors = [
  '#1c1f21','#272a2c','#312e2c','#35261c','#4b321f','#5c3b24','#6d4c35','#6b503b',
  '#765c45','#7f684e','#99815d','#a79369','#af9c70','#bba063','#d6b97b','#dac38e',
  '#9f7f59','#845039','#682b1f','#61120c','#640f0a','#7c140f','#a02e19','#b64b28',
  '#a2502f','#aa4e2b','#626262','#808080','#aaaaaa','#c5c5c5','#463955','#5a3f6b',
  '#763c76','#ed74e3','#eb4b93','#f299bc','#04959e','#025f86','#023974','#3fa16a',
  '#217c61','#185c55','#b6c034','#70a90b','#439d13','#dcb857','#e5b103','#e69102',
  '#f28831','#fb8057','#e28b58','#d1593c','#ce3120','#ad0903','#880302','#1f1814',
  '#291f19','#2e221b','#37291e','#2e2218','#231b15','#020202','#706c66','#9d7a50'
];
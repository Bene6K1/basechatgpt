import { atom } from 'jotai';

// Atom pour les tenues (4 tenues disponibles pour chaque genre)
export const ClothesListAtom = atom<number[]>([1, 2, 3, 4]);

export const ClothesSelectedAtom = atom<number>(-1);
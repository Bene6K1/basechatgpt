import { atom } from "jotai";

export const firstNameAtom = atom<string>('');
export const lastNameAtom = atom<string>('');
export const dateAtom = atom<string>('');
export const sizeAtom = atom<number>(140);
export const genderAtom = atom<string>('male');
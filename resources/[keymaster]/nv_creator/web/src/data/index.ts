import { atom } from "jotai";

export * from "@/data/identity";
export * from "@/data/heritage";
export * from "@/data/component";
export * from "@/data/clothes";

export const selectedCamAtom = atom<string>("full");
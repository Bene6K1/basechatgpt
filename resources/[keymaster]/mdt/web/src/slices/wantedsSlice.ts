import { createSlice } from '@reduxjs/toolkit';

type ranksType = {
  id: any;
  name: string;
};

type evidencesType = {
  id: any;
  image: any;
  name: string;
};

type wantedsType = {
  id: any;
  avatar: any;
  name: string;
  text: string;
  ranks: ranksType[];
  date: string;
  addedBy: string;
};

export interface WantedsState {
  wanteds: wantedsType[];
  wantedDetail: {
    id: number;
    avatar: any;
    name: string;
    madeBy: string;
    type: string;
    ranks: ranksType[];
    reportText: string;
    evidences: evidencesType[];
  };
  isFetched: number;
  isActiveEditingDeleted: boolean;
}

const initialState: WantedsState = {
  wanteds: [],
  wantedDetail: {
    id: 0,
    avatar: '',
    name: '',
    madeBy: '',
    type: '',
    ranks: [],
    reportText: '',
    evidences: [],
  },
  isFetched: 0,
  isActiveEditingDeleted: false,
};

export const wantedsSlice = createSlice({
  name: 'wanteds',
  initialState,
  reducers: {
    setWanteds: (state, action) => {
      state.wanteds = action.payload;
    },
    addWanteds: (state, action) => {
      state.wanteds.push(action.payload);
    },
    deleteWanteds: (state, id) => {
      state.wanteds = state.wanteds.filter((wanted) => wanted.id !== id.payload);
    },
    setWantedDetail: (state, action) => {
      state.wantedDetail = action.payload;
    },
    addRankToWantedDetail: (state, action) => {
      state.wantedDetail.ranks.push(action.payload);
    },
    deleteRankFromWantedDetail: (state, id) => {
      state.wantedDetail.ranks = state.wantedDetail.ranks.filter((rank) => rank.id !== id.payload);
    },
    addEvidenceToWantedDetail: (state, action) => {
      state.wantedDetail.evidences.push(action.payload);
    },
    deleteEvidenceFromWantedDetail: (state, id) => {
      state.wantedDetail.evidences = state.wantedDetail.evidences.filter(
        (evidence) => evidence.id !== id.payload,
      );
    },
    // for optimization.
    setIsFetched: (state, action) => {
      state.isFetched = action.payload;
    },
    setIsActiveEditingDeleted: (state, action) => {
      state.isActiveEditingDeleted = action.payload;
    },
  },
});

export const {
  setWanteds,
  addWanteds,
  deleteWanteds,
  setWantedDetail,
  addRankToWantedDetail,
  deleteRankFromWantedDetail,
  addEvidenceToWantedDetail,
  deleteEvidenceFromWantedDetail,
  setIsFetched,
  setIsActiveEditingDeleted,
} = wantedsSlice.actions;
export default wantedsSlice.reducer;

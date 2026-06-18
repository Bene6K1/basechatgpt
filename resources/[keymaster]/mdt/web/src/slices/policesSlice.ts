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

export interface PolicesState {
  policeDetail: {
    id: number;
    avatar: any;
    name: string;
    madeBy: string;
    ranks: ranksType[];
    reportText: string;
    evidences: evidencesType[];
  };
}

const initialState: PolicesState = {
  policeDetail: {
    id: 0,
    avatar: '',
    name: '',
    madeBy: '',
    ranks: [],
    reportText: '',
    evidences: [],
  },
};

export const policesSlice = createSlice({
  name: 'polices',
  initialState,
  reducers: {
    setPoliceDetail: (state, action) => {
      state.policeDetail = action.payload;
    },
    addRankToPoliceDetail: (state, action) => {
      state.policeDetail.ranks.push(action.payload);
    },
    deleteRankFromPoliceDetail: (state, id) => {
      state.policeDetail.ranks = state.policeDetail.ranks.filter((rank) => rank.id !== id.payload);
    },
    addEvidenceToPoliceDetail: (state, action) => {
      state.policeDetail.evidences.push(action.payload);
    },
    deleteEvidenceFromPoliceDetail: (state, id) => {
      state.policeDetail.evidences = state.policeDetail.evidences.filter(
        (evidence) => evidence.id !== id.payload,
      );
    },
  },
});

export const {
  setPoliceDetail,
  addRankToPoliceDetail,
  deleteRankFromPoliceDetail,
  addEvidenceToPoliceDetail,
  deleteEvidenceFromPoliceDetail,
} = policesSlice.actions;
export default policesSlice.reducer;

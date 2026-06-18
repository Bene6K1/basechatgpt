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

type finesType = {
  id: any;
  name: string;
};
export interface OffendersState {
  offenderDetail: {
    id: number;
    avatar: any;
    name: string;
    madeBy: string;
    ranks: ranksType[];
    reportText: string;
    evidences: evidencesType[];
    fines: finesType[];
  };
}

const initialState: OffendersState = {
  offenderDetail: {
    id: 0,
    avatar: '',
    name: '',
    madeBy: '',
    ranks: [],
    reportText: '',
    evidences: [],
    fines: [],
  },
};

export const offendersSlice = createSlice({
  name: 'offenders',
  initialState,
  reducers: {
    setOffenderDetail: (state, action) => {
      state.offenderDetail = action.payload;
    },
    addRankToOffenderDetail: (state, action) => {
      state.offenderDetail.ranks.push(action.payload);
    },
    deleteRankFromOffenderDetail: (state, id) => {
      state.offenderDetail.ranks = state.offenderDetail.ranks.filter(
        (rank) => rank.id !== id.payload,
      );
    },
    addEvidenceToOffenderDetail: (state, action) => {
      state.offenderDetail.evidences.push(action.payload);
    },
    deleteEvidenceFromOffenderDetail: (state, id) => {
      state.offenderDetail.evidences = state.offenderDetail.evidences.filter(
        (evidence) => evidence.id !== id.payload,
      );
    },
    addFinesToOffenderDetail: (state, action) => {
      state.offenderDetail.fines.push(action.payload);
    },
    deleteFinesFromOffenderDetail: (state, id) => {
      state.offenderDetail.fines = state.offenderDetail.fines.filter(
        (fine) => fine.id !== id.payload,
      );
    },
  },
});

export const {
  setOffenderDetail,
  addRankToOffenderDetail,
  deleteRankFromOffenderDetail,
  addEvidenceToOffenderDetail,
  deleteEvidenceFromOffenderDetail,
  addFinesToOffenderDetail,
  deleteFinesFromOffenderDetail,
} = offendersSlice.actions;
export default offendersSlice.reducer;

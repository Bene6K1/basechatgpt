import { createSlice } from '@reduxjs/toolkit';

type ranksType = {
  id: any;
  name: string;
};

type recordsType = {
  id: any;
  avatar: any;
  name: string;
  text: string;
  ranks: ranksType[];
  date: string;
  addedBy: string;
};

export interface RecordsState {
  records: recordsType[];
  recordDetail: any;
  isFetched: number;
}

const initialState: RecordsState = {
  records: [],
  recordDetail: {
    avatar: '',
    name: '',
    date: '',
    reportedPolice: '',
    reportText: '',
    ranks: [],
    evidences: [],
    offenders: [],
    polices: [],
  },
  isFetched: 0,
};

export const recordsSlice = createSlice({
  name: 'records',
  initialState,
  reducers: {
    setRecords: (state, action) => {
      state.records = action.payload;
    },
    addRecords: (state, action) => {
      state.records.push(action.payload);
    },
    addRecordsAsUnshift: (state, action) => {
      state.records.unshift(action.payload);
    },
    deleteRecords: (state, id) => {
      state.records = state.records.filter((record) => record.id !== id.payload);
    },
    setRecordDetail: (state, action) => {
      state.recordDetail = action.payload;
    },
    addRanksForRecord: (state, action) => {
      state.recordDetail.ranks.push(action.payload);
    },
    deleteRankForRecord: (state, id) => {
      state.recordDetail.ranks = state.recordDetail.ranks.filter(
        (rank: any) => rank.id !== id.payload,
      );
    },
    addEvidencesForRecord: (state, action) => {
      state.recordDetail.evidences.push(action.payload);
    },
    deleteEvidenceForRecord: (state, id) => {
      state.recordDetail.evidences = state.recordDetail.evidences.filter(
        (evidence: any) => evidence.id !== id.payload,
      );
    },
    addOffenders: (state, action) => {
      state.recordDetail.offenders.unshift(action.payload);
    },
    deleteOffender: (state, id) => {
      state.recordDetail.offenders = state.recordDetail.offenders.filter(
        (offender: any) => offender.id !== id.payload,
      );
    },
    addPolices: (state, action) => {
      state.recordDetail.polices.unshift(action.payload);
    },
    deletePolice: (state, id) => {
      state.recordDetail.polices = state.recordDetail.polices.filter((police: any) => {
        police.id !== id;
      });
    },
    // for optimization.
    setIsFetched: (state, action) => {
      state.isFetched = action.payload;
    },
  },
});

export const {
  setRecords,
  addRecords,
  addRecordsAsUnshift,
  deleteRecords,
  setRecordDetail,
  addRanksForRecord,
  deleteRankForRecord,
  addEvidencesForRecord,
  deleteEvidenceForRecord,
  addOffenders,
  deleteOffender,
  addPolices,
  deletePolice,
  setIsFetched,
} = recordsSlice.actions;
export default recordsSlice.reducer;

import { createSlice } from '@reduxjs/toolkit';

type finesType = {
  id: any;
  lastEdited: string;
  jailTimeType: string;
  fields: { text: any }[];
};

export interface FinesState {
  fines: finesType[];
  isFetched: number;
  isActiveEditingDeleted: boolean;
}

const initialState: FinesState = {
  fines: [],
  isFetched: 0,
  isActiveEditingDeleted: false,
};

export const finesSlice = createSlice({
  name: 'fines',
  initialState,
  reducers: {
    setFines: (state, action) => {
      state.fines = action.payload;
    },
    addFines: (state, action) => {
      state.fines.unshift(action.payload);
    },
    editFines: (state, action) => {
      state.fines = state.fines.map((fine) => {
        if (fine.id === action.payload.id) {
          fine.fields[0].text = action.payload.name;
          fine.fields[1].text = action.payload.jailTime;
          fine.fields[2].text = action.payload.money;
          fine.fields[3].text = action.payload.addedBy;
          fine.jailTimeType = action.payload.jailTimeType;
        }

        return fine;
      });
    },
    deleteFines: (state, id) => {
      state.fines = state.fines.filter((fine) => fine.id !== id.payload);
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
  setFines,
  addFines,
  editFines,
  deleteFines,
  setIsFetched,
  setIsActiveEditingDeleted,
} = finesSlice.actions;
export default finesSlice.reducer;

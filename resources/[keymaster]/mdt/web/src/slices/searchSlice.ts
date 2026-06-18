import { createSlice } from '@reduxjs/toolkit';

type ranksType = {
  id: any;
  name: string;
};

type labelsType = {
  name: string;
};

type licensesType = {
  name: string;
  status: 'success' | 'error';
};

type evidencesType = {
  id: any;
  image: any;
  name: string;
};

export interface SearchState {
  user: {
    avatar: any;
    name: string;
    text: string;
    isWanted: boolean;
    ranks: ranksType[];
    labels: labelsType[];
    licenses: licensesType[];
    evidences: evidencesType[];
  };
  vehicle: {
    image: any;
    carName: string;
    numberPlate: string;
    ownerName: string;
    color: string;
  };
}

const initialState: SearchState = {
  user: {
    avatar: '',
    name: '',
    text: '',
    isWanted: false,
    ranks: [],
    labels: [],
    licenses: [],
    evidences: [],
  },
  vehicle: {
    image: '',
    carName: '',
    numberPlate: '',
    ownerName: '',
    color: '',
  },
};

export const searchSlice = createSlice({
  name: 'search',
  initialState,
  reducers: {
    setUser: (state, action) => {
      state.user = action.payload;
    },
    changeAvatarFromUser: (state, action) => {
      state.user.avatar = action.payload;
    },
    addRankToUser: (state, action) => {
      state.user.ranks.push(action.payload);
    },
    deleteRankFromUser: (state, id) => {
      state.user.ranks = state.user.ranks.filter((rank) => rank.id !== id.payload);
    },
    addEvidenceToUser: (state, action) => {
      state.user.evidences.push(action.payload);
    },
    deleteEvidenceFromUser: (state, id) => {
      state.user.evidences = state.user.evidences.filter((evidence) => evidence.id !== id.payload);
    },
    setVehicle: (state, action) => {
      state.vehicle = action.payload;
    },
    changeImageFromVehicle: (state, action) => {
      state.vehicle.image = action.payload;
    },
  },
});

export const {
  setUser,
  changeAvatarFromUser,
  addRankToUser,
  deleteRankFromUser,
  addEvidenceToUser,
  deleteEvidenceFromUser,
  setVehicle,
  changeImageFromVehicle,
} = searchSlice.actions;
export default searchSlice.reducer;

import { createSlice } from '@reduxjs/toolkit';

type ranksType = {
  id: any;
  name: string;
};

type banListType = {
  id: any;
  avatar: any;
  name: string;
  text: string;
  ranks: ranksType[];
  date: string;
  addedBy: string;
};

export interface DepartmentState {
  department: {
    image: any;
    name: string;
    totalBans: number;
    totalPersonal: string;
    location: string;
    description: any;
  };
  banList: banListType[];
  isFetchedDepartment: number;
  isFetchedBanList: number;
}

const initialState: DepartmentState = {
  department: {
    image: '',
    name: '',
    totalBans: 0,
    totalPersonal: '',
    location: '',
    description: '',
  },
  banList: [],
  isFetchedDepartment: 0,
  isFetchedBanList: 0,
};

export const departmentSlice = createSlice({
  name: 'department',
  initialState,
  reducers: {
    setDepartment: (state, action) => {
      state.department = action.payload;
    },
    setBanList: (state, action) => {
      state.banList = action.payload;
    },
    addBanList: (state, action) => {
      state.banList.unshift(action.payload);
    },
    deleteBanList: (state, id) => {
      state.banList = state.banList.filter((item) => item.id !== id.payload);
    },
    // for optimization.
    setIsFetchedDepartment: (state, action) => {
      state.isFetchedDepartment = action.payload;
    },
    setIsFetchedBanList: (state, action) => {
      state.isFetchedBanList = action.payload;
    },
  },
});

export const {
  setDepartment,
  setBanList,
  addBanList,
  deleteBanList,
  setIsFetchedDepartment,
  setIsFetchedBanList,
} = departmentSlice.actions;
export default departmentSlice.reducer;

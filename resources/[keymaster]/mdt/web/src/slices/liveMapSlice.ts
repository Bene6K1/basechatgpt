import { createSlice } from '@reduxjs/toolkit';

type activePolicesType = {
  id: any;
  position: any;
  avatar: string;
  name: string;
  rank: string;
  circleColor: 'blue' | 'red' | 'orange' | 'purple';
  isMe: boolean;
};

type dispatchsType = {
  id: number;
  name: string;
  position: any;
  texts: { id: number; text: string }[];
  circleColor: 'orange' | 'red' | 'blue' | 'purple' | 'white';
};

export interface SearchState {
  activePolices: activePolicesType[];
  dispatchs: dispatchsType[];
}

const initialState: SearchState = {
  activePolices: [],
  dispatchs: [],
};

export const liveMapSlice = createSlice({
  name: 'liveMap',
  initialState,
  reducers: {
    setActivePolices: (state, action) => {
      state.activePolices = action.payload;
    },
    setDispatchs: (state, action) => {
      state.dispatchs = action.payload;
    },
    deleteDispatch: (state, id) => {
      state.dispatchs = state.dispatchs.filter((dispatch) => dispatch.id !== id.payload);
    },
  },
});

export const { setActivePolices, setDispatchs, deleteDispatch } = liveMapSlice.actions;
export default liveMapSlice.reducer;

import { createSlice } from '@reduxjs/toolkit';

type camerasType = {
  id: any;
  image: string;
  title: string;
};

export interface CamerasState {
  cameras: camerasType[];
  isFetchedCameras: number;
}

const initialState: CamerasState = {
  cameras: [],
  isFetchedCameras: 0,
};

export const camerasSlice = createSlice({
  name: 'cameras',
  initialState,
  reducers: {
    setCameras: (state, action) => {
      state.cameras = action.payload;
    },
    setIsFetchedCameras: (state, action) => {
      state.isFetchedCameras = action.payload;
    },
  },
});

export const { setCameras, setIsFetchedCameras } = camerasSlice.actions;
export default camerasSlice.reducer;

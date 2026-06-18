import { configureStore } from '@reduxjs/toolkit';

import globalSlice from '@/slices/globalSlice';
import recordsSlice from '@/slices/recordsSlice';
import wantedsSlice from '@/slices/wantedsSlice';
import offendersSlice from '@/slices/offendersSlice';
import policesSlice from '@/slices/policesSlice';
import finesSlice from '@/slices/finesSlice';
import departmentSlice from '@/slices/departmentSlice';
import searchSlice from '@/slices/searchSlice';
import camerasSlice from '@/slices/camerasSlice';
import liveMapSlice from '@/slices/liveMapSlice';

export const store = configureStore({
  reducer: {
    globalSlice,
    recordsSlice,
    wantedsSlice,
    offendersSlice,
    policesSlice,
    finesSlice,
    departmentSlice,
    searchSlice,
    camerasSlice,
    liveMapSlice,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

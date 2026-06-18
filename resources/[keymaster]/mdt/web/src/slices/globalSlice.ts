import { createSlice } from '@reduxjs/toolkit';

export interface GlobalState {
  editedWantedId: any;
  editedOffenderId: any;
  editedFineId: any;
  activeModal: string;
  imageModalData: {
    active: boolean;
    image: string;
    title: string;
  };
  info: {
    policeAvatar: any;
    policeName: string;
    policeRank: string;
    onlinePolice: number;
    dailyRecordsCount: number;
    dailyWantedsCount: number;
    totalRecordsCount: number;
    totalWantedsCount: number;
  };
  isFetchedInfo: number;
  messages: { id: number; title: string; text: string }[];
  isFetchedMessages: number;
  notifications: { id: number; title: string; text: string; date: string; type: string }[];
  isFetchedNotifications: number;
  usersForSelect: {
    avatar: any;
    value: number;
    label: string;
    isPolice: boolean;
  }[];
  isFetchedUsersForSelect: number;
  ranksForSelect: { value: number; label: string }[];
  isFetchedRanksForSelect: number;
  vehiclesForSelect: {
    avatar: any;
    value: string;
    label: string;
  }[];
  isFetchedVehiclesForSelect: number;
  onDutyList: {
    id: number;
    avatar: any;
    name: string;
    text: string;
    level: string;
    location: string;
    rankInfo: string;
    dutyTimes: string;
    appointementDate: string;
    marker: { id: number; position: any };
  }[];
  isFetchedOnDutyList: number;
  hotWantedList: {
    id: number;
    avatar: any;
    avatarCircle: string;
    name: string;
    text: string;
    date: string;
    assignedPolice: string;
  }[];
  isFetchedHotWantedList: number;
  locales: {
    pageDescription: {
      none: string;
      homepage: string;
      records: string;
      recordsDetail: string;
      offenderDetail: string;
      policeDetail: string;
      wanteds: string;
      fines: string;
      department: string;
      cameras: string;
      liveMap: string;
    };
  };
  isFetchedLocales: number;
  permissions: {
    addMessage: string[];
    addFines: string[];
    editFines: string[];
  };
  isFetchedPermissions: number;
}

const initialState: GlobalState = {
  editedWantedId: 0,
  editedOffenderId: 0,
  editedFineId: 0,
  activeModal: '',
  imageModalData: {
    active: false,
    image: '',
    title: '',
  },
  info: {
    policeAvatar: '',
    policeName: '',
    policeRank: '',
    onlinePolice: 0,
    dailyRecordsCount: 0,
    dailyWantedsCount: 0,
    totalRecordsCount: 0,
    totalWantedsCount: 0,
  },
  isFetchedInfo: 0,
  messages: [],
  isFetchedMessages: 0,
  notifications: [],
  isFetchedNotifications: 0,
  usersForSelect: [],
  isFetchedUsersForSelect: 0,
  ranksForSelect: [],
  isFetchedRanksForSelect: 0,
  vehiclesForSelect: [],
  isFetchedVehiclesForSelect: 0,
  onDutyList: [],
  isFetchedOnDutyList: 0,
  hotWantedList: [],
  isFetchedHotWantedList: 0,
  locales: {
    pageDescription: {
      none: '',
      homepage: '',
      records: '',
      recordsDetail: '',
      offenderDetail: '',
      policeDetail: '',
      wanteds: '',
      fines: '',
      department: '',
      cameras: '',
      liveMap: '',
    },
  },
  isFetchedLocales: 0,
  permissions: {
    addMessage: [],
    addFines: [],
    editFines: [],
  },
  isFetchedPermissions: 0,
};

export const globalSlice = createSlice({
  name: 'global',
  initialState,
  reducers: {
    setEditedWantedId: (state, id) => {
      state.editedWantedId = id.payload;
    },
    setEditedOffenderId: (state, id) => {
      state.editedOffenderId = id.payload;
    },
    setEditedFineId: (state, id) => {
      state.editedFineId = id.payload;
    },
    setActiveModal: (state, type) => {
      state.activeModal = type.payload;
    },
    setImageModalData: (state, action) => {
      state.imageModalData = action.payload;
    },
    setInfo: (state, action) => {
      state.info = action.payload;
    },
    setIsFetchedInfo: (state, action) => {
      state.isFetchedInfo = action.payload;
    },
    setMessages: (state, action) => {
      state.messages = action.payload;
    },
    addMessage: (state, action) => {
      state.messages.unshift(action.payload);
    },
    setIsFetchedMessages: (state, action) => {
      state.isFetchedMessages = action.payload;
    },
    setNotifications: (state, action) => {
      state.notifications = action.payload;
    },
    addNotifications: (state, action) => {
      state.notifications.unshift(action.payload);
    },
    setIsFetchedNotifications: (state, action) => {
      state.isFetchedNotifications = action.payload;
    },
    setUsersForSelect: (state, action) => {
      state.usersForSelect = action.payload;
    },
    setIsFetchedUsersForSelect: (state, action) => {
      state.isFetchedUsersForSelect = action.payload;
    },
    setRanksForSelect: (state, action) => {
      state.ranksForSelect = action.payload;
    },
    setIsFetchedRanksForSelect: (state, action) => {
      state.isFetchedRanksForSelect = action.payload;
    },
    setVehiclesForSelect: (state, action) => {
      state.vehiclesForSelect = action.payload;
    },
    setIsFetchedVehiclesForSelect: (state, action) => {
      state.isFetchedVehiclesForSelect = action.payload;
    },
    setOnDutyList: (state, action) => {
      state.onDutyList = action.payload;
    },
    setIsFetchedOnDutyList: (state, action) => {
      state.isFetchedOnDutyList = action.payload;
    },
    setHotWantedList: (state, action) => {
      state.hotWantedList = action.payload;
    },
    setIsFetchedHotWantedList: (state, action) => {
      state.isFetchedHotWantedList = action.payload;
    },
    setLocales: (state, action) => {
      state.locales = action.payload;
    },
    setIsFetchedLocales: (state, action) => {
      state.isFetchedLocales = action.payload;
    },
    setPermissions: (state, action) => {
      state.permissions = action.payload;
    },
    setIsFetchedPermissions: (state, action) => {
      state.isFetchedPermissions = action.payload;
    },
  },
});

export const {
  setEditedWantedId,
  setEditedOffenderId,
  setEditedFineId,
  setActiveModal,
  setImageModalData,
  setInfo,
  setIsFetchedInfo,
  setMessages,
  addMessage,
  setIsFetchedMessages,
  setNotifications,
  addNotifications,
  setIsFetchedNotifications,
  setUsersForSelect,
  setIsFetchedUsersForSelect,
  setRanksForSelect,
  setIsFetchedRanksForSelect,
  setVehiclesForSelect,
  setIsFetchedVehiclesForSelect,
  setOnDutyList,
  setIsFetchedOnDutyList,
  setHotWantedList,
  setIsFetchedHotWantedList,
  setLocales,
  setIsFetchedLocales,
  setPermissions,
  setIsFetchedPermissions,
} = globalSlice.actions;
export default globalSlice.reducer;

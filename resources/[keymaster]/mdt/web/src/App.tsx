import { useState, useEffect } from 'react';
import { useRoutes } from 'react-router-dom';
import { routes } from './routes';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import {
  setInfo,
  setIsFetchedInfo,
  setMessages,
  setIsFetchedMessages,
  setNotifications,
  setIsFetchedNotifications,
  setUsersForSelect,
  setIsFetchedUsersForSelect,
  setRanksForSelect,
  setIsFetchedRanksForSelect,
  setVehiclesForSelect,
  setIsFetchedVehiclesForSelect,
  setIsFetchedOnDutyList,
  setIsFetchedHotWantedList,
  setPermissions,
  setIsFetchedPermissions,
} from '@/slices/globalSlice';
import { setIsFetched as setIsFetchedRecords } from '@/slices/recordsSlice';
import { setIsFetched as setIsFetchedWanteds } from '@/slices/wantedsSlice';
import { setIsFetched as setIsFetchedFines } from '@/slices/finesSlice';
import { setIsFetchedDepartment, setIsFetchedBanList } from '@/slices/departmentSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import profileImage from '@/assets/images/sidebar-profile.png';
import carImage from '@/assets/images/car-image.png';

const App = () => {
  const {
    isFetchedInfo,
    isFetchedMessages,
    isFetchedNotifications,
    isFetchedUsersForSelect,
    isFetchedRanksForSelect,
    isFetchedVehiclesForSelect,
    isFetchedPermissions,
  } = useSelector((state: RootState) => state.globalSlice);
  const dispatch = useDispatch();
  const [hide, setHide] = useState<boolean>(false);

  useEffect(() => {
    if (isFetchedInfo === 0) {
      fetchNui('getInfo', '')
        .then((res) => {
          if (res.success) {
            dispatch(setInfo(res.data));
            dispatch(setIsFetchedInfo(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setInfo({
                policeAvatar: profileImage,
                policeName: 'John Doe',
                policeRank: 'Officer',
                onlinePolice: 12,
                dailyRecordsCount: 15,
                dailyWantedsCount: 8,
                totalRecordsCount: 25,
                totalWantedsCount: 5,
              }),
            );
            dispatch(setIsFetchedInfo(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }

    if (isFetchedMessages === 0) {
      fetchNui('getMessages', '')
        .then((res) => {
          if (res.success) {
            dispatch(setMessages(res.data));
            dispatch(setIsFetchedMessages(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setMessages([
                {
                  id: 1,
                  title: 'New Message!',
                  text: 'Write the text of a sample message.',
                },
                {
                  id: 2,
                  title: 'New Message!',
                  text: 'Write the text of a sample message.',
                },
                {
                  id: 3,
                  title: 'New Message!',
                  text: 'Write the text of a sample message.',
                },
              ]),
            );
            dispatch(setIsFetchedMessages(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }

    if (isFetchedNotifications === 0) {
      fetchNui('getNotifications', '')
        .then((res) => {
          if (res.success) {
            dispatch(setNotifications(res.data));
            dispatch(setIsFetchedNotifications(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setNotifications([
                {
                  id: 1,
                  title: 'New Records Added',
                  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  date: '1 week ago',
                  type: 'added',
                },
                {
                  id: 2,
                  title: 'New Wanteds Added',
                  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  date: '4 days ago',
                  type: 'user-added',
                },
                {
                  id: 3,
                  title: 'No: #1 Records Changed',
                  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  date: '1 day ago',
                  type: 'changed',
                },
                {
                  id: 4,
                  title: 'No: #2 Records Deleted',
                  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  date: '2 hours ago',
                  type: 'deleted',
                },
              ]),
            );
            dispatch(setIsFetchedNotifications(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }

    if (isFetchedUsersForSelect === 0) {
      fetchNui('getUsersForSelect', '')
        .then((res) => {
          if (res.success) {
            dispatch(setUsersForSelect(res.data));
            dispatch(setIsFetchedUsersForSelect(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setUsersForSelect([
                {
                  value: 1, // It gonna be user id.
                  avatar: profileImage,
                  label: 'Yusuf Bozacı',
                  isPolice: false,
                },
                {
                  value: 2, // It gonna be user id.
                  avatar: profileImage,
                  label: 'Test Bozacı',
                  isPolice: true,
                },
                {
                  value: 3, // It gonna be user id.
                  avatar: profileImage,
                  label: 'Bozcı Test',
                  isPolice: true,
                },
              ]),
            );
            dispatch(setIsFetchedUsersForSelect(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }

    if (isFetchedRanksForSelect === 0) {
      fetchNui('getRanksForSelect', '')
        .then((res) => {
          if (res.success) {
            dispatch(setRanksForSelect(res.data));
            dispatch(setIsFetchedRanksForSelect(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setRanksForSelect([
                {
                  value: '1',
                  label: 'Suspect',
                },
                {
                  value: '2',
                  label: 'Murderer',
                },
                {
                  value: '3',
                  label: 'Smuggling',
                },
              ]),
            );
            dispatch(setIsFetchedRanksForSelect(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }

    if (isFetchedVehiclesForSelect === 0) {
      fetchNui('getVehiclesForSelect', '')
        .then((res) => {
          if (res.success) {
            dispatch(setVehiclesForSelect(res.data));
            dispatch(setIsFetchedVehiclesForSelect(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setVehiclesForSelect([
                {
                  value: 'ABCD1234', // It gonna be vehicle plate.
                  avatar: carImage,
                  label: 'ABCD1234',
                },
                {
                  value: '13ABCD1234', // It gonna be vehicle plate.
                  avatar: carImage,
                  label: '13ABCD1234',
                },
                {
                  value: '51ABCD1234', // It gonna be vehicle plate.
                  avatar: carImage,
                  label: '51ABCD1234',
                },
              ]),
            );
            dispatch(setIsFetchedVehiclesForSelect(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }

    if (isFetchedPermissions === 0) {
      fetchNui('getPermissions', '')
        .then((res) => {
          if (res.success) {
            dispatch(setPermissions(res.data));
            dispatch(setIsFetchedPermissions(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setPermissions({
                addMessage: ['chief', 'officer'], // Only these person can add message.
                addFines: ['chief', 'officer'], // Only these person can add fines.
                editFines: ['chief', 'officer'], // Only these person can edit fines.
              }),
            );
            dispatch(setIsFetchedPermissions(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }
  }, [hide]);

  useEffect(() => {
    // Reset all is fetched values when closed the mdt.
    const keyHandler = (e: KeyboardEvent) => {
      if (['Escape'].includes(e.code)) {
        dispatch(setIsFetchedInfo(0));
        dispatch(setIsFetchedUsersForSelect(0));
        dispatch(setIsFetchedRanksForSelect(0));
        dispatch(setIsFetchedOnDutyList(0));
        dispatch(setIsFetchedHotWantedList(0));
        dispatch(setIsFetchedRecords(0));
        dispatch(setIsFetchedWanteds(0));
        dispatch(setIsFetchedFines(0));
        dispatch(setIsFetchedDepartment(0));
        dispatch(setIsFetchedBanList(0));
        setHide(true);
      }
    };

    window.addEventListener('keydown', keyHandler);
    return () => window.removeEventListener('keydown', keyHandler);
  }, []);

  return useRoutes(routes);
};

export default App;

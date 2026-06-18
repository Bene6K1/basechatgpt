import React, { useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import {
  setOnDutyList,
  setIsFetchedOnDutyList,
  setHotWantedList,
  setIsFetchedHotWantedList,
} from '@/slices/globalSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import GeneralInformation from '@/components/GeneralInformation';
import OnDutyList from '@/components/OnDutyList';
import HotWantedList from '@/components/HotWantedList';

import profileImage from '@/assets/images/on-duty-profile-image.png';
import profileImageTwo from '@/assets/images/sidebar-profile.png';

const Home = () => {
  const { isFetchedOnDutyList, isFetchedHotWantedList } = useSelector(
    (state: RootState) => state.globalSlice,
  );
  const dispatch = useDispatch();

  useEffect(() => {
    if (isFetchedOnDutyList === 0) {
      fetchNui('getOnDutyList', '')
        .then((res) => {
          if (res.success) {
            dispatch(setOnDutyList(res.data));
            dispatch(setIsFetchedOnDutyList(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setOnDutyList([
                {
                  id: 1,
                  avatar: profileImage,
                  name: 'Yordi',
                  text: 'Online',
                  level: 'Beginner Level',
                  location: 'Gas Station',
                  rankInfo: 'Superintendent',
                  dutyTimes: 'Since 20 days',
                  appointementDate: '12.04.2023 | 23:41',
                  marker: {
                    id: 1,
                    position: [0, 0],
                    avatar: profileImage,
                    name: 'Yordi',
                    rank: 'Superintendent',
                  },
                },
                {
                  id: 2,
                  avatar: profileImageTwo,
                  name: 'Fizzfau',
                  text: 'Online',
                  level: 'Superintendent',
                  location: 'Gas Station',
                  rankInfo: 'Superintendent',
                  dutyTimes: 'Since 20 days',
                  appointementDate: '12.04.2023 | 23:41',
                  marker: {
                    id: 2,
                    position: [1000, -1000],
                    avatar: profileImageTwo,
                    name: 'Fizzfau',
                    rank: 'Superintendent',
                  },
                },
                {
                  id: 3,
                  avatar: profileImage,
                  name: 'nitroS',
                  text: 'Online',
                  level: 'Beginner Level',
                  location: 'Gas Station',
                  rankInfo: 'Superintendent',
                  dutyTimes: 'Since 20 days',
                  appointementDate: '12.04.2023 | 23:41',
                  marker: {
                    id: 3,
                    position: [2500, -2500],
                    avatar: profileImage,
                    name: 'nitroS',
                    rank: 'Superintendent',
                  },
                },
              ]),
            );
            dispatch(setIsFetchedOnDutyList(1));
          } else {
            errorNotify('Error ocurred while fetched data.');
          }
        });
    }

    if (isFetchedHotWantedList === 0) {
      fetchNui('getHotWantedList', '')
        .then((res) => {
          if (res.success) {
            dispatch(setHotWantedList(res.data));
            dispatch(setIsFetchedHotWantedList(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setHotWantedList([
                {
                  id: 1,
                  avatar: profileImage,
                  avatarCircle: 'blue',
                  name: 'Yordi',
                  text: 'Murderer',
                  date: '12.04.2023',
                  assignedPolice: 'nitroS',
                },
                {
                  id: 2,
                  avatar: profileImage,
                  avatarCircle: 'pink',
                  name: 'Yordi',
                  text: 'Smuggling',
                  date: '12.04.2023',
                  assignedPolice: 'nitroS',
                },
                {
                  id: 3,
                  avatar: profileImage,
                  avatarCircle: 'yellow',
                  name: 'Yordi',
                  text: 'Murderer',
                  date: '12.04.2023',
                  assignedPolice: 'nitroS',
                },
                {
                  id: 3,
                  avatar: profileImage,
                  avatarCircle: 'yellow',
                  name: 'Yordi',
                  text: 'Murderer',
                  date: '12.04.2023',
                  assignedPolice: 'nitroS',
                },
                {
                  id: 3,
                  avatar: profileImage,
                  avatarCircle: 'yellow',
                  name: 'Yordi',
                  text: 'Murderer',
                  date: '12.04.2023',
                  assignedPolice: 'nitroS',
                },
                {
                  id: 3,
                  avatar: profileImage,
                  avatarCircle: 'yellow',
                  name: 'Yordi',
                  text: 'Murderer',
                  date: '12.04.2023',
                  assignedPolice: 'nitroS',
                },
                {
                  id: 3,
                  avatar: profileImage,
                  avatarCircle: 'yellow',
                  name: 'Yordi',
                  text: 'Murderer',
                  date: '12.04.2023',
                  assignedPolice: 'nitroS',
                },
              ]),
            );
            dispatch(setIsFetchedHotWantedList(1));
          } else {
            errorNotify('Error ocurred while fetched data.');
          }
        });
    }
  }, []);

  return (
    <>
      <div className="home">
        <div className="row g-4">
          <div className="col-lg-12 col-xl-6">
            <GeneralInformation />
            <OnDutyList />
          </div>

          <div className="col-lg-12 col-xl-6">
            <HotWantedList />
          </div>
        </div>
      </div>
    </>
  );
};

export default Home;

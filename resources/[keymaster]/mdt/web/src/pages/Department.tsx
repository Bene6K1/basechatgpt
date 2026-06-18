import React, { useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import {
  setDepartment,
  setIsFetchedDepartment,
  setBanList,
  setIsFetchedBanList,
} from '@/slices/departmentSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import DepartmentDetail from '@/components/DepartmentDetail';
import DepartmentBanList from '@/components/DepartmentBanList';

import profileImage from '@/assets/images/sidebar-profile.png';
import departmentImage from '@/assets/images/department-image.png';

const Department = () => {
  const { isFetchedDepartment, isFetchedBanList } = useSelector(
    (state: RootState) => state.departmentSlice,
  );
  const dispatch = useDispatch();

  useEffect(() => {
    if (isFetchedDepartment === 0) {
      fetchNui('getDepartment', '')
        .then((res) => {
          if (res.success) {
            dispatch(setDepartment(res.data));
            dispatch(setIsFetchedDepartment(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setDepartment({
                image: departmentImage,
                name: 'Department Name',
                totalBans: 5,
                totalPersonal: '850/1000',
                location: '03506 Grover Ranch East Marlee 83511-7455',
                description: '',
              }),
            );
            dispatch(setIsFetchedDepartment(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }
  }, []);

  useEffect(() => {
    if (isFetchedBanList === 0) {
      fetchNui('getBanList', '')
        .then((res) => {
          if (res.success) {
            dispatch(setBanList(res.data));
            dispatch(setIsFetchedBanList(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setBanList([
                {
                  id: 1,
                  avatar: profileImage,
                  name: 'Yordi',
                  text: '#1',
                  ranks: [
                    {
                      id: 0,
                      name: 'Beginner',
                    },
                  ],
                  date: '09.08.2023',
                  addedBy: 'Yordi',
                },
                {
                  id: 2,
                  avatar: profileImage,
                  name: 'nitroS',
                  text: '#2',
                  ranks: [
                    {
                      id: 0,
                      name: 'Beginner',
                    },
                  ],
                  date: '09.08.2023',
                  addedBy: 'Yordi',
                },
                {
                  id: 3,
                  avatar: profileImage,
                  name: 'Fizzfau',
                  text: '#3',
                  ranks: [
                    {
                      id: 0,
                      name: 'Beginner',
                    },
                  ],
                  date: '09.08.2023',
                  addedBy: 'Yordi',
                },
              ]),
            );
            dispatch(setIsFetchedBanList(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }
  }, []);

  return (
    <>
      <div className="department">
        <div className="row g-4">
          <div className="col-lg-12 col-xl-6">
            <DepartmentDetail />
          </div>

          <div className="col-lg-12 col-xl-6">
            <DepartmentBanList />
          </div>
        </div>
      </div>
    </>
  );
};

export default Department;

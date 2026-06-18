import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setUser } from '@/slices/searchSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import UserInformation from '@/components/UserInformation';

import profileImage from '@/assets/images/recording-details-profile-image.png';
import evidenceExampleImage from '@/assets/images/evidence-example-image.webp';

const SearchUsers = () => {
  const user = useSelector((state: RootState) => state.searchSlice.user);
  const { uid } = useParams();
  const dispatch = useDispatch();

  useEffect(() => {
    fetchNui('getUserInfo', {
      uid,
    })
      .then((res) => {
        if (res.success) {
          dispatch(setUser(res.data));
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(
            setUser({
              avatar: profileImage,
              name: 'Yordi',
              text: '#1',
              isWanted: true,
              ranks: [
                {
                  id: 1,
                  name: 'Suspect',
                },
                {
                  id: 2,
                  name: 'Murderer',
                },
              ],
              labels: [
                {
                  name: 'Car 1',
                },
                {
                  name: 'Car 2',
                },
                {
                  name: 'License',
                },
              ],
              licenses: [
                {
                  name: 'Vehicle License',
                  status: 'success',
                },
                {
                  name: 'Weapon License',
                  status: 'error',
                },
              ],
              evidences: [
                {
                  id: 1,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
                {
                  id: 2,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
                {
                  id: 3,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
              ],
            }),
          );
        } else {
          errorNotify('Error occurred while fetched data.');
        }
      });
  }, []);

  return (
    <>
      <div className="search-users">
        <div className="row g-4">
          <div className="col-lg-12 col-xl-6">
            <UserInformation data={user} />
          </div>
        </div>
      </div>
    </>
  );
};

export default SearchUsers;

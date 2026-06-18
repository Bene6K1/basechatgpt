import React, { useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setWanteds, setIsFetched } from '@/slices/wantedsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import WantedList from '@/components/WantedList';
import WantedDetail from '@/components/WantedDetail';

import profileImage from '@/assets/images/sidebar-profile.png';

const Wanteds = () => {
  const editedWantedId =
    useSelector((state: RootState) => state.globalSlice.editedWantedId) || null;
  const isFetched = useSelector((state: RootState) => state.wantedsSlice.isFetched);
  const dispatch = useDispatch();

  useEffect(() => {
    if (isFetched === 0) {
      fetchNui('getWanteds', '')
        .then((res) => {
          if (res.success) {
            dispatch(setWanteds(res.data));
            dispatch(setIsFetched(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setWanteds([
                {
                  id: 1,
                  avatar: profileImage,
                  name: 'Yordi',
                  text: '#1',
                  ranks: [
                    {
                      id: 1,
                      name: 'Murderer',
                    },
                    {
                      id: 2,
                      name: 'Suspect',
                    },
                    {
                      id: 3,
                      name: 'Smuggling',
                    },
                  ],
                  date: '11.04.2023',
                  addedBy: 'nitroS',
                },
                {
                  id: 2,
                  avatar: profileImage,
                  name: 'Fizzfau',
                  text: '#2',
                  ranks: [
                    {
                      id: 1,
                      name: 'Murderer',
                    },
                    {
                      id: 2,
                      name: 'Suspect',
                    },
                    {
                      id: 3,
                      name: 'Smuggling',
                    },
                  ],
                  date: '11.04.2023',
                  addedBy: 'nitroS',
                },
                {
                  id: 3,
                  avatar: profileImage,
                  name: 'nitroS',
                  text: '#3',
                  ranks: [
                    {
                      id: 1,
                      name: 'Murderer',
                    },
                    {
                      id: 2,
                      name: 'Suspect',
                    },
                    {
                      id: 3,
                      name: 'Smuggling',
                    },
                  ],
                  date: '11.04.2023',
                  addedBy: 'nitroS',
                },
              ]),
            );
            dispatch(setIsFetched(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }
  }, []);

  return (
    <>
      <div className="wanteds">
        <div className="row g-4">
          <div className="col-lg-12 col-xl-7">
            <WantedList />
          </div>

          {editedWantedId && (
            <div className="col-lg-12 col-xl-5">
              <WantedDetail />
            </div>
          )}
        </div>
      </div>
    </>
  );
};

export default Wanteds;

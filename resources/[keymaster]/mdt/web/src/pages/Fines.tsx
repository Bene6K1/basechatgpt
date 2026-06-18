import React, { useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setFines, setIsFetched } from '@/slices/finesSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import FinesList from '@/components/FinesList';
import EditFines from '@/components/EditFines';

const Fines = () => {
  const editedFineId = useSelector((state: RootState) => state.globalSlice.editedFineId) || null;
  const isFetched = useSelector((state: RootState) => state.finesSlice.isFetched);
  const dispatch = useDispatch();

  useEffect(() => {
    if (isFetched === 0) {
      fetchNui('getFines', '')
        .then((res) => {
          if (res.success) {
            dispatch(setFines(res.data));
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
              setFines([
                {
                  id: 1,
                  lastEdited: 'Last edited 1 hours ago by Yordi',
                  jailTimeType: 'Days',
                  fields: [
                    {
                      text: 'MURDER-CAPITAL OFFENSE (1)',
                    },
                    {
                      text: '1 Days',
                    },
                    {
                      text: '$20,000',
                    },
                    {
                      text: 'nitroS',
                    },
                  ],
                },
                {
                  id: 2,
                  lastEdited: 'Last edited 1 hours ago by nitroS',
                  jailTimeType: 'Weeks',
                  fields: [
                    {
                      text: 'MURDER-CAPITAL OFFENSE (2)',
                    },
                    {
                      text: '1 Weeks',
                    },
                    {
                      text: '$20,000',
                    },
                    {
                      text: 'nitroS',
                    },
                  ],
                },
                {
                  id: 3,
                  lastEdited: 'Last edited 1 hours ago by Fizzfau',
                  jailTimeType: 'Years',
                  fields: [
                    {
                      text: 'MURDER-CAPITAL OFFENSE (3)',
                    },
                    {
                      text: '2 Years',
                    },
                    {
                      text: '$20,000',
                    },
                    {
                      text: 'nitroS',
                    },
                  ],
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
      <div className="fines">
        <div className="row g-4">
          <div className="col-lg-12 col-xl-7">
            <FinesList />
          </div>

          {editedFineId && (
            <div className="col-lg-12 col-xl-5">
              <EditFines />
            </div>
          )}
        </div>
      </div>
    </>
  );
};

export default Fines;

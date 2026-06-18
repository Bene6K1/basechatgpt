import React, { useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setCameras, setIsFetchedCameras } from '@/slices/camerasSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Cameras from '@/components/Cameras';
import camerasImage from '@/assets/images/cameras-image.jpg';

const CamerasPage = () => {
  const { isFetchedCameras } = useSelector((state: RootState) => state.camerasSlice);
  const dispatch = useDispatch();

  useEffect(() => {
    if (isFetchedCameras === 0) {
      fetchNui('getCameras', '')
        .then((res) => {
          if (res.success) {
            dispatch(setCameras(res.data));
            dispatch(setIsFetchedCameras(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setCameras([
                {
                  id: 1,
                  image: camerasImage,
                  title: 'LSPD Camera #1',
                },
                {
                  id: 2,
                  image: camerasImage,
                  title: 'LSPD Camera #2',
                },
                {
                  id: 3,
                  image: camerasImage,
                  title: 'LSPD Camera #3',
                },
                {
                  id: 4,
                  image: camerasImage,
                  title: 'LSPD Camera #4',
                },
                {
                  id: 5,
                  image: camerasImage,
                  title: 'LSPD Camera #5',
                },
                {
                  id: 6,
                  image: camerasImage,
                  title: 'LSPD Camera #6',
                },
                {
                  id: 7,
                  image: camerasImage,
                  title: 'LSPD Camera #7',
                },
                {
                  id: 8,
                  image: camerasImage,
                  title: 'LSPD Camera #8',
                },
              ]),
            );
            dispatch(setIsFetchedCameras(1));
          } else {
            errorNotify('Error occurred while fetched data.');
          }
        });
    }
  }, []);

  return (
    <>
      <div className="cameras-container">
        <div className="row g-4">
          <div className="col-lg-12">
            <Cameras />
          </div>
        </div>
      </div>
    </>
  );
};

export default CamerasPage;

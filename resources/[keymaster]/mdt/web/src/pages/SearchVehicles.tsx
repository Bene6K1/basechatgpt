import React, { useState, useEffect } from 'react';
import { useParams, useSearchParams } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setUser, setVehicle } from '@/slices/searchSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import UserInformation from '@/components/UserInformation';
import VehicleInformation from '@/components/VehicleInformation';

import vehicleImage from '@/assets/images/vehicle-car-image.png';
import profileImage from '@/assets/images/recording-details-profile-image.png';
import evidenceExampleImage from '@/assets/images/evidence-example-image.webp';

const SearchVehicles = () => {
  const { id } = useParams();
  const [searchParams] = useSearchParams();
  const ownerUserId = searchParams.get('owner_uid');
  const { user, vehicle } = useSelector((state: RootState) => state.searchSlice);
  const dispatch = useDispatch();

  useEffect(() => {
    fetchNui('getVehicleInfo', {
      id,
    })
      .then((res) => {
        if (res.success) {
          dispatch(setVehicle(res.data));
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(
            setVehicle({
              image: vehicleImage,
              carName: 'Maserati',
              numberPlate: 'ABCD1234',
              ownerName: 'Yordi Yordi',
            }),
          );
        } else {
          errorNotify('Error occurred while fetched data.');
        }
      });

    fetchNui('getUserInfo', {
      uid: ownerUserId,
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
            <VehicleInformation data={vehicle} />
          </div>

          <div className="col-lg-12 col-xl-6">
            <UserInformation
              data={user}
              title={`<span class="text-extrabold">Vehicle</span> Owner Information`}
            />
          </div>
        </div>
      </div>
    </>
  );
};

export default SearchVehicles;

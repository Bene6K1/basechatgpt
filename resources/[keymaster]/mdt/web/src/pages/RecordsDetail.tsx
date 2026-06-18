import React, { useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { setRecordDetail } from '@/slices/recordsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { useParams } from 'react-router-dom';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import RecordingDetails from '@/components/RecordingDetails';
import OffenderList from '@/components/OffenderList';
import PoliceList from '@/components/PoliceList';
import BackTo from '@/components/BackTo';

import profileImage from '@/assets/images/sidebar-profile.png';
import profileImageTwo from '@/assets/images/recording-details-profile-image.png';
import evidenceExampleImage from '@/assets/images/evidence-example-image.webp';

const Records = () => {
  const { id } = useParams();
  const dispatch = useDispatch();

  useEffect(() => {
    fetchNui('getRecordDetail', {
      id,
    })
      .then((res) => {
        if (res.success) {
          dispatch(
            setRecordDetail({
              avatar: res.data.avatar,
              name: res.data.name,
              date: res.data.date,
              reportedPolice: res.data.reportedPolice,
              reportText: res.data.reportText,
              ranks: res.data.ranks,
              evidences: res.data.evidences,
              offenders: res.data.offenders,
              polices: res.data.polices,
            }),
          );
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(
            setRecordDetail({
              avatar: profileImageTwo,
              name: 'Records 55',
              date: '05 Feb 2022 | 00:26',
              reportedPolice: 'nitroS Police',
              reportText: 'Test Report',
              ranks: [
                {
                  id: 1,
                  name: 'Suspect',
                },
                {
                  id: 2,
                  name: 'Murderer',
                },
                {
                  id: 3,
                  name: 'Smuggling',
                },
              ],
              evidences: [
                {
                  id: 1,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
              ],
              offenders: [
                {
                  id: 1,
                  avatar: profileImage,
                  name: 'Fizzfau',
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
              ],
              polices: [
                {
                  id: 1,
                  avatar: profileImage,
                  name: 'Fizzfau',
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
      <div className="records">
        <BackTo pageName="Records" href="records" />

        <div className="row g-4">
          <div className="col-lg-12 col-xl-5">
            <RecordingDetails />
          </div>

          <div className="col-lg-12 col-xl-7">
            <OffenderList />
            <PoliceList className="mt-4 " />
          </div>
        </div>
      </div>
    </>
  );
};

export default Records;

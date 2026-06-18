import React, { useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { setActivePolices, setDispatchs } from '@/slices/liveMapSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import LiveMap from '@/components/LiveMap';

import profileImage from '@/assets/images/on-duty-profile-image.png';
import profileImageTwo from '@/assets/images/sidebar-profile.png';

const LiveMapPage = () => {
  const dispatch = useDispatch();

  useEffect(() => {
    const interval = setInterval(() => {
      fetchNui('getLiveMap', '')
        .then((res) => {
          if (res.success) {
            dispatch(setActivePolices(res.data.activePolices));
            dispatch(setDispatchs(res.data.dispatchs));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setActivePolices([
                {
                  id: 1,
                  position: [0, 0],
                  avatar:
                    'https://fotolifeakademi.com/uploads/2020/04/dusuk-isikta-fotograf-cekme-724x394.webp',
                  name: 'Yordi',
                  rank: 'Beginner',
                  circleColor: 'blue',
                  isMe: true,
                },
                {
                  id: 2,
                  position: [500, 100],
                  avatar: profileImageTwo,
                  name: 'nitroS',
                  rank: 'Beginner',
                  circleColor: 'blue',
                },
                {
                  id: 3,
                  position: [250, -1000],
                  avatar: profileImage,
                  name: 'fizzfau',
                  rank: 'Beginner',
                  circleColor: 'blue',
                },
                {
                  id: 4,
                  position: [1000, -500],
                  avatar:
                    'https://fotolifeakademi.com/uploads/2020/04/dusuk-isikta-fotograf-cekme-724x394.webp',
                  name: 'Yordi',
                  rank: 'Beginner',
                  circleColor: 'red',
                },
                {
                  id: 5,
                  position: [1000, -100],
                  avatar: profileImageTwo,
                  name: 'nitroS',
                  rank: 'Beginner',
                  circleColor: 'red',
                },
                {
                  id: 6,
                  position: [1250, -1250],
                  avatar: profileImage,
                  name: 'fizzfau',
                  rank: 'Beginner',
                  circleColor: 'red',
                },
                {
                  id: 7,
                  position: [2250, -500],
                  avatar:
                    'https://fotolifeakademi.com/uploads/2020/04/dusuk-isikta-fotograf-cekme-724x394.webp',
                  name: 'Yordi',
                  rank: 'Beginner',
                  circleColor: 'orange',
                },
                {
                  id: 8,
                  position: [2250, 250],
                  avatar: profileImageTwo,
                  name: 'nitroS',
                  rank: 'Beginner',
                  circleColor: 'orange',
                },
                {
                  id: 9,
                  position: [2250, -2250],
                  avatar: profileImage,
                  name: 'fizzfau',
                  rank: 'Beginner',
                  circleColor: 'orange',
                },
              ]),
            );
            dispatch(
              setDispatchs([
                {
                  id: 1,
                  name: 'High Speed (200km/h)',
                  position: [500, 1150],
                  texts: [
                    {
                      id: 1,
                      text: '- Yordi has started.',
                    },
                    {
                      id: 2,
                      text: '- Yordi has started.',
                    },
                    {
                      id: 3,
                      text: '- Yordi has started.',
                    },
                  ],
                  circleColor: 'red',
                },
                {
                  id: 2,
                  name: 'High Speed (150km/h)',
                  position: [1500, 1700],
                  texts: [
                    {
                      id: 1,
                      text: '- Yordi has started.',
                    },
                    {
                      id: 2,
                      text: '- Yordi has started.',
                    },
                    {
                      id: 3,
                      text: '- Yordi has started.',
                    },
                  ],
                  circleColor: 'orange',
                },
                {
                  id: 3,
                  name: 'High Speed (200km/h)',
                  position: [2500, 1945],
                  texts: [
                    {
                      id: 1,
                      text: '- Yordi has started.',
                    },
                    {
                      id: 2,
                      text: '- Yordi has started.',
                    },
                    {
                      id: 3,
                      text: '- Yordi has started.',
                    },
                  ],
                  circleColor: 'white',
                },
              ]),
            );
          } else {
            errorNotify('Error ocurred while fetched data.');
          }
        });
    }, 1000);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="live-map-container">
      <div className="row g-4">
        <div className="col-lg-12">
          <LiveMap />
        </div>
      </div>
    </div>
  );
};

export default LiveMapPage;

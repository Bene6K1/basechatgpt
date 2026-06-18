import React, { FC, useState, useEffect } from 'react';
import { MapContainer, TileLayer, Marker, useMap, Popup } from 'react-leaflet';
import Leaflet, { extend, Projection, Transformation } from 'leaflet';
import { useAutoAnimate } from '@formkit/auto-animate/react';
import { Trash } from '@phosphor-icons/react';
import { useDispatch } from 'react-redux';
import { deleteDispatch } from '@/slices/liveMapSlice';
import { fetchNui } from '@/utils/fetchNui';
import { successNotify, errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';
import cx from 'classnames';

import Button from '@/components/Button';
import Loader from '@/components/Loader';

import './Map.scss';

const CENTER_X = 117.3;
const CENTER_Y = 172.8;
const SCALE_X = 0.02072;
const SCALE_Y = 0.0205;
const MAX_BOUNDS: [[number, number], [number, number]] = [
  [8000.0, -5500.0],
  [-8000.0, 5500.0],
];

type markersType = {
  id: number;
  position: any;
  avatar?: string;
  name?: string;
  rank?: string;
  circleColor?: 'blue' | 'red' | 'orange' | 'purple';
  isMe?: boolean;
};

type dispatchsType = {
  id: number;
  name: string;
  position: any;
  texts: { id: number; text: string }[];
  circleColor: 'orange' | 'red' | 'blue' | 'purple' | 'white';
};

interface IMapProps {
  markers: markersType[];
  dispatchs?: dispatchsType[];
  size?: 'small' | 'default';
  hideAvatarInMarker?: boolean;
  zoom?: number;
  center?: [number, number];
}

const Map: FC<IMapProps> = ({
  markers,
  dispatchs,
  size,
  hideAvatarInMarker,
  zoom = 4,
  center = [0, 0],
}) => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [animationParent] = useAutoAnimate();
  const dispatch = useDispatch();

  const CRS = extend({}, Leaflet.CRS.Simple, {
    projection: Projection.LonLat,
    scale: (zoom: number) => Math.pow(2, zoom),
    zoom: (sc: number) => Math.log(sc) / 0.6931471805599453,
    distance: (position: any, target: any) => {
      const x_difference: number = target.lng - position.lng;
      const y_difference: number = target.lat - position.lat;
      return Math.sqrt(x_difference * x_difference + y_difference * y_difference);
    },
    transformation: new Transformation(SCALE_X, CENTER_X, -SCALE_Y, CENTER_Y),
    infinite: true,
  });

  const ComponentResize = () => {
    const map = useMap();

    setTimeout(() => {
      map.invalidateSize();

      if (size === 'small') {
        map.flyToBounds([center]);
      }
    }, 0);

    return null;
  };

  const handleSetGPS = (x: any, y: any) => {
    fetchNui('setGPS', { x, y })
      .then((res) => {
        if (res.success) {
          successNotify('GPS is successfully selected.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          successNotify('GPS is successfully selected.');
        } else {
          errorNotify('Error ocurred while selected gps.');
        }
      });
  };

  const handleDeleteDispatch = (id: any) => {
    fetchNui('deleteDispatch', { id })
      .then((res) => {
        if (res.success) {
          dispatch(deleteDispatch(id));
          successNotify('Dispatch is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteDispatch(id));
          successNotify('Dispatch is successfully deleted.');
        } else {
          errorNotify('Error ocurred while deleted dispatch.');
        }
      });
  };

  useEffect(() => {
    setTimeout(() => {
      setIsLoading(false);
    }, 500);
  }, [dispatchs]);

  return (
    <div
      className={cx('map', {
        [`map--size-${size}`]: size,
      })}
    >
      <div className="map__inner">
        <MapContainer
          crs={CRS}
          minZoom={3}
          maxZoom={5}
          preferCanvas={true}
          center={[0, 0]}
          zoom={zoom}
          zoomControl={false}
          maxBounds={MAX_BOUNDS}
        >
          <ComponentResize />
          <TileLayer
            url="https://www.gtamap.xyz/mapStyles/styleAtlas/{z}/{x}/{y}.jpg"
            noWrap={true}
          />

          {markers.length > 0 &&
            markers.map((item) => (
              <Marker
                key={item.id}
                position={item.position}
                icon={Leaflet.divIcon({
                  iconSize: [20, 20],
                  html: `    
                    <div class="map__marker-circle map__marker-circle--${item.circleColor}"></div>
                    ${
                      !hideAvatarInMarker
                        ? `
                      <div class="map__marker-avatar${item.isMe ? ' map__marker-avatar--me' : ''}">
                        <img src=${
                          item.avatar
                        } class="map__marker-avatar-img" style="max-width: 48px!important;" />
                      </div>
                      `
                        : ''
                    }
                  `,
                  className: 'map__marker',
                })}
              >
                <Popup>
                  <div className="map__avatar">
                    <img src={item.avatar} alt="" className="map__avatar-img" />
                  </div>

                  <span className="map__title">{item.name}</span>
                  <p className="map__text">{item.rank}</p>

                  <Button
                    onClick={() => handleSetGPS(item.position[0], item.position[1])}
                    theme="blue"
                    size="medium"
                    className="mt-3"
                  >
                    Définir GPS
                  </Button>
                </Popup>
              </Marker>
            ))}

          {dispatchs &&
            dispatchs.length > 0 &&
            dispatchs.map((item) => (
              <Marker
                key={item.id}
                position={item.position}
                icon={Leaflet.divIcon({
                  iconSize: [20, 20],
                  html: `    
                    <div class="map__marker-circle map__marker-circle--${item.circleColor}"></div>
                    <div class="map__marker-tooltip map__marker-tooltip--${item.circleColor}">
                      ${item.name}
                    </div>
                  `,
                  className: 'map__marker',
                })}
              >
                <Popup>
                  <span className="map__title">{item.name}</span>

                  <div className="d-flex align-items-center mt-3">
                    <Button
                      onClick={() => handleSetGPS(item.position[0], item.position[1])}
                      theme="blue"
                      size="medium"
                      className="me-2"
                    >
                      Définir GPS
                    </Button>

                    <Button
                      onClick={() => handleDeleteDispatch(item.id)}
                      theme="red"
                      size="medium"
                      iconOnly={true}
                    >
                      <Trash />
                    </Button>
                  </div>
                </Popup>
              </Marker>
            ))}

          {dispatchs && dispatchs.length > 0 && (
            <div className="map__sidebar">
              <div className="map__sidebar-header">
                <div className="map__sidebar-header-left">
                  <div className="map__sidebar-header-icon">
                    <i className="fa-duotone fa-solid fa-radio" style={{ color: "white" }}></i>
                  </div>
                  <div className="map__sidebar-header-titles">
                    <span className="map__sidebar-header-title">
                      Dispatch
                      {dispatchs.length > 0 && (
                        <span className="map__sidebar-header-count"> ({dispatchs.length})</span>
                      )}
                    </span>
                    <span className="map__sidebar-header-subtitle">Appels en cours</span>
                  </div>
                </div>
              </div>

              <div ref={animationParent} className="map__sidebar-main">
                {isLoading || dispatchs.length === 0 ? (
                  <Loader />
                ) : (
                  <>
                    {dispatchs.length > 0 ? (
                      <>
                        {dispatchs
                          ?.slice()
                          .reverse()
                          .map((item) => (
                            <div
                              key={item.id}
                              className={cx('map__dispatch-item', {
                                [`map__dispatch-item--theme-${item.circleColor}`]: item.circleColor,
                              })}
                            >
                              <div className="map__dispatch-item-circle"></div>

                              <div className="d-flex flex-column">
                                <span className="map__dispatch-item-title">{item.name}</span>
                                {item.texts.map((i) => (
                                  <p key={i.id} className="map__dispatch-item-text">
                                    {i.text}
                                  </p>
                                ))}

                                <div className="d-flex align-items-center mt-2">
                                  <Button
                                    onClick={() => handleSetGPS(item.position[0], item.position[1])}
                                    theme="blue"
                                    size="medium"
                                    className="me-2"
                                  >
                                    Définir GPS
                                  </Button>

                                  <Button
                                    onClick={() => handleDeleteDispatch(item.id)}
                                    theme="red"
                                    size="medium"
                                    iconOnly={true}
                                  >
                                    <Trash />
                                  </Button>
                                </div>
                              </div>
                            </div>
                          ))}
                      </>
                    ) : (
                      <span className="section-text section-text--small text-light-gray">
                        Dispatch is not found.
                      </span>
                    )}
                  </>
                )}
              </div>
            </div>
          )}
        </MapContainer>
      </div>
    </div>
  );
};

export default Map;

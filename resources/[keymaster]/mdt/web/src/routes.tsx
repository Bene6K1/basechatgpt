/* eslint-disable react/react-in-jsx-scope */
import Home from '@/pages/Home';
import Records from '@/pages/Records';
import RecordsDetail from '@/pages/RecordsDetail';
import Wanteds from '@/pages/Wanteds';
import OffendersDetail from '@/pages/OffendersDetail';
import PolicesDetail from '@/pages/PolicesDetail';
import Fines from '@/pages/Fines';
import Department from '@/pages/Department';
import SearchUsers from '@/pages/SearchUsers';
import SearchVehicles from '@/pages/SearchVehicles';
import Cameras from '@/pages/Cameras';
import LiveMap from '@/pages/LiveMap';
import ErrorPage from '@/pages/ErrorPage';

const routes = [
  {
    index: true,
    path: '/',
    element: <Home />,
  },
  {
    path: '/records',
    element: <Records />,
  },
  {
    path: '/records/:id',
    element: <RecordsDetail />,
  },
  {
    path: '/wanteds',
    element: <Wanteds />,
  },
  {
    path: '/offenders/:id/:recordId',
    element: <OffendersDetail />,
  },
  {
    path: '/polices/:id/:recordId',
    element: <PolicesDetail />,
  },
  {
    path: '/fines',
    element: <Fines />,
  },
  {
    path: '/department',
    element: <Department />,
  },
  {
    path: '/search/users/:uid',
    element: <SearchUsers />,
  },
  {
    path: '/search/vehicles/:id',
    element: <SearchVehicles />,
  },
  {
    path: '/cameras',
    element: <Cameras />,
  },
  {
    path: '/live-map',
    element: <LiveMap />,
  },
  {
    path: '*',
    element: <ErrorPage />,
  },
];

export { routes };

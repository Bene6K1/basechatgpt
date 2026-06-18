import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import App from './App';
import { Provider } from 'react-redux';
import { store } from './store';
import Layout from '@/components/Layout';
import { VisibilityProvider } from './providers/VisibilityProvider';

import 'react-toastify/dist/ReactToastify.css';
import 'leaflet/dist/leaflet.css';
import '@/assets/lib/bootstrap-grid.css';
import './styles/main.scss';

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <Provider store={store}>
    <VisibilityProvider>
      <BrowserRouter>
        <Layout>
          <App />
        </Layout>
      </BrowserRouter>
    </VisibilityProvider>
  </Provider>,
);

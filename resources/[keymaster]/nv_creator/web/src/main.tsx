import React from 'react';
import { createRoot } from 'react-dom/client';
import App from '@/App';
import '@/styles/index.scss';
import { isEnvBrowser } from '@/lib/constants';
import { HashRouter as Router } from 'react-router-dom';

const root = document.getElementById('root');

if (isEnvBrowser) {
  // https://i.imgur.com/iPTAdYV.png - Night time img
  // https://i.imgur.com/hZhN5D9.jpeg - Creator img
  // https://i.imgur.com/3pzRj9n.png - Day time img
  root!.style.backgroundImage = 'url("https://i.imgur.com/hZhN5D9.jpeg")';
  root!.style.backgroundSize = 'cover';
  root!.style.backgroundRepeat = 'no-repeat';
  root!.style.backgroundPosition = 'center';
}

createRoot(root!).render(
  <React.StrictMode>
    <Router>
      <App />
    </Router>
  </React.StrictMode>
);
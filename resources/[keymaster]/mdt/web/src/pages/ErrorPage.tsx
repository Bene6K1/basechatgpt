import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { WarningCircle } from '@phosphor-icons/react';

import './ErrorPage.scss';

const ErrorPage = () => {
  const navigate = useNavigate();

  useEffect(() => {
    navigate('/');
  }, []);

  return (
    <div className="error-page">
      <div className="error-page__icon">
        <WarningCircle />
      </div>

      <h3 className="error-page__title">Unfortunately,</h3>
      <p className="error-page__text">This page is not found.</p>
    </div>
  );
};

export default ErrorPage;

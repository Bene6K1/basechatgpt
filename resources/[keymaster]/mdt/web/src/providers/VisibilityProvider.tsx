import React, { Context, createContext, useContext, useEffect, useState } from 'react';
import { useReadLocalStorage } from 'usehooks-ts';
import { useNuiEvent } from '@/hooks/useNuiEvent';
import { fetchNui } from '@/utils/fetchNui';
import { isEnvBrowser } from '@/utils/misc';
import environmentCheck from '@/utils/environmentCheck';
import cx from 'classnames';

const VisibilityCtx = createContext<VisibilityProviderValue | null>(null);

interface VisibilityProviderValue {
  setVisible: (visible: boolean) => void;
  visible: boolean;
}

// This should be mounted at the top level of your application, it is currently set to
// apply a CSS visibility value. If this is non-performant, this should be customized.
export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [visible, setVisible] = useState(false);
  const theme = useReadLocalStorage('theme');

  useNuiEvent<boolean>('setVisible', setVisible);

  // Handle pressing escape/backspace
  useEffect(() => {
    // Only attach listener when we are visible
    if (!visible) return;

    const keyHandler = (e: KeyboardEvent) => {
      if (['Escape'].includes(e.code)) {
        if (!isEnvBrowser()) fetchNui('hideFrame');
        else setVisible(!visible);
      }
    };

    window.addEventListener('keydown', keyHandler);

    return () => window.removeEventListener('keydown', keyHandler);
  }, [visible]);

  // for only development environment
  // don't touch these.
  useEffect(() => {
    if (environmentCheck(true)) {
      setVisible(true);
    }
  }, []);

  return (
    <VisibilityCtx.Provider
      value={{
        visible,
        setVisible,
      }}
    >
      <div
        className={cx('app', {
          'app--hidden': !visible,
          'app--theme-light': theme === 'light',
        })}
      >
        {children}
      </div>
    </VisibilityCtx.Provider>
  );
};

export const useVisibility = () =>
  useContext<VisibilityProviderValue>(VisibilityCtx as Context<VisibilityProviderValue>);

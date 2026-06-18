import React from 'react';
import { useLocalStorage } from 'usehooks-ts';

import IconWithLink from '@/components/IconWithLink';

import moonIcon from '@/assets/icons/moon.svg';
import sunIcon from '@/assets/icons/sun.svg';

const ThemeSwitcher = () => {
  const [theme, setTheme] = useLocalStorage('theme', 'dark');

  return (
    <div className="theme-switcher">
      {theme === 'dark' && <IconWithLink onClick={() => setTheme('light')} icon={sunIcon} />}
      {theme === 'light' && <IconWithLink onClick={() => setTheme('dark')} icon={moonIcon} />}
    </div>
  );
};

export default ThemeSwitcher;

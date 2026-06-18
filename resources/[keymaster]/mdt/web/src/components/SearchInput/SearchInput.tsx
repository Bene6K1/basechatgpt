import React, { FC, useEffect, useRef } from 'react';
import autoAnimate from '@formkit/auto-animate';

import searchIcon from '@/assets/icons/search.svg';
import enterIcon from '@/assets/icons/enter.svg';
import './SearchInput.scss';

interface ISearchInput {
  placeholder: string;
  value: string;
  setValue: any;
}

const SearchInput: FC<ISearchInput> = ({ placeholder, value, setValue }) => {
  const parent = useRef(null);

  const handleChange = (event: any) => {
    setValue(event.target.value);
  };

  useEffect(() => {
    parent.current && autoAnimate(parent.current);
  }, [parent]);

  return (
    <label className="search-input">
      <div className="search-input__icon">
        <img src={searchIcon} alt="" className="search-input__icon-img" />
      </div>

      <input
        onChange={handleChange}
        type="text"
        className="search-input__inner"
        placeholder={placeholder}
      />
    </label>
  );
};

export default SearchInput;

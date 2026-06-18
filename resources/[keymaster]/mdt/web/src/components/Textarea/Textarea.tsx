import React, { FC, useEffect, useRef } from 'react';
import autoAnimate from '@formkit/auto-animate';

import './Textarea.scss';

interface ITextareaProps extends React.TextareaHTMLAttributes<HTMLTextAreaElement> {
  value: any;
  setValue: any;
  onSubmit: any;
}

const Textarea: FC<ITextareaProps> = ({ value, setValue, onSubmit, ...res }) => {
  const parent = useRef(null);

  const handleChange = (e: any) => {
    setValue(e.target.value);
  };

  useEffect(() => {
    parent.current && autoAnimate(parent.current);
  }, [parent]);

  return (
    <div ref={parent} className="textarea">
      <textarea
        onChange={handleChange}
        defaultValue={value}
        className="textarea__inner"
        {...res}
      ></textarea>
      {value && (
        <button onClick={onSubmit} className="textarea__save-button">
          Enregistrer
        </button>
      )}
    </div>
  );
};

export default Textarea;

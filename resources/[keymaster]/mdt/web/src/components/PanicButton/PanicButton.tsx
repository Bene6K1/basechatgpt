import React, { useState, useEffect, useRef } from 'react';
import { CaretDown } from '@phosphor-icons/react';
import { useOnClickOutside } from 'usehooks-ts';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import redCircleIcon from '@/assets/icons/red-circle.svg';
import yellowCircleIcon from '@/assets/icons/yellow-circle.svg';
import blueCircleIcon from '@/assets/icons/blue-circle.svg';
import './PanicButton.scss';

const PanicButton = () => {
  const ref = useRef<HTMLDivElement>(null);
  const refInner = useRef<HTMLDivElement>(null);
  const [isDuplicate, setIsDuplicate] = useState<number>(0);
  const [isActive, setIsActive] = useState<boolean>(false);
  const [isActiveDuplicate, setIsActiveDuplicate] = useState<number>(0);

  const handleShow = () => {
    setIsActive(true);

    if (isActiveDuplicate === 1) {
      ref.current?.classList.remove('is-active');
      setIsActive(false);
      return;
    }

    ref.current?.classList.add('is-active');
  };

  const handleClose = () => {
    if (!isActive) return;

    setIsActiveDuplicate(1);
    ref.current?.classList.remove('is-active');
    setIsActive(false);

    setTimeout(() => {
      setIsActiveDuplicate(0);
    }, 400);
  };

  useOnClickOutside(refInner, handleClose);

  const handleOnClick = (type: string) => {
    if (isDuplicate > 0) {
      handleClose();
      return errorNotify("You're so fast. Please take a break.");
    }

    fetchNui('triggerPanicButton', {
      type,
    })
      .then((res) => {
        if (res.success) {
          successNotify('Panic button successfully triggered.');
          setIsDuplicate((current) => (current += 1));
          handleClose();
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          successNotify('Panic button successfully triggered.');
          setIsDuplicate((current) => (current += 1));
          handleClose();
        } else {
          errorNotify('Error occurred while triggered panic button.');
        }
      });
  };

  useEffect(() => {
    if (isDuplicate > 0) {
      setTimeout(() => {
        setIsDuplicate(0);
      }, 1000 * 60);
    }
  }, [isDuplicate]);

  return (
    <div ref={ref} className="panic-button">
      <div onClick={handleShow} className="panic-button__header">
        <div className="panic-button__inner">
          <span className="panic-button__text">Bouton Panique</span>
        </div>

        <div className="panic-button__icon">
          <CaretDown weight="bold" className="panic-button__icon-inner" />
        </div>
      </div>

      <div ref={refInner} className="panic-button__menu">
        <div onClick={() => handleOnClick('emergency')} className="panic-button__menu-item">
          <div className="panic-button__menu-icon">
            <img src={redCircleIcon} alt="" className="panic-button__menu-icon-img" />
          </div>

          <span className="panic-button__menu-text">Urgence</span>
        </div>

        <div onClick={() => handleOnClick('normal')} className="panic-button__menu-item">
          <div className="panic-button__menu-icon">
            <img src={yellowCircleIcon} alt="" className="panic-button__menu-icon-img" />
          </div>

          <span className="panic-button__menu-text">Normal</span>
        </div>

        <div onClick={() => handleOnClick('safe')} className="panic-button__menu-item">
          <div className="panic-button__menu-icon">
            <img src={blueCircleIcon} alt="" className="panic-button__menu-icon-img" />
          </div>

          <span className="panic-button__menu-text">Sûr</span>
        </div>
      </div>
    </div>
  );
};

export default PanicButton;

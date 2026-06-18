import React, { FC, useState } from 'react';
import { useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import cx from 'classnames';

import AddRanksModal from '@/modals/AddRanksModal';

import './Ranks.scss';

type dataType = {
  id: number;
  name: string;
};

interface IRanksProps {
  data: dataType[];
  handleRemove?: any;
  addWhere: string;
  hideAddRank?: boolean;
  hideEditRank?: boolean;
  className?: string;
}

const Ranks: FC<IRanksProps> = ({
  data,
  handleRemove,
  addWhere,
  hideAddRank,
  hideEditRank,
  className,
}) => {
  const [isEditable, setIsEditable] = useState<boolean>(false);
  const dispatch = useDispatch();

  const toggleEditable = () => {
    setIsEditable((current) => !current);
  };

  return (
    <>
      <AddRanksModal addWhere={addWhere} />

      <div className={cx('ranks', className)}>
        {data.length > 0 &&
          data.map((item) => (
            <span key={item.id} className="ranks__item">
              {item.name}

              {isEditable && (
                <div onClick={() => handleRemove(item.id)} className="ranks__delete">
                  <i className="fa-duotone fa-solid fa-xmark"></i>
                </div>
              )}
            </span>
          ))}

        {!hideAddRank && !hideEditRank && (
          <div className="ranks__actions">
            {!hideAddRank && (
              <div
                onClick={() => dispatch(setActiveModal('add-ranks'))}
                className="ranks__item ranks__item--action"
              >
                <i className="fa-duotone fa-solid fa-plus"></i>
              </div>
            )}

            {!hideEditRank && (
              <>
                {data.length > 0 && (
                  <div
                    onClick={toggleEditable}
                    className={`ranks__item ranks__item--action ranks__item--action-edit ${isEditable ? 'ranks__item--action-active' : ''}`}
                  >
                    <i className="fa-duotone fa-solid fa-pen"></i>
                  </div>
                )}
              </>
            )}
          </div>
        )}
      </div>
    </>
  );
};

export default Ranks;

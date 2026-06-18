import React, { FC } from 'react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setEditedFineId } from '@/slices/globalSlice';
import { deleteFines, setIsActiveEditingDeleted } from '@/slices/finesSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';
import cx from 'classnames';

import './Table.scss';

type dataType = {
  id: number;

  fields: {
    text: string;
  }[];
};

interface ITableProps {
  columns: { name: string }[];
  data: dataType[];
}

const Table: FC<ITableProps> = ({ columns, data }) => {
  const { editedFineId } = useSelector((state: RootState) => state.globalSlice);
  const dispatch = useDispatch();

  const handleDelete = (id: number) => {
    if (editedFineId === id) {
      dispatch(setIsActiveEditingDeleted(true));
    }

    fetchNui('deleteFine', {
      id,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteFines(id));
          successNotify('Fine is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        if (environmentCheck(true)) {
          dispatch(deleteFines(id));
          successNotify('Fine is successfully deleted.');
        } else {
          errorNotify('Error ocurred while deleted fine.');
        }
      });
  };

  const handleEdit = (id: number) => {
    dispatch(setEditedFineId(id));
  };

  return (
    <table className="table">
      <thead className="table__thead">
        <tr className="table__thead-tr">
          {columns.map((column, index) => (
            <th key={index} className="table__thead-th">
              {column.name}
            </th>
          ))}
          {data.length > 0 && <th className="table__thead-th"></th>}
        </tr>
      </thead>

      <tbody className="table__tbody">
        {data.length > 0 ? (
          <>
            {data.map((item) => (
              <tr
                key={item.id}
                className={cx('table__tbody-tr', {
                  'is-editing': editedFineId === item.id,
                })}
              >
                {item.fields.map((field, i) => (
                  <td key={i} className="table__tbody-td">
                    {field.text}
                  </td>
                ))}
                <td className="table__tbody-td table__tbody-td--action-only">
                  <div className="table__action">
                    <div
                      onClick={() => handleDelete(item.id)}
                      className="table__action-item table__action-item--delete"
                    >
                      <div className="table__action-icon">
                        <i className="fa-duotone fa-solid fa-trash"></i>
                      </div>
                    </div>

                    <div onClick={() => handleEdit(item.id)} className="table__action-item">
                      <div className="table__action-icon">
                        <i className="fa-duotone fa-solid fa-pen"></i>
                      </div>
                    </div>
                  </div>
                </td>
              </tr>
            ))}
          </>
        ) : (
          <>
            <tr className="table__tbody-tr">
              <td className="table__tbody-td">
                <span className="section-text"></span>
              </td>
              <td className="table__tbody-td">
                <span className="section-text"></span>
              </td>
              <td className="table__tbody-td">
                <span className="section-text"></span>
              </td>
            </tr>
            <tr className="table__tbody-tr">
              <td className="table__tbody-td">
                <span className="section-text"></span>
              </td>
              <td className="table__tbody-td table__tbody-td--empty">
                <span className="section-text">Aucun résultat trouvé.</span>
              </td>
              <td className="table__tbody-td">
                <span className="section-text"></span>
              </td>
            </tr>
            <tr className="table__tbody-tr">
              <td className="table__tbody-td">
                <span className="section-text"></span>
              </td>
              <td className="table__tbody-td">
                <span className="section-text"></span>
              </td>
              <td className="table__tbody-td">
                <span className="section-text"></span>
              </td>
            </tr>
          </>
        )}
      </tbody>
    </table>
  );
};

export default Table;

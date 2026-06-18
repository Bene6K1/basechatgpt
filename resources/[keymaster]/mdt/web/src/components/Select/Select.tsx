import React, { FC } from 'react';
import ReactSelect, { components } from 'react-select';
import cx from 'classnames';

import './Select.scss';

type optionsType = {
  id: string;
  value: string;
  name: string;
};

interface ISelectProps {
  options: optionsType[];
  defaultValue?: any;
  value?: any;
  styleType?: 'one' | 'two';
  className?: string;
  onChange?: (e: any) => void;
  id?: string;
  placeholder?: string;
  isMulti?: boolean;
  disabled?: boolean;
  small?: boolean;
}

const AddAvatarForSelect = (props: any) => {
  const { name, avatar } = props.data;

  return (
    <components.Option className="d-flex align-items-center" {...props}>
      {avatar && (
        <div className="modal-select-option__avatar">
          <img src={avatar} className="modal-select-option__avatar-img" />
        </div>
      )}

      <span className="modal-select-option__name">{name}</span>
    </components.Option>
  );
};

const Select: FC<ISelectProps> = ({
  options,
  defaultValue,
  value,
  styleType,
  className,
  onChange,
  id,
  placeholder,
  isMulti = false,
  disabled = false,
  small = false,
}) => {
  // Convert options from old format {id, value, name} to react-select format {value, label}
  const formattedOptions = options.map((option) => ({
    ...option, // Keep original properties for avatar support
    value: option.value,
    label: option.name,
  }));

  // Find default value in formatted options
  const formattedDefaultValue = defaultValue
    ? formattedOptions.find((opt) => opt.value === defaultValue)
    : undefined;

  // Find value in formatted options
  const formattedValue = value ? formattedOptions.find((opt) => opt.value === value) : undefined;

  // Handle onChange to maintain compatibility
  const handleChange = (selectedOption: any) => {
    if (onChange) {
      // Create a synthetic event-like object for compatibility
      const syntheticEvent = {
        target: {
          value: selectedOption?.value || '',
          id: id,
        },
        currentTarget: {
          value: selectedOption?.value || '',
          id: id,
        },
      };
      onChange(syntheticEvent as any);
    }
  };

  const hasAvatar = options.some((opt: any) => opt.avatar);

  const formatOptionLabel = hasAvatar
    ? (option: any) => (
        <div className="d-flex align-items-center">
          {option.avatar && (
            <div className="modal-select-option__avatar modal-select-option__avatar--small">
              <img src={option.avatar} className="modal-select-option__avatar-img" />
            </div>
          )}

          <span>{option.label}</span>
        </div>
      )
    : undefined;

  return (
    <ReactSelect
      defaultValue={formattedDefaultValue}
      value={formattedValue}
      options={formattedOptions}
      onChange={handleChange}
      placeholder={placeholder}
      isMulti={isMulti}
      isDisabled={disabled}
      id={id}
      className={cx('modal-select-option', className, {
        [`select--style-${styleType}`]: styleType,
        'select--small': small,
      })}
      classNamePrefix="modal-select-option"
      components={hasAvatar ? { Option: AddAvatarForSelect } : undefined}
      formatOptionLabel={formatOptionLabel}
    />
  );
};

export default Select;

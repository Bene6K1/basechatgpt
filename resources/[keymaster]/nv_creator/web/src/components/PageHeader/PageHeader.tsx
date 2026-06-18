import { FC, ReactNode } from 'react';
import './PageHeader.scss';

interface IPageHeaderProps {
  icon: ReactNode;
  title: string;
  subtitle?: string;
  className?: string;
  nomarginbottom?: boolean
}

const PageHeader: FC<IPageHeaderProps> = ({
  icon,
  title,
  subtitle,
  className = '',
  nomarginbottom
}) => {
  return (
    <div className={`page-header ${className} ${nomarginbottom ? 'nomarginbottom' : 'nomarginbottom'}`}>
      <div className="page-header__left">
        <div className="page-header__icon">
          {icon}
        </div>
        <div className="page-header__titles">
          <span className="page-header__title">{title}</span>
          {subtitle && <span className="page-header__subtitle">{subtitle}</span>}
        </div>
      </div>
    </div>
  );
};

export default PageHeader;

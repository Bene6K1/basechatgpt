import React, { FC } from 'react';
import './CardCorners.scss';

interface ICardCornersProps {
  color?: string;
  className?: string;
}

const CardCorners: FC<ICardCornersProps> = ({
  color = 'rgba(255, 255, 255, 0.5)',
  className = ''
}) => {
  return (
    <div className={`card-corners ${className}`}>
      {/* Top-left corner */}
      <div className="card-corners__corner card-corners__corner--top-left">
        <div className="card-corners__line card-corners__line--vertical" style={{ backgroundColor: color }} />
        <div className="card-corners__line card-corners__line--horizontal" style={{ backgroundColor: color }} />
      </div>

      {/* Top-right corner */}
      <div className="card-corners__corner card-corners__corner--top-right">
        <div className="card-corners__line card-corners__line--vertical" style={{ backgroundColor: color }} />
        <div className="card-corners__line card-corners__line--horizontal" style={{ backgroundColor: color }} />
      </div>

      {/* Bottom-right corner */}
      <div className="card-corners__corner card-corners__corner--bottom-right">
        <div className="card-corners__line card-corners__line--vertical" style={{ backgroundColor: color }} />
        <div className="card-corners__line card-corners__line--horizontal" style={{ backgroundColor: color }} />
      </div>

      {/* Bottom-left corner */}
      <div className="card-corners__corner card-corners__corner--bottom-left">
        <div className="card-corners__line card-corners__line--vertical" style={{ backgroundColor: color }} />
        <div className="card-corners__line card-corners__line--horizontal" style={{ backgroundColor: color }} />
      </div>
    </div>
  );
};

export default CardCorners;

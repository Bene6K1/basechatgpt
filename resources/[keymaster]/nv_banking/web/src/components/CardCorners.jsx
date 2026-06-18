import React from 'react'

const CardCorners = ({ color = '#D9D9D9', className = '' }) => {
    const cornerSize = 'calc(0.092592592vh * 10)' // Taille responsive des coins
    const cornerThickness = 'calc(0.092592592vh * 1.5)' // Épaisseur des lignes

    return (
        <div className={`card-corners ${className}`} style={{
            position: 'absolute',
            top: 0,
            left: 0,
            width: '100%',
            height: '100%',
            pointerEvents: 'none'
        }}>
            {/* Top-left corner */}
            <div style={{
                position: 'absolute',
                top: 0,
                left: 0,
                width: cornerSize,
                height: cornerSize
            }}>
                <div style={{
                    position: 'absolute',
                    top: 0,
                    left: 0,
                    width: cornerThickness,
                    height: cornerSize,
                    backgroundColor: color
                }} />
                <div style={{
                    position: 'absolute',
                    top: 0,
                    left: 0,
                    width: cornerSize,
                    height: cornerThickness,
                    backgroundColor: color
                }} />
            </div>

            {/* Top-right corner */}
            <div style={{
                position: 'absolute',
                top: 0,
                right: 0,
                width: cornerSize,
                height: cornerSize
            }}>
                <div style={{
                    position: 'absolute',
                    top: 0,
                    right: 0,
                    width: cornerThickness,
                    height: cornerSize,
                    backgroundColor: color
                }} />
                <div style={{
                    position: 'absolute',
                    top: 0,
                    right: 0,
                    width: cornerSize,
                    height: cornerThickness,
                    backgroundColor: color
                }} />
            </div>

            {/* Bottom-right corner */}
            <div style={{
                position: 'absolute',
                bottom: 0,
                right: 0,
                width: cornerSize,
                height: cornerSize
            }}>
                <div style={{
                    position: 'absolute',
                    bottom: 0,
                    right: 0,
                    width: cornerThickness,
                    height: cornerSize,
                    backgroundColor: color
                }} />
                <div style={{
                    position: 'absolute',
                    bottom: 0,
                    right: 0,
                    width: cornerSize,
                    height: cornerThickness,
                    backgroundColor: color
                }} />
            </div>

            {/* Bottom-left corner */}
            <div style={{
                position: 'absolute',
                bottom: 0,
                left: 0,
                width: cornerSize,
                height: cornerSize
            }}>
                <div style={{
                    position: 'absolute',
                    bottom: 0,
                    left: 0,
                    width: cornerThickness,
                    height: cornerSize,
                    backgroundColor: color
                }} />
                <div style={{
                    position: 'absolute',
                    bottom: 0,
                    left: 0,
                    width: cornerSize,
                    height: cornerThickness,
                    backgroundColor: color
                }} />
            </div>
        </div>
    )
}

export default CardCorners

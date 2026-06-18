import React, { useEffect } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { Alert } from '@mui/material'
import { hideNotification } from '../store/configSlice2'
import AudioPlayer from '../hooks/AudioPlayer'

/**
 * Notify Component
 * 
 * This component displays notifications using MUI Alert.
 * It automatically hides notifications after the specified duration.
 * 
 * Usage in other components:
 * 
 * // Import the actions
 * import { showSuccessNotification, showErrorNotification, showNotification } from '../store/configSlice'
 * 
 * // Show success notification
 * dispatch(showSuccessNotification('Success Title', 'Success message here'))
 * 
 * // Show error notification  
 * dispatch(showErrorNotification('Error Title', 'Error message here'))
 * 
 * // Show custom notification
 * dispatch(showNotification({
 *   label: 'Custom Title',
 *   description: 'Custom message',
 *   type: 'success', // or 'error'
 *   ms: 5000 // milliseconds to show
 * }))
 * 
 * Example usage in a component:
 * 
 * function MyComponent() {
 *   const dispatch = useDispatch()
 *   
 *   const handleSuccess = () => {
 *     dispatch(showSuccessNotification('Operation Successful', 'Your action was completed successfully!'))
 *   }
 *   
 *   const handleError = () => {
 *     dispatch(showErrorNotification('Operation Failed', 'Something went wrong. Please try again.'))
 *   }
 *   
 *   return (
 *     <div>
 *       <button onClick={handleSuccess}>Show Success</button>
 *       <button onClick={handleError}>Show Error</button>
 *     </div>
 *   )
 * }
 */
function Notify() {
    const Config = useSelector((store) => store.config)
    const dispatch = useDispatch()
    const Sound = AudioPlayer()

    useEffect(() => {
        if (Config.Notification.show) {
            const timer = setTimeout(() => {
                dispatch(hideNotification())
            }, Config.Notification.ms)
            Sound("notification.wav")
            return () => clearTimeout(timer)
        }
    }, [Config.Notification.show, Config.Notification.ms, dispatch])

    if (!Config.Notification.show) return null

    return (
        <Alert 
            severity={Config.Notification.type}
            sx={{ 
                width: '100%',
                backgroundColor: Config.Notification.type === 'success' ? '#4caf50' : '#f44336',
                color: 'white',
                opacity: 0,
                animation: 'fadeIn 0.3s ease-in-out forwards',
                '& .MuiAlert-icon': {
                    color: 'white'
                },
                '@keyframes fadeIn': {
                    '0%': {
                        opacity: 0,
                        transform: 'translateY(-10px)'
                    },
                    '100%': {
                        opacity: 1,
                        transform: 'translateY(0)'
                    }
                }
            }}
        >
            <div>
                {Config.Notification.label && (
                    <div style={{ fontWeight: 'bold', marginBottom: '.2083vw' }}>
                        {Config.Notification.label}
                    </div>
                )}
                {Config.Notification.description && (
                    <div>
                        {Config.Notification.description}
                    </div>
                )}
            </div>
        </Alert>
    )
}

export default Notify
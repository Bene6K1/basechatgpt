import React, { useState } from 'react'
import { useSelector } from 'react-redux'
import { FormatMoney } from '../../store/configSlice2'
import postNUI from '../../hooks/postNUI'
import './Settings.css'
import CardCorners from "../../components/CardCorners"

function Settings() {
    const Config = useSelector(state => state.config)
    const [password, setPassword] = useState(['', '', '', '', '', ''])
    const [currentInputIndex, setCurrentInputIndex] = useState(0)

    const totalIncome = Config.Transactions
        .filter(transaction => transaction.type === 'add')
        .reduce((sum, transaction) => sum + transaction.amount, 0)

    const totalSpent = Config.Transactions
        .filter(transaction => transaction.type === 'remove')
        .reduce((sum, transaction) => sum + transaction.amount, 0)

    const totalSent = Config.Transactions
        .filter(transaction => transaction.source === 'transfer-given')
        .reduce((sum, transaction) => sum + transaction.amount, 0)

    const currentMonth = new Date().getMonth() + 1
    const currentYear = new Date().getFullYear()

    const monthlySpending = Config.Transactions
        .filter(transaction => {
            if (transaction.type !== 'remove') return false
            const transactionDate = new Date(transaction.date.split('.').reverse().join('-'))
            return transactionDate.getMonth() + 1 === currentMonth &&
                transactionDate.getFullYear() === currentYear
        })
        .reduce((sum, transaction) => sum + transaction.amount, 0)

    const handleKeypadClick = (number) => {
        if (number === 'delete') {
            if (currentInputIndex > 0) {
                const newPassword = [...password]
                newPassword[currentInputIndex - 1] = ''
                setPassword(newPassword)
                setCurrentInputIndex(currentInputIndex - 1)
            }
        } else if (number !== '' && currentInputIndex < 6) {
            const newPassword = [...password]
            newPassword[currentInputIndex] = number
            setPassword(newPassword)
            setCurrentInputIndex(currentInputIndex + 1)
        }
    }

    const isPasswordComplete = password.every(digit => digit !== '') && currentInputIndex === 6

    const changePassword = () => {
        if (isPasswordComplete) {
            postNUI('changePassword', password.join(''))
            setPassword(['', '', '', '', '', ''])
            setCurrentInputIndex(0)
        }
    }

    const [keypad] = useState([
        { number: '1' }, { number: '2' }, { number: '3' },
        { number: '4' }, { number: '5' }, { number: '6' },
        { number: '7' }, { number: '8' }, { number: '9' },
        { number: '' }, { number: '0' }, { number: 'delete' }
    ])

    // Format IBAN for display
    const formatIBAN = (iban) => {
        if (!iban) return '0000 0000 0000 0000'
        const ibanString = String(iban)
        const cleaned = ibanString.replace(/\s/g, '')
        return cleaned.match(/.{1,4}/g)?.join(' ') || ibanString
    }

    return (
        <div className='settings w-full h-full flex flex-col theme-animate-in card-with-corners'>
            <CardCorners color="rgba(255, 255, 255, 0.5)" />
            {/* Header Section */}
            <div className='settings-header flex flex-row items-center justify-between'>
                <div className='settings-header-left flex items-center'>
                    <div className='settings-header-iconDiv flex items-center justify-center'>
                        <i className="fa-duotone fa-solid fa-gear"></i>
                    </div>
                    <div className='settings-header-titles flex flex-col'>
                        <span className='settings-header-title'>{Config.Locales['settings'] || 'Settings'}</span>
                        <span className='settings-header-subtitle'>{Config.Locales['settings_subtitle'] || 'Manage your account settings'}</span>
                    </div>
                </div>
                <div className='settings-header-right flex items-center'>
                    <div className='settings-header-balance flex flex-col items-end'>
                        <span className='settings-header-balance-label'>Bank Balance</span>
                        <span className='settings-header-balance-value'>${FormatMoney(Config.PlayerInformation.Balance)}</span>
                    </div>
                    <div className='settings-header-balance-icon flex items-center justify-center'>
                        <i className="fa-duotone fa-solid fa-building-columns"></i>
                    </div>
                </div>
            </div>

            {/* Stats Cards */}
            <div className='settings-stats grid grid-cols-4'>
                <div className='settings-stat-card card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='settings-stat-header flex items-center'>
                        <div className='settings-stat-iconDiv flex items-center justify-center' style={{ background: 'rgba(59, 190, 57, 0.15)' }}>
                            <i className="fa-duotone fa-solid fa-arrow-down" style={{ color: '#3BBE39' }}></i>
                        </div>
                        <span className='settings-stat-label'>{Config.Locales['money_earned'] || 'Money Earned'}</span>
                    </div>
                    <span className='settings-stat-value' style={{ color: '#3BBE39' }}>${FormatMoney(totalIncome)}</span>
                    <span className='settings-stat-description'>{Config.Locales['money_earned_desc'] || 'Total income'}</span>
                </div>

                <div className='settings-stat-card card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='settings-stat-header flex items-center'>
                        <div className='settings-stat-iconDiv flex items-center justify-center' style={{ background: 'rgba(205, 65, 44, 0.15)' }}>
                            <i className="fa-duotone fa-solid fa-arrow-up" style={{ color: '#CD412C' }}></i>
                        </div>
                        <span className='settings-stat-label'>{Config.Locales['money_spent'] || 'Money Spent'}</span>
                    </div>
                    <span className='settings-stat-value' style={{ color: '#CD412C' }}>${FormatMoney(totalSpent)}</span>
                    <span className='settings-stat-description'>{Config.Locales['money_spent_desc'] || 'Total expenses'}</span>
                </div>

                <div className='settings-stat-card card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='settings-stat-header flex items-center'>
                        <div className='settings-stat-iconDiv flex items-center justify-center' style={{ background: 'rgba(219, 173, 24, 0.15)' }}>
                            <i className="fa-duotone fa-solid fa-paper-plane" style={{ color: '#DBAD18' }}></i>
                        </div>
                        <span className='settings-stat-label'>{Config.Locales['money_sent'] || 'Money Sent'}</span>
                    </div>
                    <span className='settings-stat-value' style={{ color: '#DBAD18' }}>${FormatMoney(totalSent)}</span>
                    <span className='settings-stat-description'>{Config.Locales['money_sent_desc'] || 'Total transfers'}</span>
                </div>

                <div className='settings-stat-card card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='settings-stat-header flex items-center'>
                        <div className='settings-stat-iconDiv flex items-center justify-center' style={{ background: 'rgba(194, 194, 194, 0.15)' }}>
                            <i className="fa-duotone fa-solid fa-calendar" style={{ color: '#c2c2c2' }}></i>
                        </div>
                        <span className='settings-stat-label'>{Config.Locales['monthly_spending'] || 'Monthly'}</span>
                    </div>
                    <span className='settings-stat-value'>${FormatMoney(monthlySpending)}</span>
                    <span className='settings-stat-description'>{Config.Locales['monthly_spending_desc'] || 'This month'}</span>
                </div>
            </div>

            {/* Main Content - Two Columns */}
            <div className='settings-content flex flex-row flex-1 overflow-hidden'>
                {/* Left Column - Credit Card */}
                <div className='settings-content-left card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='settings-section-header2 flex items-center'>
                        <div className='settings-section-iconDiv flex items-center justify-center'>
                            <i className="fa-duotone fa-solid fa-credit-card"></i>
                        </div>
                        <div className='settings-section-titles flex flex-col'>
                            <span className='settings-section-title'>{Config.Locales['credit_card'] || 'Credit Card'}</span>
                            <span className='settings-section-subtitle'>{Config.Locales['credit_card_subtitle'] || 'Your bank card details'}</span>
                        </div>
                    </div>

                    {/* Card Preview - Real Credit Card Style */}
                    <div className='settings-card-preview'>
                        <div className='relative w-full settings-card-visual overflow-hidden' style={{
                            background: 'linear-gradient(135deg, #1A1A1A 0%, #1c1c1c 100%)'
                        }}>
                            {/* Card stripes */}
                            <div className='absolute right-0 top-0 h-full w-[45%]' style={{
                                background: 'linear-gradient(135deg, #444444 0%, #c2c2c2 0%, #444444 100%)',
                                clipPath: 'polygon(30% 0, 100% 0, 100% 100%, 0% 100%)'
                            }}></div>
                            <div className='absolute right-[15%] top-0 h-full w-[20%]' style={{
                                background: 'linear-gradient(135deg, #1c1c1c 0%, #1A1A1A 100%)',
                                clipPath: 'polygon(50% 0, 100% 0, 50% 100%, 0% 100%)'
                            }}></div>

                            {/* Card content */}
                            <div className='absolute settings-card-logo'>
                                <span className='theme-text dashboard-leftcolumn-account-header-cardnametext font-medium' style={{ color: '#E5E5E5' }}>
                                    {Config.BankName || 'Bank'}card.
                                </span>
                            </div>

                            {/* Card Number */}
                            <div className='absolute settings-card-number flex items-center'>
                                <span>{formatIBAN(Config.PlayerInformation.IBAN)}</span>
                                <i className="fa-duotone fa-solid fa-copy settings-card-copy" onClick={() => navigator.clipboard.writeText(Config.PlayerInformation.IBAN)}></i>
                            </div>

                            {/* Card Bottom Info */}
                            <div className='absolute settings-card-bottom flex justify-between items-end'>
                                <div className='flex flex-col'>
                                    <span className='settings-card-label'>VALID THRU</span>
                                    <span className='settings-card-value'>12/25</span>
                                </div>
                                <div className='flex flex-col items-end'>
                                    <span className='settings-card-label'>CARD HOLDER</span>
                                    <span className='settings-card-value'>{Config.PlayerInformation.Firstname} {Config.PlayerInformation.Lastname}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* Card Details Section */}
                    {/* <div className='settings-card-section flex flex-col'>
                        <div className='settings-section-header flex items-center'>
                            <div className='settings-section-iconDiv flex items-center justify-center'>
                                <i className="fa-duotone fa-solid fa-lock"></i>
                            </div>
                            <div className='settings-section-titles flex flex-col'>
                                <span className='settings-section-title'>{Config.Locales['card_details'] || 'Card Details'}</span>
                                <span className='settings-section-subtitle'>{Config.Locales['card_details_subtitle'] || 'Manage your card security'}</span>
                            </div>
                        </div>

                        <div className='settings-pin-section flex flex-col'>
                            <div className='settings-pin-input-row flex items-center'>
                                <div className='settings-pin-inputs flex'>
                                    {[...Array(6)].map((_, k) => (
                                        <input
                                            key={k}
                                            type='password'
                                            className='settings-pin-input'
                                            value={password[k]}
                                            readOnly
                                        />
                                    ))}
                                </div>
                                <button
                                    className={`settings-pin-confirm ${isPasswordComplete ? 'settings-pin-confirm-active' : ''}`}
                                    onClick={changePassword}
                                    disabled={!isPasswordComplete}
                                >
                                    <i className="fa-duotone fa-solid fa-check"></i>
                                </button>
                            </div>

                            <div className='settings-keypad grid grid-cols-3'>
                                {keypad.map((v, k) => {
                                    if (v.number === '') return <div key={k}></div>

                                    if (v.number === 'delete') {
                                        return (
                                            <button
                                                key={k}
                                                className='settings-keypad-btn'
                                                onClick={() => handleKeypadClick('delete')}
                                            >
                                                <i className="fa-duotone fa-solid fa-backspace"></i>
                                            </button>
                                        )
                                    }

                                    return (
                                        <button
                                            key={k}
                                            className='settings-keypad-btn'
                                            onClick={() => handleKeypadClick(v.number)}
                                        >
                                            <span>{v.number}</span>
                                        </button>
                                    )
                                })}
                            </div>
                        </div>
                    </div> */}
                </div>

                {/* Right Column - Requests & Notifications */}
                <div className='settings-content-right flex flex-col'>
                    {/* Incoming Requests */}
                    <div className='settings-requests card-with-corners flex flex-col'>
                        <CardCorners color="rgba(255, 255, 255, 0.5)" />
                        <div className='settings-section-header flex items-start justify-between'>
                            <div className='flex items-center settings-section-header'>
                                <div className='settings-section-iconDiv flex items-center justify-center'>
                                    <i className="fa-duotone fa-solid fa-inbox"></i>
                                </div>
                                <div className='settings-section-titles flex flex-col'>
                                    <span className='settings-section-title'>{Config.Locales['incoming_requests'] || 'Incoming Requests'}</span>
                                    <span className='settings-section-subtitle'>{Config.Locales['incoming_requests_subtitle'] || 'Money requests from others'}</span>
                                </div>
                            </div>
                            {Config.PlayerInformation.Requests?.length > 0 && (
                                <div className='settings-badge'>{Config.PlayerInformation.Requests.length}</div>
                            )}
                        </div>

                        <div className='settings-requests-list flex flex-col overflow-y-auto theme-scrollbar'>
                            {Config.PlayerInformation.Requests?.length > 0 ? (
                                Config.PlayerInformation.Requests.map((v, k) => (
                                    <div key={k} className='settings-request-card flex flex-col theme-animate-slide'>
                                        <div className='settings-request-header flex items-center'>
                                            <div className='settings-request-avatar flex items-center justify-center'>
                                                <i className="fa-duotone fa-solid fa-user"></i>
                                            </div>
                                            <div className='settings-request-info flex flex-col'>
                                                <span className='settings-request-name'>{v.name}</span>
                                                <span className='settings-request-amount'>
                                                    {Config.Locales['user_requested_money']?.replace('${amount}', FormatMoney(v.amount)) || `Requested $${FormatMoney(v.amount)}`}
                                                </span>
                                            </div>
                                        </div>
                                        <div className='settings-request-actions grid grid-cols-2'>
                                            <button
                                                className='settings-action-btn settings-action-success'
                                                onClick={() => postNUI('acceptRequest', { id: k, sender: v.sender, amount: v.amount })}
                                            >
                                                <i className="fa-duotone fa-solid fa-check"></i>
                                                <span>{Config.Locales['accept'] || 'Accept'}</span>
                                            </button>
                                            <button
                                                className='settings-action-btn settings-action-danger'
                                                onClick={() => postNUI('rejectRequest', { id: k, iban: v.sender })}
                                            >
                                                <i className="fa-duotone fa-solid fa-times"></i>
                                                <span>{Config.Locales['reject'] || 'Reject'}</span>
                                            </button>
                                        </div>
                                    </div>
                                ))
                            ) : (
                                <div className='settings-empty flex flex-col items-center justify-center'>
                                    <i className="fa-duotone fa-solid fa-inbox settings-empty-icon"></i>
                                    <span className='settings-empty-text'>{Config.Locales['no_requests'] || 'No pending requests'}</span>
                                </div>
                            )}
                        </div>
                    </div>

                    {/* Notifications */}
                    <div className='settings-notifications card-with-corners flex flex-col flex-1'>
                        <CardCorners color="rgba(255, 255, 255, 0.5)" />
                        <div className='settings-section-header flex items-center justify-between'>
                            <div className='flex items-center settings-section-header'>
                                <div className='settings-section-iconDiv flex items-center justify-center'>
                                    <i className="fa-duotone fa-solid fa-bell"></i>
                                </div>
                                <div className='settings-section-titles flex flex-col'>
                                    <span className='settings-section-title'>{Config.Locales['notifications'] || 'Notifications'}</span>
                                    <span className='settings-section-subtitle'>{Config.Locales['notifications_subtitle'] || 'Your recent alerts'}</span>
                                </div>
                            </div>
                            {Config.PlayerInformation.Notification?.length > 0 && (
                                <button className='settings-clear-btn' onClick={() => postNUI('clearNotifications')}>
                                    <i className="fa-duotone fa-solid fa-trash"></i>
                                    <span>{Config.Locales['clear_all'] || 'Clear All'}</span>
                                </button>
                            )}
                        </div>

                        <div className='settings-notifications-list flex flex-col overflow-y-auto theme-scrollbar flex-1'>
                            {Config.PlayerInformation.Notification?.length > 0 ? (
                                Config.PlayerInformation.Notification.slice().reverse().map((v, k) => (
                                    <div key={k} className='settings-notification-card flex items-center theme-animate-slide'>
                                        <div className='settings-notification-icon flex items-center justify-center'>
                                            <i className="fa-duotone fa-solid fa-bell"></i>
                                        </div>
                                        <div className='settings-notification-info flex flex-col'>
                                            <span className='settings-notification-title'>{v.label}</span>
                                            <span className='settings-notification-description'>{v.description}</span>
                                        </div>
                                    </div>
                                ))
                            ) : (
                                <div className='settings-empty flex flex-col items-center justify-center flex-1'>
                                    <i className="fa-duotone fa-solid fa-bell-slash settings-empty-icon"></i>
                                    <span className='settings-empty-text'>{Config.Locales['no_notifications'] || 'No notifications'}</span>
                                </div>
                            )}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Settings

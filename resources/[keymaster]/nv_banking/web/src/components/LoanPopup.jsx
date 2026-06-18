import React, { useState } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { FormatMoney, setLoanPopupOpen } from '../store/configSlice2'
import postNUI from '../hooks/postNUI'
import './LoanPopup.css'

function LoanPopup({ show, onClose, loan }) {
    const Config = useSelector(state => state.config)
    const dispatch = useDispatch()
    const [amount, setAmount] = useState('')

    const Pay = (amount) => {
        if (!amount || amount <= 0) return
        postNUI('PayAPart', {
            loan: loan.realName,
            amount: amount
        })
        dispatch(setLoanPopupOpen(false))
        setAmount('')
    }

    const handleClose = () => {
        onClose()
        setAmount('')
    }

    if (!show || !loan) return null

    return (
        <div className='loan-popup-overlay w-full h-full flex items-center justify-center absolute top-0 left-0'>
            <div className='loan-popup flex flex-col'>
                {/* Header */}
                <div className='loan-popup-header flex items-center justify-between'>
                    <div className='flex items-center loan-popup-header'>
                        <div className='loan-popup-iconDiv flex items-center justify-center' style={{
                            background: `radial-gradient(120.1% 120.1% at 115.34% -20.1%, ${loan.color}40 0%, rgba(0, 0, 0, 0) 100%), var(--bg-secondary)`
                        }}>
                            <i className="fa-duotone fa-solid fa-hand-holding-dollar" style={{ color: loan.color }}></i>
                        </div>
                        <div className='loan-popup-titles flex flex-col'>
                            <span className='loan-popup-title'>{Config.Locales['pay_part'] || 'Pay Part of Loan'}</span>
                            <span className='loan-popup-subtitle'>{Config.Locales['pay_part_subtitle'] || "Pay off a portion of your debt"}</span>
                        </div>
                    </div>
                    <button className='loan-popup-close flex items-center justify-center' onClick={handleClose}>
                        <i className="fa-duotone fa-solid fa-xmark"></i>
                    </button>
                </div>

                {/* Loan Info Card */}
                <div className='loan-popup-info flex flex-col'>
                    <div className='loan-popup-loan-header flex items-center justify-between'>
                        <div className='flex items-center loan-popup-loan-header'>
                            <div className='loan-popup-loan-icon flex items-center justify-center' style={{
                                background: `${loan.color}20`,
                                boxShadow: `0 0 12px ${loan.color}40`
                            }}>
                                {loan.logo ? (
                                    <img src={loan.logo} alt={loan.name} />
                                ) : (
                                    <i className="fa-duotone fa-solid fa-landmark" style={{ color: loan.color }}></i>
                                )}
                            </div>
                            <div className='loan-popup-loan-titles flex flex-col'>
                                <span className='loan-popup-loan-name'>{loan.name}</span>
                                <span className='loan-popup-loan-desc'>{loan.description}</span>
                            </div>
                        </div>
                        <div className='loan-popup-loan-credit flex items-center' style={{
                            background: `${loan.color}15`,
                            color: loan.color
                        }}>
                            <i className="fa-duotone fa-solid fa-star"></i>
                            <span>{loan.requiredCreditPoint}</span>
                        </div>
                    </div>

                    {/* Stats */}
                    <div className='loan-popup-stats flex'>
                        <div className='loan-popup-stat flex flex-col'>
                            <span className='loan-popup-stat-label'>{Config.Locales['remaining_debt'] || 'Remaining Debt'}</span>
                            <span className='loan-popup-stat-value' style={{ color: '#cd412c' }}>${FormatMoney(loan.remainingDebt)}</span>
                        </div>
                        <div className='loan-popup-stat flex flex-col'>
                            <span className='loan-popup-stat-label'>{Config.Locales['deadline'] || 'Deadline'}</span>
                            <span className='loan-popup-stat-value'>{loan.deadline}</span>
                        </div>
                    </div>
                </div>

                {/* Input Section */}
                <div className='loan-popup-input-section flex flex-col'>
                    <span className='loan-popup-input-label'>{Config.Locales['how_much_pay'] || 'How much do you want to pay?'}</span>
                    <input
                        type='number'
                        className='loan-popup-input'
                        placeholder={`${FormatMoney(1000)}$`}
                        value={amount}
                        onChange={(e) => setAmount(e.target.value)}
                    />
                </div>

                {/* Actions */}
                <div className='loan-popup-actions flex'>
                    <button className='loan-popup-btn loan-popup-btn-cancel flex items-center justify-center' onClick={handleClose}>
                        <i className="fa-duotone fa-solid fa-xmark"></i>
                        <span>{Config.Locales['cancel'] || 'Cancel'}</span>
                    </button>
                    <button className='loan-popup-btn loan-popup-btn-pay flex items-center justify-center' onClick={() => Pay(amount)}>
                        <i className="fa-duotone fa-solid fa-check"></i>
                        <span>{Config.Locales['pay'] || 'Pay'}</span>
                    </button>
                </div>
            </div>
        </div>
    )
}

export default LoanPopup

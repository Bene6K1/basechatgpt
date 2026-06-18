import React, { useState, useEffect } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { FormatMoney, setLoanPopupOpen } from '../../store/configSlice2'
import LoanPopup from '../../components/LoanPopup'
import postNUI from '../../hooks/postNUI'
import './Loans.css'
import CardCorners from "../../components/CardCorners";

function Loans() {
    const Config = useSelector((store) => store.config)
    const dispatch = useDispatch()
    const [expandedLoans, setExpandedLoans] = useState({})
    const [selectedLoan, setSelectedLoan] = useState(null)

    useEffect(() => {
        const handleEsc = (e) => {
            if (e.key === 'Escape' && Config.LoanPopupOpen) {
                dispatch(setLoanPopupOpen(false))
                setSelectedLoan(null)
            }
        }
        window.addEventListener('keydown', handleEsc)
        return () => window.removeEventListener('keydown', handleEsc)
    }, [Config.LoanPopupOpen, dispatch])

    const toggleLoan = (index) => {
        setExpandedLoans(prev => ({
            ...prev,
            [index]: !prev[index]
        }))
    }

    const handlePayPart = (loan) => {
        const activeCredit = Config.PlayerInformation.ActiveCredits ?
            Config.PlayerInformation.ActiveCredits.find(credit => credit.name === loan.name) : null
        const loanData = {
            realName: loan.name,
            name: loan.label,
            description: loan.description,
            requiredCreditPoint: loan.requiredCreditPoint,
            deadline: `${loan.paybackTime} ${Config.Locales['week']} - ${calculateDeadlineDate(loan.paybackTime, activeCredit?.boughtTime)}`,
            remainingDebt: activeCredit?.remainingDebt || 0,
            color: loan.color,
            logo: loan.logo
        }
        setSelectedLoan(loanData)
        dispatch(setLoanPopupOpen(true))
    }

    const calculateDeadlineDate = (weeks, boughtTime) => {
        if (!boughtTime) {
            const today = new Date()
            const deadline = new Date(today.getTime() + (weeks * 7 * 24 * 60 * 60 * 1000))
            return deadline.toLocaleDateString('fr-FR', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric'
            })
        }

        const [day, month, year] = boughtTime.split('.')
        const boughtDate = new Date(2000 + parseInt(year), parseInt(month) - 1, parseInt(day))
        const deadline = new Date(boughtDate.getTime() + (weeks * 7 * 24 * 60 * 60 * 1000))

        return deadline.toLocaleDateString('fr-FR', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        })
    }

    const formatPercentage = (percent) => {
        return Math.round((percent - 1) * 100)
    }

    const buySelectedCredit = (name, remainingDebt) => {
        postNUI('buyCredit', {
            name: name,
            remainingDebt: remainingDebt
        })
    }

    const payAllDebt = (amount) => {
        postNUI('payAllDebt', amount)
    }

    const payDebt = (name) => {
        postNUI('payDebt', name)
    }

    const totalDebt = Config.PlayerInformation.ActiveCredits?.reduce((total, credit) => total + credit.remainingDebt, 0) || 0

    return (
        <div className='loans w-full h-full flex flex-col theme-animate-in card-with-corners'>
            <CardCorners color="rgba(255, 255, 255, 0.5)" />
            {/* Header Section */}
            <div className='loans-header flex flex-row items-center justify-between'>
                <div className='loans-header-left flex items-center'>
                    <div className='loans-header-iconDiv flex items-center justify-center'>
                        <i className="fa-duotone fa-solid fa-hand-holding-dollar"></i>
                    </div>
                    <div className='loans-header-titles flex flex-col'>
                        <span className='loans-header-title'>{Config.Locales['loans'] || 'Loans'}</span>
                        <span className='loans-header-subtitle'>{Config.Locales['loans_subtitle'] || 'Manage your credits and debts'}</span>
                    </div>
                </div>
                <div className='loans-header-right flex items-center'>
                    <div className='loans-header-balance flex flex-col items-end'>
                        <span className='loans-header-balance-label'>Solde Bancaire</span>
                        <span className='loans-header-balance-value'>${FormatMoney(Config.PlayerInformation.Balance)}</span>
                    </div>
                    <div className='loans-header-balance-icon flex items-center justify-center'>
                        <i className="fa-duotone fa-solid fa-building-columns"></i>
                    </div>
                </div>
            </div>

            {/* Stats Cards */}
            <div className='loans-stats grid grid-cols-3'>
                {/* Credit Score */}
                <div className='loans-stat-card card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='loans-stat-header flex items-center'>
                        <div className='loans-stat-iconDiv flex items-center justify-center' style={{ background: 'rgba(59, 190, 57, 0.15)' }}>
                            <i className="fa-duotone fa-solid fa-award" style={{ color: '#3BBE39' }}></i>
                        </div>
                        <span className='loans-stat-label'>{Config.Locales['credit_point'] || 'Credit Score'}</span>
                    </div>
                    <span className='loans-stat-value' style={{ color: '#3BBE39' }}>
                        {Config.PlayerInformation.CreditPoint}
                    </span>
                    <div className='loans-stat-status flex items-center'>
                        <div className='loans-status-dot' style={{ background: '#3BBE39' }}></div>
                        <span className='loans-stat-status-text'>Excellent</span>
                    </div>
                </div>

                {/* Unpaid Debt */}
                <div className='loans-stat-card card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='loans-stat-header flex items-center'>
                        <div className='loans-stat-iconDiv flex items-center justify-center' style={{ background: totalDebt > 0 ? 'rgba(205, 65, 44, 0.15)' : 'rgba(59, 190, 57, 0.15)' }}>
                            <i className="fa-duotone fa-solid fa-credit-card" style={{ color: totalDebt > 0 ? '#CD412C' : '#3BBE39' }}></i>
                        </div>
                        <span className='loans-stat-label'>{Config.Locales['unpaid_debt'] || 'Unpaid Debt'}</span>
                    </div>
                    <span className='loans-stat-value' style={{ color: totalDebt > 0 ? '#CD412C' : '#3BBE39' }}>
                        ${FormatMoney(totalDebt)}
                    </span>
                    {totalDebt > 0 && (
                        <button className='loans-pay-all-btn' onClick={() => payAllDebt(totalDebt)}>
                            <i className="fa-duotone fa-solid fa-credit-card"></i>
                            <span>{Config.Locales['pay_all'] || 'Pay All'}</span>
                        </button>
                    )}
                </div>

                {/* Active Credits */}
                <div className='loans-stat-card card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='loans-stat-header flex items-center'>
                        <div className='loans-stat-iconDiv flex items-center justify-center' style={{ background: 'rgba(219, 173, 24, 0.15)' }}>
                            <i className="fa-duotone fa-solid fa-file-invoice-dollar" style={{ color: '#DBAD18' }}></i>
                        </div>
                        <span className='loans-stat-label'>{Config.Locales['active_credits'] || 'Active Credits'}</span>
                    </div>
                    <span className='loans-stat-value' style={{ color: '#DBAD18' }}>
                        {Config.PlayerInformation.ActiveCredits?.length || 0}
                    </span>
                </div>
            </div>

            {/* Main Content - Two Columns */}
            <div className='loans-content flex flex-row flex-1 overflow-hidden'>
                {/* Left Column - Active Loans */}
                <div className='loans-content-left card-with-corners flex flex-col flex-1 overflow-hidden'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='loans-section-header flex items-center'>
                        <div className='loans-section-iconDiv flex items-center justify-center'>
                            <i className="fa-duotone fa-solid fa-file-contract"></i>
                        </div>
                        <div className='loans-section-titles flex flex-col'>
                            <span className='loans-section-title'>{Config.Locales['active_loans'] || 'Active Loans'}</span>
                            <span className='loans-section-subtitle'>{Config.Locales['active_loans_subtitle'] || 'Your current active credits'}</span>
                        </div>
                    </div>

                    {Config.PlayerInformation.ActiveCredits?.length > 0 ? (
                        <div className='loans-active-list flex flex-col overflow-y-auto theme-scrollbar'>
                            {Config.PlayerInformation.ActiveCredits.map((activeCredit, k) => {
                                const loanInfo = Config.Credits?.find(credit => credit.name === activeCredit.name)
                                if (!loanInfo) return null

                                return (
                                    <div key={k} className='loans-active-card flex flex-col theme-animate-slide'>
                                        <div className='loans-active-header flex items-center justify-between'>
                                            <div className='loans-active-info flex items-center'>
                                                <div className='loans-active-logo'>
                                                    <img src={loanInfo.logo} alt={loanInfo.label} />
                                                </div>
                                                <div className='loans-active-texts flex flex-col'>
                                                    <span className='loans-active-label'>{loanInfo.label}</span>
                                                    <span className='loans-active-description'>{loanInfo.description}</span>
                                                </div>
                                            </div>
                                            <div className='loans-active-badge'>
                                                <i className="fa-duotone fa-solid fa-award"></i>
                                                <span>{loanInfo.requiredCreditPoint}</span>
                                            </div>
                                        </div>

                                        <div className='loans-active-grid grid grid-cols-2'>
                                            <div className='loans-active-grid-item flex flex-col'>
                                                <span className='loans-active-grid-label'>{Config.Locales['total_payback_amount'] || 'Total Amount'}</span>
                                                <span className='loans-active-grid-value'>${FormatMoney(loanInfo.price * loanInfo.paybackPercent)}</span>
                                                <span className='loans-active-grid-subtext'>+{formatPercentage(loanInfo.paybackPercent)}% {Config.Locales['interest'] || 'interest'}</span>
                                            </div>
                                            <div className='loans-active-grid-item flex flex-col'>
                                                <span className='loans-active-grid-label'>{Config.Locales['remaining_debt'] || 'Remaining'}</span>
                                                <span className='loans-active-grid-value' style={{ color: '#CD412C' }}>${FormatMoney(activeCredit.remainingDebt)}</span>
                                                <span className='loans-active-grid-subtext'>{Config.Locales['deadline'] || 'Deadline'}: {calculateDeadlineDate(loanInfo.paybackTime, activeCredit.boughtTime)}</span>
                                            </div>
                                        </div>

                                        <div className='loans-active-actions grid grid-cols-2'>
                                            <button className='loans-action-btn loans-action-danger' onClick={() => payDebt(loanInfo.name)}>
                                                <i className="fa-duotone fa-solid fa-money-bill-wave"></i>
                                                <span>{Config.Locales['pay_all_button'] || 'Pay All'}</span>
                                            </button>
                                            <button className='loans-action-btn loans-action-success' onClick={() => handlePayPart(loanInfo)}>
                                                <i className="fa-duotone fa-solid fa-coins"></i>
                                                <span>{Config.Locales['pay_part'] || 'Pay Part'}</span>
                                            </button>
                                        </div>
                                    </div>
                                )
                            })}
                        </div>
                    ) : (
                        <div className='loans-empty flex flex-col items-center justify-center'>
                            <i className="fa-duotone fa-solid fa-file-invoice loans-empty-icon"></i>
                            <span className='loans-empty-title'>{Config.Locales['no_active_loans'] || 'No Active Loans'}</span>
                            <span className='loans-empty-text'>{Config.Locales['no_loans_text'] || 'You have no active credits at the moment.'}</span>
                        </div>
                    )}
                </div>

                {/* Right Column - Available Loans */}
                <div className='loans-content-right card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='loans-section-header flex items-center'>
                        <div className='loans-section-iconDiv flex items-center justify-center'>
                            <i className="fa-duotone fa-solid fa-list"></i>
                        </div>
                        <div className='loans-section-titles flex flex-col'>
                            <span className='loans-section-title'>{Config.Locales['available_loans'] || 'Available Loans'}</span>
                            <span className='loans-section-subtitle'>{Config.Locales['available_loans_subtitle'] || 'Credit options for you'}</span>
                        </div>
                    </div>

                    <div className='loans-available-list flex flex-col overflow-y-auto theme-scrollbar flex-1'>
                        {Config.Credits
                            ?.filter(credit => !Config.PlayerInformation.ActiveCredits?.some(active => active.name === credit.name))
                            .map((v, k) => {
                                const isOpen = expandedLoans[k]
                                const canApply = Config.PlayerInformation.CreditPoint >= v.requiredCreditPoint

                                return (
                                    <div key={k} className={`loans-available-card flex flex-col theme-animate-slide ${isOpen ? 'loans-available-card-active' : ''}`}>
                                        <div
                                            className='loans-available-header flex flex-row items-center justify-between cursor-pointer'
                                            onClick={() => toggleLoan(k)}
                                        >
                                            <div className='loans-available-info flex items-center'>
                                                <div className='loans-available-logo'>
                                                    <img src={v.logo} alt={v.label} />
                                                </div>
                                                <div className='loans-available-texts flex flex-col'>
                                                    <div className='flex items-center'>
                                                        <span className='loans-available-label'>{v.label}</span>
                                                        <div className='loans-available-badge' style={{ opacity: canApply ? 1 : 0.5 }}>
                                                            <i className="fa-duotone fa-solid fa-award"></i>
                                                            <span>{v.requiredCreditPoint}</span>
                                                        </div>
                                                    </div>
                                                    <span className='loans-available-description'>{v.description}</span>
                                                </div>
                                            </div>
                                            <i className={`fa-duotone fa-solid fa-chevrons-${isOpen ? 'up' : 'down'} loans-available-chevron`}></i>
                                        </div>

                                        <div className={`loans-available-details-wrapper ${isOpen ? 'loans-available-details-open' : ''}`}>
                                            <div className='loans-available-details flex flex-col'>
                                                <div className='theme-divider'></div>
                                                <div className='loans-available-grid grid grid-cols-3'>
                                                    <div className='loans-available-grid-item flex flex-col'>
                                                        <span className='loans-available-grid-label'>{Config.Locales['amount_you_will_get'] || 'You Get'}</span>
                                                        <span className='loans-available-grid-value' style={{ color: '#3BBE39' }}>${FormatMoney(v.price)}</span>
                                                    </div>
                                                    <div className='loans-available-grid-item flex flex-col'>
                                                        <span className='loans-available-grid-label'>{Config.Locales['amount_you_will_payback'] || 'Payback'}</span>
                                                        <span className='loans-available-grid-value'>${FormatMoney(v.price * v.paybackPercent)}</span>
                                                        <span className='loans-available-grid-subtext'>+{formatPercentage(v.paybackPercent)}%</span>
                                                    </div>
                                                    <div className='loans-available-grid-item flex flex-col'>
                                                        <span className='loans-available-grid-label'>{Config.Locales['deadline_for_payback'] || 'Deadline'}</span>
                                                        <span className='loans-available-grid-value'>{v.paybackTime} {Config.Locales['week'] || 'weeks'}</span>
                                                        <span className='loans-available-grid-subtext'>{calculateDeadlineDate(v.paybackTime, null)}</span>
                                                    </div>
                                                </div>
                                                <button
                                                    className={`loans-apply-btn ${canApply ? 'loans-apply-enabled' : 'loans-apply-disabled'}`}
                                                    onClick={() => canApply && buySelectedCredit(v.name, v.price * v.paybackPercent)}
                                                    disabled={!canApply}
                                                >
                                                    <i className="fa-duotone fa-solid fa-hand-holding-dollar"></i>
                                                    <span>{canApply ? (Config.Locales['confirm'] || 'Apply Now') : (Config.Locales['insufficient_credit'] || 'Insufficient Credit Score')}</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                )
                            })}
                    </div>
                </div>
            </div>

            <LoanPopup show={Config.LoanPopupOpen} onClose={() => { dispatch(setLoanPopupOpen(false)); setSelectedLoan(null); }} loan={selectedLoan} />
        </div>
    )
}

export default Loans

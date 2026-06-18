import React, { useState } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { FormatMoney, showErrorNotification } from '../../store/configSlice2'
import postNUI from '../../hooks/postNUI'
import './SavingAccount.css'
import CardCorners from "../../components/CardCorners";

function SavingAccount() {
    const Config = useSelector((store) => store.config)
    const dispatch = useDispatch()
    const [openAccounts, setOpenAccounts] = useState({})

    const calculateDeadlineDate = (hours) => {
        const today = new Date()
        const deadline = new Date(today.getTime() + (hours * 60 * 60 * 1000))
        return deadline.toLocaleDateString('fr-FR', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        })
    }

    const formatTimeDisplay = (hours) => {
        if (hours >= 24) {
            const days = Math.floor(hours / 24)
            return `${days} ${days > 1 ? Config.Locales['days'] : Config.Locales['day']}`
        }
        return `${hours} ${hours > 1 ? Config.Locales['hours'] : Config.Locales['hour']}`
    }

    const BuySavingAccount = (name) => {
        // Trouver le compte épargne pour vérifier le coût
        const accountInfo = Config.SavingAccounts.find(account => account.name === name)

        if (!accountInfo) {
            dispatch(showErrorNotification(
                Config.Locales["error"] || "Erreur",
                Config.Locales["saving_not_found"] || "Compte épargne introuvable"
            ));
            return;
        }

        // Vérifier si le joueur a assez d'argent
        if (Config.PlayerInformation.Balance < accountInfo.cost) {
            dispatch(showErrorNotification(
                Config.Locales["error"] || "Erreur",
                Config.Locales["not_enough_balance"] || "Solde bancaire insuffisant pour cet investissement"
            ));
            return;
        }

        postNUI('BuySavingAccount', name)
    }

    const calculateRemainingTime = (activeAccount, accountInfo) => {
        const dateTimeParts = activeAccount.boughtTime.split(' ')
        const datePart = dateTimeParts[0]
        const timePart = dateTimeParts[1]

        const [day, month, year] = datePart.split('.')
        const [hour, minute, second] = timePart.split(':')

        const fullYear = year.length === 2 ? 2000 + parseInt(year) : parseInt(year)
        const boughtDate = new Date(fullYear, parseInt(month) - 1, parseInt(day), parseInt(hour), parseInt(minute), parseInt(second))

        const now = new Date()
        const totalTimeInMs = accountInfo.time * 60 * 60 * 1000
        const endDate = new Date(boughtDate.getTime() + totalTimeInMs)
        const diff = endDate - now

        if (diff <= 0) return { days: 0, hours: 0, minutes: 0, percentage: 100 }

        const days = Math.floor(diff / (1000 * 60 * 60 * 24))
        const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))

        const elapsedTime = now - boughtDate
        const percentage = Math.min(100, Math.max(0, (elapsedTime / totalTimeInMs) * 100))

        return { days, hours, minutes, percentage }
    }

    // Calculate total savings
    const totalSavings = Config.PlayerInformation.ActiveSavingAccounts?.reduce((total, activeAccount) => {
        const accountInfo = Config.SavingAccounts.find(account => account.name === activeAccount.name)
        return total + (accountInfo?.cost || 0)
    }, 0) || 0

    return (
        <div className='saving-account w-full h-full flex flex-col theme-animate-in card-with-corners'>
            <CardCorners color="rgba(255, 255, 255, 0.5)" />
            {/* Header Section with Balances */}
            <div className='flex flex-row items-center justify-between'>
                <div className='saving-header-left flex items-center'>
                    <div className='saving-header-iconDiv flex items-center justify-center'>
                        <i className="fa-duotone fa-solid fa-piggy-bank"></i>
                    </div>
                    <div className='saving-header-titles flex flex-col'>
                        <span className='saving-header-title'>{Config.Locales['savings_actions'] || 'Comptes Epargnes'}</span>
                        <span className='saving-header-subtitle'>{Config.Locales['savings_subtitle'] || 'Liste des épargens disponibles'}</span>
                    </div>
                </div>
                <div className='saving-header-right flex items-center'>
                    <div className='saving-header-balance flex flex-col items-end'>
                        <span className='saving-header-balance-label'>Solde Bancaire</span>
                        <span className='saving-header-balance-value'>${FormatMoney(Config.PlayerInformation.Balance)}</span>
                    </div>
                    <div className='saving-header-iconDiv flex items-center justify-center'>
                        <i className="fa-duotone fa-solid fa-building-columns"></i>
                    </div>
                </div>
            </div>

            {/* Savings Money Total */}
            <div className='saving-total flex flex-col card-with-corners'>
                <CardCorners color="rgba(255, 255, 255, 0.5)" />
                <div className='saving-total-header flex items-center'>
                    <div className='saving-total-iconDiv flex items-center justify-center'>
                        <i className="fa-duotone fa-solid fa-coins"></i>
                    </div>
                    <div className='saving-total-titles flex flex-col'>
                        <span className='saving-total-title'>{Config.Locales['savings_money'] || 'Solde Total'}</span>
                        <span className='saving-total-subtitle'>{Config.Locales['savings_total_subtitle'] || 'Solde Total de vos épargnes'}</span>
                    </div>
                </div>
                <div className='saving-total-amount-container'>
                    <span className='saving-total-amount'>${FormatMoney(totalSavings)}</span>
                </div>
            </div>

            {/* Main Content - Two Columns */}
            <div className='saving-content flex flex-row flex-1 overflow-hidden'>
                {/* Left Column - Active Investments & Transactions */}
                <div className='saving-content-left card-with-corners flex flex-col flex-1 overflow-hidden'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    {/* Active Investments Table */}
                    <div className='saving-investments flex flex-col'>
                        <div className='saving-section-header flex items-center'>
                            <div className='saving-section-iconDiv flex items-center justify-center'>
                                <i className="fa-duotone fa-solid fa-chart-line-up"></i>
                            </div>
                            <div className='saving-section-titles flex flex-col'>
                                <span className='saving-section-title'>{Config.Locales['active_investments'] || 'Active Investments'}</span>
                                <span className='saving-section-subtitle'>{Config.Locales['active_investments_subtitle'] || 'Lorem ipsum dolar sit amet'}</span>
                            </div>
                        </div>

                        {Config.PlayerInformation.ActiveSavingAccounts?.length > 0 ? (
                            <div className='saving-investments-table-wrapper theme-scrollbar'>
                                <table className='saving-investments-table'>
                                    <thead>
                                        <tr>
                                            <th>{Config.Locales['investment'] || 'INVESTMENT'}</th>
                                            <th>{Config.Locales['gains'] || 'GAINS'}</th>
                                            <th>{Config.Locales['time_remaining'] || 'TIME'}</th>
                                            <th>{Config.Locales['amount'] || 'AMOUNT'}</th>
                                            <th>{Config.Locales['action'] || 'ACTION'}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {Config.PlayerInformation.ActiveSavingAccounts.map((activeAccount, k) => {
                                            const accountInfo = Config.SavingAccounts.find(account => account.name === activeAccount.name)
                                            if (!accountInfo) return null
                                            const timeInfo = calculateRemainingTime(activeAccount, accountInfo)

                                            return (
                                                <tr key={k} className='theme-animate-slide'>
                                                    <td>
                                                        <div className='investment-cell flex items-center'>
                                                            <div className='investment-cell-percent' style={{ background: `${accountInfo.color}20`, color: accountInfo.color }}>
                                                                {accountInfo.percent}%
                                                            </div>
                                                            <span className='investment-cell-label'>{accountInfo.label}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span className='investment-gains' style={{ color: accountInfo.color }}>
                                                            ${FormatMoney(accountInfo.cost * (1 + accountInfo.percent / 100))}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div className='investment-time flex flex-col'>
                                                            <span className='investment-time-text'>{timeInfo.days}j {timeInfo.hours}h {timeInfo.minutes}m</span>
                                                            <div className='investment-time-bar'>
                                                                <div
                                                                    className='investment-time-bar-fill'
                                                                    style={{
                                                                        width: `${timeInfo.percentage}%`,
                                                                        background: accountInfo.color
                                                                    }}
                                                                />
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span className='investment-amount'>${FormatMoney(accountInfo.cost)}</span>
                                                    </td>
                                                    <td>
                                                        <button
                                                            className='investment-delete-btn flex items-center justify-center'
                                                            onClick={() => postNUI('cancelSavingAccount', accountInfo.name)}
                                                        >
                                                            <i className="fa-duotone fa-solid fa-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            )
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        ) : (
                            <div className='saving-empty flex flex-col items-center justify-center'>
                                <i className="fa-duotone fa-solid fa-piggy-bank saving-empty-icon"></i>
                                <span className='saving-empty-title'>{Config.Locales['no_active_investment'] || 'No Active Investments'}</span>
                                <span className='saving-empty-text'>{Config.Locales['no_investment_text'] || 'Start investing to grow your money.'}</span>
                            </div>
                        )}
                    </div>

                </div>

                {/* Right Column - Available Plans */}
                <div className='saving-content-right card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='saving-section-header flex items-center'>
                        <div className='saving-section-iconDiv flex items-center justify-center'>
                            <i className="fa-duotone fa-solid fa-list"></i>
                        </div>
                        <div className='saving-section-titles flex flex-col'>
                            <span className='saving-section-title'>{Config.Locales['investment_account_types'] || 'Investment Plans'}</span>
                            <span className='saving-section-subtitle'>{Config.Locales['investment_plans_subtitle'] || 'Available investment options'}</span>
                        </div>
                    </div>

                    <div className='saving-plans-list flex flex-col overflow-y-auto theme-scrollbar flex-1'>
                        {Config.SavingAccounts
                            ?.filter(account => !Config.PlayerInformation.ActiveSavingAccounts?.some(active => active.name === account.name))
                            .map((v, k) => {
                                const isOpen = openAccounts[k]
                                return (
                                    <div key={k} className={`saving-plan-card  ${isOpen ? 'saving-plan-card-active' : ''} flex flex-col theme-animate-slide`}>
                                        <div
                                            className='saving-plan-header flex flex-row items-center justify-between cursor-pointer'
                                            onClick={() => setOpenAccounts(prev => ({...prev, [k]: !prev[k]}))}
                                        >
                                            <div className='saving-plan-info flex items-center'>
                                                <div className='saving-plan-percent' style={{ background: `${v.color}20`, color: v.color }}>
                                                    {v.percent}%
                                                </div>
                                                <div className='saving-plan-texts flex flex-col'>
                                                    <span className='saving-plan-label'>{v.label}</span>
                                                    <span className='saving-plan-description'>{v.description}</span>
                                                </div>
                                            </div>
                                            <i className={`fa-duotone fa-solid fa-chevrons-${isOpen ? 'up' : 'down'} saving-plan-chevron`}></i>
                                        </div>

                                        <div className={`saving-plan-details-wrapper ${isOpen ? 'saving-plan-details-open' : ''}`}>
                                            <div className='saving-plan-details flex flex-col'>
                                                <div className='theme-divider'></div>
                                                <div className='saving-plan-grid grid grid-cols-2'>
                                                    <div className='saving-plan-grid-item flex flex-col'>
                                                        <span className='saving-plan-grid-label'>{Config.Locales['duration'] || 'Durée'}:</span>
                                                        <span className='saving-plan-grid-value'>{formatTimeDisplay(v.time)}</span>
                                                        <span className='saving-plan-grid-subtext'>{calculateDeadlineDate(v.time)}</span>
                                                    </div>
                                                    <div className='saving-plan-grid-item flex flex-col'>
                                                        <span className='saving-plan-grid-label'>{Config.Locales['gains'] || 'Gains'}:</span>
                                                        <span className='saving-plan-grid-value' style={{ color: v.color }}>
                                                            ${FormatMoney(v.cost * (1 + v.percent / 100))}
                                                        </span>
                                                        <span className='saving-plan-grid-subtext'>+{v.percent}%</span>
                                                    </div>
                                                </div>
                                                <button className='saving-plan-buy-btn' onClick={() => BuySavingAccount(v.name)}>
                                                    <i className="fa-duotone fa-solid fa-shopping-cart"></i>
                                                    <span>{Config.Locales['buy'] || 'Buy'} - ${FormatMoney(v.cost)}</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                )
                            })}
                    </div>
                </div>
            </div>
        </div>
    )
}

export default SavingAccount

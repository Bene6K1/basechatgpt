import React, { useState, useMemo, useEffect } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { FormatMoney } from '../../store/configSlice2'
import postNUI from '../../hooks/postNUI'
import './Enterprise.css'
import CardCorners from "../../components/CardCorners"

function Enterprise() {
    const Config = useSelector((store) => store.config)
    const dispatch = useDispatch()
    const [selectedEnterprise, setSelectedEnterprise] = useState(null)
    const [actionAmount, setActionAmount] = useState('')
    const [ActiveActionMenu, setActiveActionMenu] = useState('withdraw')
    const [searchTerm, setSearchTerm] = useState('')

    // Select first enterprise by default when data loads
    useEffect(() => {
        if (Config.EnterpriseAccounts && Config.EnterpriseAccounts.length > 0 && !selectedEnterprise) {
            setSelectedEnterprise(Config.EnterpriseAccounts[0])
        }
    }, [Config.EnterpriseAccounts])

    const handleSelectEnterprise = (enterprise) => {
        setSelectedEnterprise(enterprise)
        setActionAmount('')
    }

    const handleActionMenuClick = (actionName) => {
        setActiveActionMenu(actionName)
        setActionAmount('')
    }

    const handleConfirm = () => {
        const amount = parseInt(actionAmount)
        if (isNaN(amount) || amount <= 0 || !selectedEnterprise) {
            return
        }

        if (ActiveActionMenu === 'deposit') {
            if (Config.PlayerInformation.Cash < amount) {
                return
            }
            postNUI('EnterpriseDeposit', {
                amount: amount,
                jobName: selectedEnterprise.jobName
            })
        } else if (ActiveActionMenu === 'withdraw') {
            if (selectedEnterprise.balance < amount) {
                return
            }
            postNUI('EnterpriseWithdraw', {
                amount: amount,
                jobName: selectedEnterprise.jobName
            })
        }

        setActionAmount('')
    }

    // Filter transactions by search term
    const filteredTransactions = useMemo(() => {
        if (!selectedEnterprise?.transactions) return []
        const transactions = [...selectedEnterprise.transactions].reverse()
        if (!searchTerm) return transactions
        return transactions.filter(t =>
            t.label?.toLowerCase().includes(searchTerm.toLowerCase()) ||
            t.description?.toLowerCase().includes(searchTerm.toLowerCase()) ||
            t.playerName?.toLowerCase().includes(searchTerm.toLowerCase())
        )
    }, [selectedEnterprise, searchTerm])

    // No enterprises available
    if (!Config.EnterpriseAccounts || Config.EnterpriseAccounts.length === 0) {
        return (
            <div className='enterprise w-full h-full flex flex-col items-center justify-center theme-animate-in card-with-corners'>
                <CardCorners color="rgba(255, 255, 255, 0.5)" />
                <div className='enterprise-empty flex flex-col items-center justify-center'>
                    <i className="fa-duotone fa-solid fa-building enterprise-empty-icon"></i>
                    <span className='enterprise-empty-title'>{Config.Locales['no_enterprise'] || 'Aucune Entreprise'}</span>
                    <span className='enterprise-empty-text'>{Config.Locales['no_enterprise_text'] || "Vous n'avez accès à aucun compte entreprise."}</span>
                </div>
            </div>
        )
    }

    return (
        <div className='enterprise w-full h-full flex flex-col theme-animate-in card-with-corners'>
            <CardCorners color="rgba(255, 255, 255, 0.5)" />

            {/* Header Section */}
            <div className='flex flex-row items-center justify-between'>
                <div className='enterprise-header-left flex items-center'>
                    <div className='enterprise-header-iconDiv flex items-center justify-center'>
                        <i className="fa-duotone fa-solid fa-building"></i>
                    </div>
                    <div className='enterprise-header-titles flex flex-col'>
                        <span className='enterprise-header-title'>{Config.Locales['enterprise_accounts'] || 'Comptes Entreprises'}</span>
                        <span className='enterprise-header-subtitle'>{Config.Locales['enterprise_subtitle'] || 'Gestion des comptes de vos entreprises'}</span>
                    </div>
                </div>
                <div className='enterprise-header-right flex items-center'>
                    <div className='enterprise-header-balance flex flex-col items-end'>
                        <span className='enterprise-header-balance-label'>Cash Personnel</span>
                        <span className='enterprise-header-balance-value'>${FormatMoney(Config.PlayerInformation.Cash || 0)}</span>
                    </div>
                    <div className='enterprise-header-iconDiv flex items-center justify-center'>
                        <i className="fa-duotone fa-solid fa-wallet"></i>
                    </div>
                </div>
            </div>

            {/* Main Content */}
            <div className='enterprise-content flex flex-row flex-1 overflow-hidden'>
                {/* Left Column - Enterprise List */}
                <div className='enterprise-content-left card-with-corners flex flex-col'>
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className='enterprise-section-header flex items-center'>
                        <div className='enterprise-section-iconDiv flex items-center justify-center'>
                            <i className="fa-duotone fa-solid fa-list"></i>
                        </div>
                        <div className='enterprise-section-titles flex flex-col'>
                            <span className='enterprise-section-title'>{Config.Locales['your_enterprises'] || 'Vos Entreprises'}</span>
                            <span className='enterprise-section-subtitle'>{Config.Locales['select_enterprise'] || 'Selectionnez une entreprise'}</span>
                        </div>
                    </div>

                    <div className='enterprise-list flex flex-col overflow-y-auto theme-scrollbar flex-1'>
                        {Config.EnterpriseAccounts.map((enterprise, k) => (
                            <div
                                key={k}
                                className={`enterprise-list-item flex items-center cursor-pointer ${selectedEnterprise?.jobName === enterprise.jobName ? 'enterprise-list-item-active' : ''}`}
                                onClick={() => handleSelectEnterprise(enterprise)}
                            >
                                <div className='enterprise-list-item-icon flex items-center justify-center'>
                                    <i className="fa-duotone fa-solid fa-building"></i>
                                </div>
                                <div className='enterprise-list-item-info flex flex-col flex-1'>
                                    <span className='enterprise-list-item-name'>{enterprise.label}</span>
                                    <span className='enterprise-list-item-role'>{enterprise.gradeLabel || 'Boss'}</span>
                                </div>
                                <div className='enterprise-list-item-balance flex flex-col items-end'>
                                    <span className='enterprise-list-item-balance-value'>${FormatMoney(enterprise.balance)}</span>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                {/* Right Column - Selected Enterprise Details */}
                <div className='enterprise-content-right flex flex-col flex-1 overflow-hidden'>
                    {selectedEnterprise ? (
                        <>
                            {/* Enterprise Balance Card */}
                            <div className='enterprise-balance-card card-with-corners flex flex-col'>
                                <CardCorners color="rgba(255, 255, 255, 0.5)" />
                                <div className='flex flex-row items-center justify-between'>
                                    <div className='enterprise-balance-info flex items-center'>
                                        <div className='enterprise-balance-iconDiv flex items-center justify-center'>
                                            <i className="fa-duotone fa-solid fa-vault"></i>
                                        </div>
                                        <div className='enterprise-balance-titles flex flex-col'>
                                            <span className='enterprise-balance-title'>{selectedEnterprise.label}</span>
                                            <span className='enterprise-balance-subtitle'>{Config.Locales['society_account'] || 'Compte de la Societe'}</span>
                                        </div>
                                    </div>
                                    <div className='enterprise-balance-amount-container'>
                                        <span className='enterprise-balance-amount'>${FormatMoney(selectedEnterprise.balance)}</span>
                                    </div>
                                </div>
                            </div>

                            {/* Actions Section */}
                            <div className='enterprise-actions card-with-corners flex flex-col'>
                                <CardCorners color="rgba(255, 255, 255, 0.5)" />
                                <div className='enterprise-section-header flex items-center'>
                                    <div className='enterprise-section-iconDiv flex items-center justify-center'>
                                        <i className="fa-duotone fa-solid fa-money-bill-transfer"></i>
                                    </div>
                                    <div className='enterprise-section-titles flex flex-col'>
                                        <span className='enterprise-section-title'>{Config.Locales['actions'] || 'Actions'}</span>
                                        <span className='enterprise-section-subtitle'>{Config.Locales['deposit_withdraw_enterprise'] || 'Deposer ou retirer de l\'argent'}</span>
                                    </div>
                                </div>

                                {/* Action Buttons */}
                                <div className='flex enterprise-actions-buttons'>
                                    <button
                                        className={`flex-1 enterprise-actions-button font-medium ${ActiveActionMenu === 'withdraw' ? 'enterprise-actions-button-active' : ''}`}
                                        onClick={() => handleActionMenuClick('withdraw')}
                                    >
                                        {Config.Locales['withdraw'] || 'Retirer'}
                                    </button>
                                    <button
                                        className={`flex-1 enterprise-actions-button font-medium ${ActiveActionMenu === 'deposit' ? 'enterprise-actions-button-active' : ''}`}
                                        onClick={() => handleActionMenuClick('deposit')}
                                    >
                                        {Config.Locales['deposit'] || 'Deposer'}
                                    </button>
                                </div>

                                {/* Input Fields */}
                                <div className='flex items-center enterprise-actions-amountrow'>
                                    <div
                                        className='flex items-center enterprise-actions-inputrow flex-1'
                                        style={{
                                            background: 'rgba(255,255,255,0.03)',
                                            border: '1px solid rgba(255,255,255,0.08)',
                                        }}
                                    >
                                        <div
                                            className='enterprise-actions-inputicon flex items-center justify-center'
                                            style={{ background: 'rgba(255,255,255,0.05)' }}
                                        >
                                            <i
                                                className='fa-duotone fa-solid fa-dollar-sign enterprise-actions-inputicon-icon'
                                                style={{ color: 'white' }}
                                            ></i>
                                        </div>
                                        <input
                                            type='number'
                                            className='flex-1 bg-transparent border-none outline-none text-white enterprise-actions-input'
                                            placeholder='Montant'
                                            value={actionAmount}
                                            onChange={(e) => setActionAmount(e.target.value.replace(/[^0-9]/g, ''))}
                                            style={{ fontFamily: 'Geist, sans-serif' }}
                                        />
                                    </div>
                                    <button
                                        className='enterprise-actions-confirm font-semibold uppercase transition-all'
                                        onClick={handleConfirm}
                                    >
                                        {Config.Locales['confirm'] || 'Confirmer'}
                                    </button>
                                </div>
                            </div>

                            {/* Transactions Section */}
                            <div className='enterprise-transactions card-with-corners flex flex-col flex-1 overflow-hidden'>
                                <CardCorners color="rgba(255, 255, 255, 0.5)" />
                                <div className='enterprise-section-header flex items-center justify-between'>
                                    <div className='flex items-center'>
                                        <div className='enterprise-section-iconDiv flex items-center justify-center'>
                                            <i className="fa-duotone fa-solid fa-clock-rotate-left"></i>
                                        </div>
                                        <div className='enterprise-section-titles flex flex-col'>
                                            <span className='enterprise-section-title'>{Config.Locales['transactions_history'] || 'Historique'}</span>
                                            <span className='enterprise-section-subtitle'>{Config.Locales['enterprise_transactions_subtitle'] || 'Transactions recentes'}</span>
                                        </div>
                                    </div>
                                    <div className='enterprise-search-container'>
                                        <i className="fa-duotone fa-solid fa-search enterprise-search-icon"></i>
                                        <input
                                            type='text'
                                            className='enterprise-search-input'
                                            placeholder={Config.Locales['search'] || 'Rechercher...'}
                                            value={searchTerm}
                                            onChange={(e) => setSearchTerm(e.target.value)}
                                        />
                                    </div>
                                </div>

                                <div className='enterprise-transactions-list flex flex-col overflow-y-auto theme-scrollbar flex-1'>
                                    {filteredTransactions.length > 0 ? (
                                        filteredTransactions.map((transaction, k) => (
                                            <div key={k} className='enterprise-transaction-item flex items-center'>
                                                <div
                                                    className='enterprise-transaction-icon flex items-center justify-center'
                                                    style={{
                                                        background: transaction.type === 'add' ? '#fafafa1a' : '#c507171a'
                                                    }}
                                                >
                                                    <i
                                                        className={`fa-duotone fa-solid ${transaction.type === 'add' ? 'fa-arrow-down' : 'fa-arrow-up'}`}
                                                        style={{
                                                            color: transaction.type === 'add' ? 'white' : '#CD412C'
                                                        }}
                                                    ></i>
                                                </div>
                                                <div className='enterprise-transaction-info flex flex-col flex-1'>
                                                    <span className='enterprise-transaction-label'>{transaction.label}</span>
                                                    <span className='enterprise-transaction-description'>
                                                        {transaction.playerName && `${transaction.playerName} - `}{transaction.date}
                                                    </span>
                                                </div>
                                                <span
                                                    className='enterprise-transaction-amount'
                                                    style={{
                                                        color: transaction.type === 'add' ? 'white' : '#CD412C'
                                                    }}
                                                >
                                                    {transaction.type === 'add' ? '+' : '-'}${FormatMoney(transaction.amount)}
                                                </span>
                                            </div>
                                        ))
                                    ) : (
                                        <div className='enterprise-empty-small flex flex-col items-center justify-center'>
                                            <i className="fa-duotone fa-solid fa-clock-rotate-left enterprise-empty-icon-small"></i>
                                            <span className='enterprise-empty-text-small'>{Config.Locales['no_transactions'] || 'Aucune transaction'}</span>
                                        </div>
                                    )}
                                </div>
                            </div>
                        </>
                    ) : (
                        <div className='enterprise-empty flex flex-col items-center justify-center flex-1'>
                            <i className="fa-duotone fa-solid fa-hand-pointer enterprise-empty-icon"></i>
                            <span className='enterprise-empty-title'>{Config.Locales['select_enterprise_title'] || 'Selectionnez une entreprise'}</span>
                            <span className='enterprise-empty-text'>{Config.Locales['select_enterprise_text'] || 'Choisissez une entreprise dans la liste pour voir les details'}</span>
                        </div>
                    )}
                </div>
            </div>
        </div>
    )
}

export default Enterprise

import React, { useState } from 'react'
import { useSelector } from 'react-redux'
import { FormatMoney } from '../../store/configSlice2'
import postNUI from '../../hooks/postNUI'
import './Transactions.css'
import CardCorners from "../../components/CardCorners";

function Transactions() {
    const Config = useSelector((store) => store.config)
    const [searchTerm, setSearchTerm] = useState('')

    const filteredTransactions = Config.Transactions.filter(transaction => {
        const searchLower = searchTerm.toLowerCase()
        return (
            transaction.label?.toLowerCase().includes(searchLower) ||
            transaction.date?.toLowerCase().includes(searchLower) ||
            transaction.description?.toLowerCase().includes(searchLower) ||
            transaction.amount?.toString().includes(searchLower) ||
            transaction.transferDescription?.toLowerCase().includes(searchLower)
        )
    })

    const getTransactionIcon = (source) => {
        switch(source) {
            case 'transfer-income':
            case 'transfer-given':
                return 'fa-right-left'
            case 'deposit':
                return 'fa-arrow-down'
            case 'withdraw':
                return 'fa-arrow-up'
            case 'credit':
                return 'fa-landmark'
            case 'saving':
                return 'fa-piggy-bank'
            default:
                return 'fa-building-columns'
        }
    }

    const getTransactionType = (source, type) => {
        switch(source) {
            case 'transfer-income':
                return Config.Locales['transfer_received'] || 'Virement (Reçu)'
            case 'transfer-given':
                return Config.Locales['transfer_sent'] || 'Virement (Envoyé)'
            case 'deposit':
                return Config.Locales['deposit'] || 'Déposer'
            case 'withdraw':
                return Config.Locales['withdraw'] || 'Retirer'
            case 'credit':
                return type === 'add' ? (Config.Locales['credit_received'] || 'Crédit reçu') : (Config.Locales['credit_payment'] || 'Paiement crédit')
            case 'saving':
                return type === 'add' ? (Config.Locales['saving_received'] || 'Épargne reçue') : (Config.Locales['saving_deposit'] || 'Dépôt épargne')
            default:
                return source || 'Transaction'
        }
    }

    return (
        <div className='w-full h-full flex flex-col transactions theme-animate-in'>
            <CardCorners color="rgba(255, 255, 255, 0.5)" />
            {/* Header */}
            <div className='transactions-header'>
                <div className='transactions-header-left'>
                    <div className='transactions-header-iconDiv'>
                        <i className="fa-duotone fa-solid fa-right-left"></i>
                    </div>
                    <div className='transactions-header-titles'>
                        <span className='transactions-title'>{Config.Locales['transactions_history'] || 'Historique des Transactions'}</span>
                        <span className='transactions-subtitle'>{Config.Locales['transactions_subtitle'] || 'Historique de vos transactions'}</span>
                    </div>
                </div>
                {filteredTransactions.length > 0 && Config.PlayerInformation.AccountOwner && (
                    <div
                        className='flex items-center bankContainerLeftSidebar-leaveBtn cursor-pointer transition-all mt-auto'
                        onClick={() => { postNUI('clearTransactions') }}
                    >
                        <div className='flex items-center justify-center transactions-leaveBtn-iconDiv'>
                            <i className="fa-duotone fa-solid fa-trash transactions-leaveBtn-icon" style={{ color: '#c50717' }}></i>
                        </div>
                        <span className='transactions-leaveBtn-text'>Tout effacer</span>
                    </div>
                )}
            </div>

            {/* Search */}
            <div className='transactions-search'>
                <div className='transactions-search-iconDiv'>
                    <i className="fa-duotone fa-solid fa-magnifying-glass"></i>
                </div>
                <input
                    type='text'
                    className='transactions-search-input'
                    placeholder={Config.Locales['search_transactions'] || 'Rechercher...'}
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                />
            </div>

            {/* Table */}
            <div className='transactions-table-wrapper'>
                {filteredTransactions.length > 0 ? (
                    <table className='transactions-table'>
                        <thead>
                            <tr>
                                <th>{Config.Locales['transaction'] || 'TRANSACTIONS'}</th>
                                <th>{Config.Locales['date'] || 'DATE'}</th>
                                <th>{Config.Locales['type'] || 'TYPE'}</th>
                                <th style={{ textAlign: 'right' }}>{Config.Locales['amount'] || 'MONTANT'}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredTransactions.slice().reverse().map((v, k) => (
                                <tr key={k} className={v.type === 'add' ? 'transaction-positive' : 'transaction-negative'}>
                                    <td>
                                        <div className='transaction-cell'>
                                            <div
                                                className='transaction-cell-icon'
                                                style={{
                                                    background: v.type === 'add' ? '#fafafa1a' : '#c507171a'
                                                }}
                                            >
                                                <i
                                                    className={`fa-duotone fa-solid ${getTransactionIcon(v.source)}`}
                                                    style={{ color: v.type === 'add' ? 'white' : 'CD412C' }}
                                                ></i>
                                            </div>
                                            <span className='transaction-cell-label'>{v.label}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span className='transaction-date'>{v.date}</span>
                                    </td>
                                    <td>
                                        <span className='transaction-type'>{getTransactionType(v.source, v.type)}</span>
                                    </td>
                                    <td style={{ textAlign: 'right' }}>
                                        <span
                                            className='transaction-amount'
                                            style={{ color: v.type === 'add' ? 'white' : '#CD412C' }}
                                        >
                                            {v.type === 'add' ? '+' : '-'}{FormatMoney(v.amount)}$
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                ) : (
                    <div className='transactions-empty card-with-corners'>
                        <CardCorners color="rgba(255, 255, 255, 0.5)" />
                        <i className="fa-duotone fa-solid fa-receipt"></i>
                        <span className='transactions-empty-title'>{Config.Locales['no_transactions'] || 'Aucune transaction'}</span>
                        <span className='transactions-empty-text'>
                            Les transactions apparaîtront ici une fois que vous effectuerez des opérations bancaires.
                        </span>
                    </div>
                )}
            </div>
        </div>
    )
}

export default Transactions

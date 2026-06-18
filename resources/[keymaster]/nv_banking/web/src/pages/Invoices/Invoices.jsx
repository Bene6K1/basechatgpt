import React, { useState } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { FormatMoney, showErrorNotification } from '../../store/configSlice2'
import postNUI from '../../hooks/postNUI'
import './Invoices.css'

function Invoices() {
    const Config = useSelector((store) => store.config)
    const dispatch = useDispatch()
    const [searchTerm, setSearchTerm] = useState('')

    const filteredInvoices = Config.Invoices.filter(invoice => {
        const searchLower = searchTerm.toLowerCase()
        return (
            invoice.label?.toLowerCase().includes(searchLower) ||
            invoice.date?.toLowerCase().includes(searchLower) ||
            invoice.description?.toLowerCase().includes(searchLower) ||
            invoice.amount?.toString().includes(searchLower)
        )
    })

    const handlePayInvoice = (invoice) => {
        if (Config.PlayerInformation.Balance >= invoice.amount) {
            postNUI('PayInvoice', invoice)
        } else {
            dispatch(showErrorNotification('Error', Config.Locales['insufficient_balance']))
        }
    }

    const totalAmount = Config.Invoices.reduce((sum, inv) => sum + (inv.amount || 0), 0)

    return (
        <div className='w-full h-full flex flex-col theme-container invoices theme-animate-in'>
            {/* Header */}
            <div className='invoices-header'>
                <div className='invoices-header-left'>
                    <div className='invoices-header-iconDiv'>
                        <i className="fa-duotone fa-solid fa-file-invoice"></i>
                    </div>
                    <div className='invoices-header-titles'>
                        <span className='invoices-title'>{Config.Locales['invoices'] || 'Factures'}</span>
                        <span className='invoices-subtitle'>{Config.Locales['invoices_subtitle'] || 'Factures en attente de paiement'}</span>
                    </div>
                </div>
                {Config.Invoices.length > 0 && (
                    <div className='invoices-stats'>
                        <div className='invoices-stat'>
                            <span className='invoices-stat-label'>{Config.Locales['pending'] || 'En attente'}</span>
                            <span className='invoices-stat-value'>{Config.Invoices.length}</span>
                        </div>
                        <div className='invoices-stat'>
                            <span className='invoices-stat-label'>{Config.Locales['total'] || 'Total'}</span>
                            <span className='invoices-stat-value'>{FormatMoney(totalAmount)}$</span>
                        </div>
                    </div>
                )}
            </div>

            {/* Search */}
            {Config.Invoices.length > 0 && (
                <div className='invoices-search'>
                    <div className='invoices-search-iconDiv'>
                        <i className="fa-duotone fa-solid fa-magnifying-glass"></i>
                    </div>
                    <input
                        type='text'
                        className='invoices-search-input'
                        placeholder={Config.Locales['search_invoices'] || 'Rechercher une facture...'}
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                </div>
            )}

            {/* Table */}
            <div className='invoices-table-wrapper'>
                {filteredInvoices.length > 0 ? (
                    <table className='invoices-table'>
                        <thead>
                            <tr>
                                <th>{Config.Locales['invoice'] || 'FACTURE'}</th>
                                <th>{Config.Locales['date'] || 'DATE'}</th>
                                <th>{Config.Locales['description'] || 'DESCRIPTION'}</th>
                                <th style={{ textAlign: 'right' }}>{Config.Locales['amount'] || 'MONTANT'}</th>
                                <th style={{ textAlign: 'right' }}>{Config.Locales['action'] || 'ACTION'}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredInvoices.map((v, k) => (
                                <tr key={k}>
                                    <td>
                                        <div className='invoice-cell'>
                                            <div className='invoice-cell-icon'>
                                                <i className="fa-duotone fa-solid fa-file-invoice"></i>
                                            </div>
                                            <span className='invoice-cell-label'>{v.label}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span className='invoice-date'>{v.date}</span>
                                    </td>
                                    <td>
                                        <span className='invoice-description'>{v.description}</span>
                                    </td>
                                    <td style={{ textAlign: 'right' }}>
                                        <span className='invoice-amount'>{FormatMoney(v.amount)}$</span>
                                    </td>
                                    <td style={{ textAlign: 'right' }}>
                                        <button
                                            className='invoice-pay-btn'
                                            onClick={() => handlePayInvoice(v)}
                                        >
                                            <i className="fa-duotone fa-solid fa-credit-card"></i>
                                            <span>{Config.Locales['pay'] || 'Payer'}</span>
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                ) : (
                    <div className='invoices-empty theme-container'>
                        <i className="fa-duotone fa-solid fa-file-invoice"></i>
                        <span className='invoices-empty-title'>{Config.Locales['no_invoices'] || 'Aucune facture'}</span>
                        <span className='invoices-empty-text'>
                            {Config.Locales['no_invoices_text'] || 'Vous n\'avez aucune facture en attente de paiement.'}
                        </span>
                    </div>
                )}
            </div>
        </div>
    )
}

export default Invoices

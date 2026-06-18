import { useEffect, useCallback } from 'react'
import { useDispatch } from 'react-redux'
import {
    setShow,
    setLocales,
    updatePlayerInformation,
    setScreen,
    setSetupStates,
    updateTransactions,
    updateInvoices,
    showNotification,
    setATMScreen,
    setHackSettings,
    updateEnterpriseAccounts,
    updateEnterpriseBalance,
    updateEnterpriseTransactions
} from '../store/configSlice'

export const eventListener = () => {
    const dispatch = useDispatch()

    const handleMessage = useCallback((event) => {
        const data = event.data
        switch (data.action) {
            case 'Setup':
                dispatch(setSetupStates({
                    credits: data.credits,
                    savingAccounts: data.savingaccounts,
                    fastActions: data.fastactions,
                    locales: data.locales
                }))
                dispatch(setHackSettings(data.hacksettings))
                break
            case 'CreateAccount':
                dispatch(updatePlayerInformation({
                    updates: {
                        Firstname: data.data.Firstname,
                        Lastname: data.data.Lastname
                    }
                }))
                dispatch(setShow(true))
                dispatch(setScreen('bankAgreement'))
                break
            case 'OpenBank':
                dispatch(updatePlayerInformation({ replace: data.PlayerInformation }))

                if (data.Transactions && Array.isArray(data.Transactions)) {
                    dispatch(updateTransactions(data.Transactions))
                } else {
                    dispatch(updateTransactions([]))
                }

                if (data.Invoices && Array.isArray(data.Invoices)) {
                    dispatch(updateInvoices(data.Invoices))
                } else {
                    dispatch(updateInvoices([]))
                }

                if (data.EnterpriseAccounts && Array.isArray(data.EnterpriseAccounts)) {
                    dispatch(updateEnterpriseAccounts(data.EnterpriseAccounts))
                } else {
                    dispatch(updateEnterpriseAccounts([]))
                }

                dispatch(setShow(true))
                dispatch(setScreen('bank'))
                break
            case 'UpdatePlayerInformation':
                dispatch(updatePlayerInformation({ replace: data.PlayerInformation }))
                
                if (data.Transactions && Array.isArray(data.Transactions)) {
                    dispatch(updateTransactions(data.Transactions))
                } else {
                    dispatch(updateTransactions([]))
                }
                
                if (data.Invoices && Array.isArray(data.Invoices)) {
                    dispatch(updateInvoices(data.Invoices))
                } else {
                    dispatch(updateInvoices([]))
                }
                break
            case 'UpdateTransactions':
                dispatch(updateTransactions(data.data))
                break
            case 'UpdateNotifications':
                dispatch(updatePlayerInformation({ updates: { Notification: data.data } }))
                break
            case 'OpenPlayerAtm':
                dispatch(updatePlayerInformation({ updates: {
                    Firstname: data.data.firstname,
                    Lastname: data.data.lastname,
                    ProfilePicture: data.data.playerpp,
                    IBAN: data.data.iban,
                    AccountExist: data.data.AccountExist
                }}))
                dispatch(setShow(true))
                dispatch(setScreen('atm'))
                dispatch(setATMScreen('existing'))
                break
            case 'OpenATMWithoutAccount':
                dispatch(updatePlayerInformation({ updates: {
                    AccountExist: data.data.AccountExist
                }}))
                dispatch(setShow(true))
                dispatch(setScreen('atm'))
                dispatch(setATMScreen('new'))
                break
            case 'UpdateHackedAccountUI':
                dispatch(updatePlayerInformation({ updates: {
                    Balance: data.data.Balance,
                }}))
                if (data.data.Transactions && Array.isArray(data.data.Transactions)) {
                    dispatch(updateTransactions(data.data.Transactions))
                } else {
                    dispatch(updateTransactions([]))
                }
                break
            case 'UpdateAccountUsedInUI':
                dispatch(updatePlayerInformation({ updates: {
                    AccountUsed: data.data
                }}))
                break
            case 'ShowNotify':
                // Notifications désactivées
                // dispatch(showNotification({
                //     label: data.label,
                //     description: data.description,
                //     type: data.type,
                //     ms: data.ms
                // }))
                break
            case 'CloseUI':
                dispatch(setShow(false))
                postNUI('CloseUI')
                break
            case 'UpdateEnterpriseAccounts':
                if (data.data && Array.isArray(data.data)) {
                    dispatch(updateEnterpriseAccounts(data.data))
                }
                break
            case 'UpdateEnterpriseData':
                if (data.jobName) {
                    dispatch(updateEnterpriseBalance({
                        jobName: data.jobName,
                        balance: data.balance
                    }))
                    if (data.transactions) {
                        dispatch(updateEnterpriseTransactions({
                            jobName: data.jobName,
                            transactions: data.transactions
                        }))
                    }
                }
                break
            default:
                break
        }
    }, [dispatch])

    useEffect(() => {
        window.addEventListener("message", handleMessage)
        return () => window.removeEventListener("message", handleMessage)
    }, [handleMessage])
}
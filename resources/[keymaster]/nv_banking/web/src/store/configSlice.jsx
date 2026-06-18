import { createSlice } from '@reduxjs/toolkit'

export const FormatMoney = (s) => {
    s = parseInt(s);
    return s.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.');
}

const initialState = {
    Show: false,
    Screen: 'atm', // bankAgreement, createPassword, atm, bank
    atmScreen: 'new', // existing, new
    LoanPopupOpen: false, // Track if loan popup is open
    Notification: {
        show: false,
        label: '',
        description: '',
        type: 'success', // success, error
        ms: 3000 // milliseconds to show
    },
    PlayerInformation: {
        Firstname: 'Oph3Z',
        Lastname: 'tete',
        ProfilePicture: './atm/example-pp.png',
        ID: 1,
        IBAN: '4340343',
        Balance: 10000,
        CryptoHoldings: [
            // Example structure:
            {
                symbol: 'BTC',
                name: 'Bitcoin',
                amount: 0.5,
                totalSpent: 1200, // The actually buy price when API working
                buyPrice: 1200, // If api not working, this will help
            },
            {
                symbol: 'ETH',
                name: 'Ethereum',
                amount: 2.5,
                totalSpent: 8000, // The actually buy price when API working
                buyPrice: 3200, // If api not working, this will help
            }
        ],
        ActiveCredits: [
            {name: 'house', remainingDebt: 140000}
        ],
        ActiveSavingAccounts: [
            //{name: "account_1", boughtTime: '28.06.25'}
        ],
        Requests: [
            {sender: '123456', name: 'Yusuf Karaçolak', amount: 100000, pfp: './bank/example-pp.png'},
            {sender: '123456', name: 'Yusuf Karaçolak', amount: 100000, pfp: './bank/example-pp.png'}
        ],
        Notification: [
            {label: 'Notification', description: 'notification'}
        ],
        AccountExist: null,
        AccountOwner: null
    },
    BankName: 'Banque',
    Locales: {},
    Transactions: [
        {type: 'add', action: 'deposit', label: 'Dépôt', date: '01.01.2025', description: 'Description...', transferDescription: 'Ursu Arts - 1234567', amount: 100000, source: 'transfer-income'},
        {type: 'remove', action: 'withdraw', label: 'Retrait', date: '01.01.2025', description: 'Description...', transferDescription: 'Ursu Arts - 1234567', amount: 100000, source: 'transfer-given'},
        {type: 'add', action: 'deposit', label: 'Dépôt', date: '01.01.2025', description: 'Description...', amount: 100000, source: 'deposit'},
        {type: 'remove', action: 'withdraw', label: 'Retrait', date: '01.01.2025', description: 'Description...', amount: 100000, source: 'withdraw'},
        {type: 'add', action: 'deposit', label: 'Dépôt', date: '01.01.2025', description: 'Description...', amount: 100000, source: 'market'},
        {type: 'remove', action: 'withdraw', label: 'Retrait', date: '06.11.2025', description: 'Description...', amount: 100000, source: 'salary'},
        {type: 'add', action: 'deposit', label: 'Dépôt', date: '01.11.2025', description: 'Description...', amount: 100000, source: 'otherexpenses'},
        {type: 'remove', action: 'withdraw', label: 'Retrait', date: '01.7.2025', description: 'Description...', amount: 100000, source: 'sidehustle'}
    ],
    Invoices: [
        {label: 'Test', date: '01.11.2025', description: 'Description test', amount: 1500}
    ],
    Credits: [],
    SavingAccounts: [],
    FastActions: [],
    HackSettings: {},
    EnterpriseAccounts: [],
    SelectedMenu: 0,
}

export const configSlice = createSlice({
    name: 'config',
    initialState,
    reducers: {
        setShow: (state, action) => {
            state.Show = action.payload;
        },

        setScreen: (state, action) => {
            state.Screen = action.payload;
        },

        setATMScreen: (state, action) => {
            state.atmScreen = action.payload;
        },

        setLocales: (state, action) => {
            state.Locales = action.payload;
        },

        setHackSettings: (state, action) => {
            state.HackSettings = action.payload;
        },

        clearTransactions: (state) => {
            state.Transactions = [];
        },

        clearInvoices: (state) => {
            state.Invoices = [];
        },

        removeInvoice: (state, action) => {
            state.Invoices.splice(action.payload, 1);
        },

        updatePlayerCrypto: (state, action) => {
            state.PlayerInformation.CryptoHoldings = action.payload;
        },

        updatePlayerBalance: (state, action) => {
            state.PlayerInformation.Balance = action.payload;
        },

        updatePlayerInformation: (state, action) => {
            const { key, value, updates, replace } = action.payload;
            
            // Komple tabloyu değiştir
            if (replace && typeof replace === 'object') {
                state.PlayerInformation = replace;
                return;
            }
            
            if (key && value !== undefined) {
                if (key in state.PlayerInformation) {
                    state.PlayerInformation[key] = value;
                }
            }
            
            if (updates && typeof updates === 'object') {
                Object.keys(updates).forEach(key => {
                    if (key in state.PlayerInformation) {
                        state.PlayerInformation[key] = updates[key];
                    }
                });
            }
        },

        showNotification: (state, action) => {
            state.Notification = {
                show: true,
                label: action.payload.label || '',
                description: action.payload.description || '',
                type: action.payload.type || 'success',
                ms: action.payload.ms || 3000
            };
        },

        hideNotification: (state) => {
            state.Notification.show = false;
        },

        setSetupStates: (state, action) => {
            const { credits, savingAccounts, fastActions, locales } = action.payload;
            
            if (credits !== undefined) {
                state.Credits = credits;
            }
            
            if (savingAccounts !== undefined) {
                state.SavingAccounts = savingAccounts;
            }
            
            if (fastActions !== undefined) {
                state.FastActions = fastActions;
            }
            
            if (locales !== undefined) {
                state.Locales = locales;
            }
        },

        updateTransactions: (state, action) => {
            state.Transactions = action.payload;
        },

        updateInvoices: (state, action) => {
            state.Invoices = action.payload;
        },

        setLoanPopupOpen: (state, action) => {
            state.LoanPopupOpen = action.payload;
        },

        setSelectedMenu: (state, action) => {
            state.SelectedMenu = action.payload;
        },

        updateEnterpriseAccounts: (state, action) => {
            state.EnterpriseAccounts = action.payload;
        },

        updateEnterpriseBalance: (state, action) => {
            const { jobName, balance } = action.payload;
            const enterprise = state.EnterpriseAccounts.find(e => e.jobName === jobName);
            if (enterprise) {
                enterprise.balance = balance;
            }
        },

        updateEnterpriseTransactions: (state, action) => {
            const { jobName, transactions } = action.payload;
            const enterprise = state.EnterpriseAccounts.find(e => e.jobName === jobName);
            if (enterprise) {
                enterprise.transactions = transactions;
            }
        }
    }
})

export const { setLocales, setShow, clearTransactions, clearInvoices, removeInvoice, updatePlayerCrypto, updatePlayerBalance, updatePlayerInformation, showNotification, hideNotification, setScreen, setSetupStates, updateTransactions, updateInvoices, setLoanPopupOpen, setSelectedMenu, setATMScreen, setHackSettings, updateEnterpriseAccounts, updateEnterpriseBalance, updateEnterpriseTransactions } = configSlice.actions

// Utility functions for easier notification usage
export const showSuccessNotification = (label, description, ms = 3000) => ({
    type: 'config/showNotification',
    payload: { label, description, type: 'success', ms }
})

export const showErrorNotification = (label, description, ms = 4000) => ({
    type: 'config/showNotification',
    payload: { label, description, type: 'error', ms }
})

export default configSlice.reducer
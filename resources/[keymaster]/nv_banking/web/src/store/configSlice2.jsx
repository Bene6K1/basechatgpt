import { createSlice } from '@reduxjs/toolkit'

export const FormatMoney = (s) => {
    s = parseInt(s);
    return s.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.');
}

const initialState = {
    Show: true,
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
    Locales: {
        bankAgreement: {
            header: "Contrat bancaire",
            description: "Ce contrat est conclu entre",
            services: "SERVICES La Banque fournit la gestion de compte, les services bancaires en ligne et les services financiers convenus avec le Client",
            customer: {
                header: "Responsabilités du client",
                provide: "Fournir des informations exactes.",
                usage: "Utiliser les services légalement.",
                notify: "Notifier la banque des transactions non autorisées."
            },
            account: {
                header: "Ouverture de compte et informations",
                description: "Le Client s'engage à fournir des informations exactes et complètes pour la configuration du compte et à informer rapidement la Banque en cas de changement."
            },
            banking: {
                header: "Services bancaires",
                description: "La Banque fournit des services de compte, des virements de fonds, des prêts et d'autres services financiers."
            },
            functions: {
                header: "Dépôts et retraits",
                description: "La Banque accepte les dépôts en espèces, par chèque ou par voie électronique."
            },
            security: {
                header: "Sécurité et prévention de la fraude",
                description: "Le Client est responsable de la protection des informations d'identification du compte."
            }
        },
        createPassword: {
            header: "Créer un mot de passe pour",
            secondheader: "votre compte",
            description: "Pour vous inscrire dans notre système, vous devez créer un mot de passe à 6 chiffres.",
            button_text: "Créer un mot de passe"
        },
        atm: {
            header: "Connectez-vous pour accéder",
            secondheader: "à votre compte",
            description: "Vérifiez vos informations avant de vous connecter.",
            another_account: "Pas votre compte ? Changer de compte",
            have_account: "Vous avez déjà un compte ? Connexion"
        },
        and: "et",
        firstname: "Prénom",
        lastname: "Nom",
        signature: "Signature",
        click_to_sign: "Cliquez pour signer !",
        validate: "Valider",
        login: "Connexion",
        id: "ID",
        last_transactions: "Dernières Transactions",
        general_balance: "Solde Général",
        dashboard: "Tableau de bord",
        transaction: "Transactions",
        invoices: "Factures",
        loans: "Prêts",
        saving_account: "Compte Épargne",
        crypto_market: "Marché Crypto",
        society: "Société",
        settings: "Paramètres",
        deposit: "Déposer",
        withdraw: "Retirer",
        transfer: "Virement",
        request: "Demande",
        iban_prefix: "IBAN : #",
        cash_label: "Espèces :",
        no_transactions: "Vous n'avez aucune transaction",
        account_hacked: "Votre compte a été piraté. Changez le mot de passe.",
        need_account_owner: "Vous devez être le propriétaire du compte pour accéder à cette fonctionnalité.",
        error: "Erreur",
        success: "Succès",
        write_password: "Entrez votre mot de passe.",
        write_iban: "Entrez votre IBAN.",
        create_6digit_password: "Veuillez entrer un mot de passe à 6 chiffres.",
        analytics_dashboard: "Tableau de bord analytique",
        fast_actions: "Actions Rapides",
        revenue_analytics: "Analyse des revenus",
        income: "Revenus",
        expenses: "Dépenses",
        deposit_money: "Déposer de l'argent",
        deposit_description: "Vous pouvez même déposer de l'argent avec nos boutons d'action rapide.",
        fast_actions_deposit: "Actions Rapides",
        make_quick_deposit: "Effectuez un dépôt rapide.",
        manual: "Manuel",
        deposit_manual_description: "Déposez autant d'argent que vous le souhaitez.",
        clear: "Effacer",
        withdraw_money: "Retirer de l'argent",
        withdraw_description: "Vous pouvez même retirer de l'argent avec nos boutons d'action rapide.",
        fast_actions_withdraw: "Actions Rapides",
        make_quick_withdraw: "Effectuez un retrait rapide.",
        withdraw_manual_description: "Retirez autant d'argent que vous le souhaitez.",
        send_money_to_others: "Envoyer de l'argent à d'autres",
        transfer_description: "Vous pouvez envoyer de l'argent à d'autres personnes par leur ID ou IBAN.",
        request_money: "Demander de l'argent",
        request_description: "Vous pouvez demander de l'argent à d'autres personnes par leur ID ou IBAN.",
        not_enough_cash: "Vous n'avez pas assez d'argent sur vous.",
        not_enough_balance: "Vous n'avez pas assez d'argent sur votre compte bancaire.",
        successfully_deposited: "Argent déposé avec succès.",
        successfully_withdrawn: "Argent retiré avec succès.",
        iban: "IBAN",
        description: "Description",
        happy_birthday_placeholder: "Joyeux anniversaire...",
        enter_iban_or_id: "Veuillez entrer un IBAN ou un ID.",
        enter_description: "Veuillez entrer une description.",
        enter_valid_amount: "Veuillez entrer un montant valide.",
        need_account_owner_feature: "Vous devez être le propriétaire du compte pour accéder à cette fonctionnalité.",
        transfer_received: "Virement (Reçu)",
        transfer_given: "Virement (Envoyé)",
        salary: "Salaire",
        market: "Marché",
        side_hustle: "Revenu Secondaire",
        other_expenses: "Autres Dépenses",
        search: "Rechercher...",
        pay: "Payer",
        insufficient_balance: "Solde insuffisant pour payer cette facture",
        no_invoices: "Vous n'avez aucune facture",
        credit_point: "Score de Crédit",
        unpaid_debt: "Dette impayée",
        pay_all: "Tout payer",
        active_credits: "Prêts actifs",
        total_payback_amount: "Montant total à rembourser :",
        deadline_for_payback: "Date limite de remboursement :",
        remaining_debt: "Dette Restante",
        amount_you_will_get: "Le montant reçu :",
        amount_you_will_payback: "Le montant à rembourser :",
        pay_all_button: "Tout payer",
        pay_part: "Payer une partie",
        week: "Semaine",
        remaining_time: "Temps Restant :",
        invested_amount: "Montant Investi :",
        your_earnings: "Vos Gains :",
        delete_investment_account: "SUPPRIMER LE COMPTE D'INVESTISSEMENT",
        no_active_investment: "Vous n'avez pas encore de compte d'investissement actif.",
        investment_account_types: "Types de Comptes d'Investissement",
        buy: "Acheter",
        day: "Jour",
        days: "Jours",
        hour: "Heure",
        hours: "Heures",
        money_earned: "Argent Reçu",
        money_earned_desc: "Montant total que vous avez reçu.",
        money_spent: "Argent Dépensé",
        money_spent_desc: "Montant total que vous avez dépensé.",
        money_sent: "Argent Envoyé",
        money_sent_desc: "Montant total que vous avez transféré.",
        monthly_spending: "Dépenses Mensuelles",
        monthly_spending_desc: "Montant moyen que vous avez dépensé ce mois-ci.",
        per_month: "/mois",
        change_password: "Changer le Mot de Passe",
        enter_password: "Entrez le mot de passe",
        confirm: "Confirmer",
        incoming_requests: "Demandes Reçues",
        user_requested_money: "L'utilisateur demande ${amount} de votre part.",
        accept: "Accepter",
        reject: "Refuser",
        no_requests: "Il n'y a pas encore de demandes.",
        notifications: "Notifications",
        clear_all: "Tout Effacer",
        transactions_history: "Historique des Transactions",
        search_transactions: "Rechercher...",
        january: "Janvier",
        february: "Février",
        march: "Mars",
        april: "Avril",
        may: "Mai",
        june: "Juin",
        july: "Juillet",
        august: "Août",
        september: "Septembre",
        october: "Octobre",
        november: "Novembre",
        december: "Décembre",
        from: "De",
        to: "À"
    },
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
    SelectedMenu: 0
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

export const { setLocales, setShow, clearTransactions, clearInvoices, removeInvoice, updatePlayerCrypto, updatePlayerBalance, updatePlayerInformation, showNotification, hideNotification, setScreen, setSetupStates, updateTransactions, updateInvoices, setLoanPopupOpen, setATMScreen, setHackSettings, setSelectedMenu, updateEnterpriseAccounts, updateEnterpriseBalance, updateEnterpriseTransactions } = configSlice.actions

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
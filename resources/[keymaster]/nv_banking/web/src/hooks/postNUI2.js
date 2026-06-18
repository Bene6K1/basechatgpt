var resourceName = "oph3z-bank";

if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}

// Détecte si on est dans FiveM ou en dev web
const isDev = !window.invokeNative;

// État mutable pour simuler les changements de données
let mockState = {
    balance: 147832.50,
    cash: 3245,
    creditPoint: 2850,
    transactions: [],
    invoices: [
        { label: 'Amende LSPD', date: '24.11.2025', description: 'Excès de vitesse - 45 km/h au-dessus', amount: 1500 },
        { label: 'Facture Hôpital', date: '22.11.2025', description: 'Soins médicaux - Pillbox Medical', amount: 2340 },
        { label: 'Taxe Véhicule', date: '20.11.2025', description: 'Taxe annuelle - Benefactor Schafter', amount: 850 },
        { label: 'Assurance Auto', date: '18.11.2025', description: 'Prime mensuelle - Mors Mutual', amount: 450 },
        { label: 'Facture Eau', date: '15.11.2025', description: 'Consommation mensuelle', amount: 127 }
    ],
    activeCredits: [],
    activeSavingAccounts: [],
    requests: [],
    notifications: [],
    accountUsed: { loginlimit: 3, withdrawlimit: 5000 }
};

// Configuration mock (simule Config.lua)
const mockConfig = {
    credits: [
        { name: 'house', label: 'Crédit Immobilier', description: 'Ce crédit est parfait pour vous si vous cherchez une maison.', requiredCreditPoint: 2000, price: 300000, paybackPercent: 1.2, paybackTime: 1, color: '#FF3868' },
        { name: 'vehicle', label: 'Crédit Automobile', description: 'Possédez votre première voiture grâce à la banque de Los Santos !', requiredCreditPoint: 300, price: 50000, paybackPercent: 1.2, paybackTime: 1, color: '#FF3868' },
        { name: 'business', label: 'Crédit Professionnel', description: 'Lancez votre entreprise en créant votre société avec ce prêt', requiredCreditPoint: 1000, price: 100000, paybackPercent: 1.2, paybackTime: 1, color: '#FF3868' }
    ],
    savingAccounts: [
        { name: 'account_1', label: 'Épargne Court Terme', description: '10% de Gains', cost: 100000, time: 48, percent: 10, color: '#F25975' },
        { name: 'account_2', label: 'Épargne Long Terme', description: '30% de Gains', cost: 100000, time: 124, percent: 30, color: '#F25975' },
        { name: 'account_3', label: 'Plan Débutant', description: '5% de Gains', cost: 50000, time: 24, percent: 5, color: '#4CAF50' },
        { name: 'account_4', label: 'Investissement Moyen Terme', description: '20% de Gains', cost: 150000, time: 72, percent: 20, color: '#2196F3' },
        { name: 'account_5', label: 'Plan Investissement VIP', description: '50% de Gains', cost: 500000, time: 168, percent: 50, color: '#9C27B0' }
    ],
    fastActions: [100, 500, 1000, 5000],
    locales: {
        // Objets imbriqués requis
        bankAgreement: {
            header: 'Contrat bancaire',
            description: 'Ce contrat est conclu entre',
            services: 'SERVICES La Banque fournit la gestion de compte, les services bancaires en ligne et les services financiers convenus avec le Client',
            customer: { header: 'Responsabilités du client', provide: 'Fournir des informations exactes.', usage: 'Utiliser les services légalement.', notify: 'Notifier la banque des transactions non autorisées.' },
            account: { header: 'Ouverture de compte et informations', description: 'Le Client s\'engage à fournir des informations exactes et complètes pour la configuration du compte.' },
            banking: { header: 'Services bancaires', description: 'La Banque fournit des services de compte, des virements de fonds, des prêts et d\'autres services financiers.' },
            functions: { header: 'Dépôts et retraits', description: 'La Banque accepte les dépôts en espèces, par chèque ou par voie électronique.' },
            security: { header: 'Sécurité et prévention de la fraude', description: 'Le Client est responsable de la protection des informations d\'identification du compte.' }
        },
        createPassword: {
            header: 'Créer un mot de passe pour',
            secondheader: 'votre compte',
            description: 'Pour vous inscrire dans notre système, vous devez créer un mot de passe à 6 chiffres.',
            button_text: 'Créer un mot de passe'
        },
        atm: {
            header: 'Connectez-vous pour accéder',
            secondheader: 'à votre compte',
            description: 'Vérifiez vos informations avant de vous connecter.',
            another_account: 'Pas votre compte ? Changer de compte',
            have_account: 'Vous avez déjà un compte ? Connexion'
        },
        // Locales simples
        and: 'et', firstname: 'Prénom', lastname: 'Nom', signature: 'Signature',
        click_to_sign: 'Cliquez pour signer !', login: 'Connexion', validate: 'VALIDER',
        iban_prefix: 'IBAN : #', cash_label: 'Espèces :', account_hacked: 'Votre compte a été piraté. Changez le mot de passe.',
        days: 'jours', day: 'jour', hours: 'heures', hour: 'heure', week: 'Semaine',
        active_investments: 'Investissements Actifs', investment_account_types: 'Types de Comptes',
        invested_amount: 'Montant Investi', your_earnings: 'Vos Gains', remaining_time: 'Temps Restant',
        delete_investment_account: 'Annuler l\'investissement', no_active_investment: 'Aucun investissement',
        buy: 'Acheter', balance: 'Solde', cash: 'Espèces', credit_score: 'Score de Crédit',
        deposit: 'Dépôt', withdraw: 'Retrait', transfer: 'Virement', request: 'Demande',
        dashboard: 'Tableau de bord', transactions: 'Transactions', invoices: 'Factures',
        loans: 'Crédits', savings: 'Épargne', crypto: 'Crypto', settings: 'Paramètres',
        notifications: 'Notifications', requests: 'Demandes', no_transactions: 'Aucune transaction',
        no_invoices: 'Aucune facture', no_notifications: 'Aucune notification', no_requests: 'Il n\'y a pas encore de demandes.',
        pay: 'Payer', accept: 'Accepter', reject: 'Refuser', clear_all: 'Tout Effacer',
        credit_point: 'Score de Crédit', unpaid_debt: 'Dette impayée', pay_all: 'Tout payer',
        active_credits: 'Prêts actifs', total_payback_amount: 'Montant total à rembourser :',
        deadline_for_payback: 'Date limite de remboursement :', remaining_debt: 'Dette Restante',
        amount_you_will_get: 'Le montant reçu :', amount_you_will_payback: 'Le montant à rembourser :',
        pay_all_button: 'Tout payer', pay_part: 'Payer une partie', confirm: 'Confirmer',
        money_earned: 'Argent Reçu', money_earned_desc: 'Montant total que vous avez reçu.',
        money_spent: 'Argent Dépensé', money_spent_desc: 'Montant total que vous avez dépensé.',
        money_sent: 'Argent Envoyé', money_sent_desc: 'Montant total que vous avez transféré.',
        monthly_spending: 'Dépenses Mensuelles', monthly_spending_desc: 'Montant moyen que vous avez dépensé ce mois-ci.',
        change_password: 'Changer le Mot de Passe', enter_password: 'Entrez le mot de passe',
        incoming_requests: 'Demandes Reçues', user_requested_money: 'L\'utilisateur demande ${amount} de votre part.',
        search: 'Rechercher...', insufficient_balance: 'Solde insuffisant pour payer cette facture',
        transactions_history: 'Historique des Transactions', search_transactions: 'Rechercher...',
        transfer_received: 'Virement (Reçu)', transfer_sent: 'Virement (Envoyé)',
        credit_received: 'Crédit reçu', credit_payment: 'Paiement crédit',
        saving_received: 'Épargne reçue', saving_deposit: 'Dépôt épargne',
        transactions_subtitle: 'Historique de vos transactions',
        saving_account: "Compte Epargne",
        transaction: 'Transactions', date: 'DATE', type: 'TYPE', amount: 'MONTANT'
    },
    hackSettings: { maxLoginAttempts: 3, maxWithdrawLimit: 5000 }
};

// Génère les données joueur actuelles
const getMockPlayerData = () => ({
    Firstname: 'Jean',
    Lastname: 'Dupont',
    ProfilePicture: '',
    ID: 1,
    IBAN: '4521',
    Balance: mockState.balance,
    Cash: mockState.cash,
    CryptoHoldings: [],
    ActiveCredits: mockState.activeCredits,
    CreditPoint: mockState.creditPoint,
    ActiveSavingAccounts: mockState.activeSavingAccounts,
    Requests: mockState.requests,
    Notification: mockState.notifications,
    AccountUsed: mockState.accountUsed,
    AccountOwner: true,
    AccountExist: true
});

// Simule l'envoi d'un message NUI (comme SendNUIMessage en Lua)
const simulateNUIMessage = (action, data) => {
    setTimeout(() => {
        window.postMessage({ action, ...data }, '*');
    }, 150);
};

// Envoie une mise à jour des données (simule oph3z-bank:ReceiveUpdatedData)
const sendUpdatedData = () => {
    simulateNUIMessage('UpdatePlayerInformation', {
        PlayerInformation: getMockPlayerData(),
        Transactions: mockState.transactions,
        Invoices: mockState.invoices
    });
};

// Ajoute une transaction
const addTransaction = (type, action, label, description, amount, source, transferDescription = '') => {
    const today = new Date();
    const date = `${today.getDate().toString().padStart(2, '0')}.${(today.getMonth() + 1).toString().padStart(2, '0')}.${today.getFullYear()}`;
    mockState.transactions.push({ type, action, label, date, description, amount, source, transferDescription });
};

// Actions qui déclenchent des événements NUI
const mockActions = {
    // Fermeture UI
    CloseUI: () => {
        // Juste ferme le focus NUI, pas de message
    },
    CloseUIEvent: () => {
        simulateNUIMessage('CloseUI', {});
    },

    // Création de compte
    RegisterAccount: () => {
        simulateNUIMessage('CloseUI', {});
        console.log('[DEV] Compte créé avec succès');
    },

    // Login ATM normal (son propre compte)
    normalATMLogin: () => {
        simulateNUIMessage('OpenBank', {
            PlayerInformation: getMockPlayerData(),
            Transactions: mockState.transactions,
            Invoices: mockState.invoices
        });
    },

    // Login sur un autre compte (hack)
    LoginToAnotherAccount: (data) => {
        // Simule un compte hacké
        const hackedPlayer = {
            Firstname: 'Victime',
            Lastname: 'Test',
            ProfilePicture: '',
            ID: '-',
            IBAN: data?.iban || '9999',
            Balance: 50000,
            Cash: '-',
            AccountOwner: false,
            AccountUsed: { loginlimit: 2, withdrawlimit: 800 },
            AccountExist: null
        };
        simulateNUIMessage('OpenBank', {
            PlayerInformation: hackedPlayer,
            Transactions: [],
            Invoices: []
        });
    },

    // Dépôt d'argent
    DepositMoney: (data) => {
        const amount = parseInt(data) || 0;
        if (amount > 0 && mockState.cash >= amount) {
            mockState.cash -= amount;
            mockState.balance += amount;
            addTransaction('add', 'deposit', 'Dépôt', `$${amount} déposés.`, amount, 'deposit');
            sendUpdatedData();
        }
    },

    // Retrait d'argent
    WithdrawMoney: (data) => {
        const amount = parseInt(data) || 0;
        if (amount > 0 && mockState.balance >= amount) {
            mockState.balance -= amount;
            mockState.cash += amount;
            addTransaction('remove', 'withdraw', 'Retrait', `$${amount} retirés.`, amount, 'withdraw');
            sendUpdatedData();
        }
    },

    // Virement par IBAN
    TransferMoneyByIBAN: (data) => {
        const amount = parseInt(data?.amount) || 0;
        if (amount > 0 && mockState.balance >= amount) {
            mockState.balance -= amount;
            addTransaction('remove', 'transfer', 'Virement', `Envoyé $${amount} à IBAN ${data?.iban}`, amount, 'transfer-given', `Destinataire - ${data?.iban}`);
            sendUpdatedData();
        }
    },

    // Virement par ID
    TransferMoneyByID: (data) => {
        const amount = parseInt(data?.amount) || 0;
        if (amount > 0 && mockState.balance >= amount) {
            mockState.balance -= amount;
            addTransaction('remove', 'transfer', 'Virement', `Envoyé $${amount} à ID ${data?.id}`, amount, 'transfer-given', `Joueur #${data?.id}`);
            sendUpdatedData();
        }
    },

    // Demande d'argent par IBAN
    RequestMoneyByIBAN: (data) => {
        mockState.notifications.push({
            label: 'Demande envoyée',
            description: `Demande de $${data?.amount} envoyée à IBAN ${data?.iban}`
        });
        sendUpdatedData();
    },

    // Demande d'argent par ID
    RequestMoneyByID: (data) => {
        mockState.notifications.push({
            label: 'Demande envoyée',
            description: `Demande de $${data?.amount} envoyée à ID ${data?.id}`
        });
        sendUpdatedData();
    },

    // Payer une facture
    PayInvoice: (data) => {
        const index = mockState.invoices.findIndex(inv => inv.label === data?.label);
        if (index !== -1) {
            const invoice = mockState.invoices[index];
            if (mockState.balance >= invoice.amount) {
                mockState.balance -= invoice.amount;
                mockState.invoices.splice(index, 1);
                addTransaction('remove', 'bill', 'Facture', `Facture payée: ${invoice.label}`, invoice.amount, 'otherexpenses');
                sendUpdatedData();
            }
        }
    },

    // Acheter un crédit
    buyCredit: (data) => {
        const creditConfig = {
            house: { price: 300000, requiredPoints: 2000, label: 'Crédit Immobilier' },
            vehicle: { price: 50000, requiredPoints: 300, label: 'Crédit Automobile' },
            business: { price: 100000, requiredPoints: 1000, label: 'Crédit Professionnel' }
        };
        const credit = creditConfig[data?.name];
        if (credit && mockState.creditPoint >= credit.requiredPoints) {
            mockState.creditPoint -= credit.requiredPoints;
            mockState.balance += credit.price;
            mockState.activeCredits.push({
                name: data?.name,
                remainingDebt: data?.remainingDebt || credit.price * 1.2,
                boughtTime: new Date().toLocaleDateString('fr-FR')
            });
            addTransaction('add', 'credit', 'Crédit', `${credit.label} obtenu`, credit.price, 'transfer-income');
            sendUpdatedData();
        }
    },

    // Payer toute la dette
    payAllDebt: (data) => {
        const totalDebt = parseInt(data) || 0;
        if (mockState.balance >= totalDebt) {
            mockState.balance -= totalDebt;
            mockState.activeCredits = [];
            mockState.creditPoint += 1000; // Bonus pour remboursement
            sendUpdatedData();
        }
    },

    // Payer une partie de la dette
    PayAPart: (data) => {
        const amount = parseInt(data?.amount) || 0;
        const creditIndex = mockState.activeCredits.findIndex(c => c.name === data?.loan);
        if (creditIndex !== -1 && mockState.balance >= amount) {
            mockState.balance -= amount;
            mockState.activeCredits[creditIndex].remainingDebt -= amount;
            if (mockState.activeCredits[creditIndex].remainingDebt <= 0) {
                mockState.activeCredits.splice(creditIndex, 1);
                mockState.creditPoint += 1000;
            }
            sendUpdatedData();
        }
    },

    // Payer une dette spécifique
    payDebt: (data) => {
        const creditIndex = mockState.activeCredits.findIndex(c => c.name === data);
        if (creditIndex !== -1) {
            const debt = mockState.activeCredits[creditIndex].remainingDebt;
            if (mockState.balance >= debt) {
                mockState.balance -= debt;
                mockState.activeCredits.splice(creditIndex, 1);
                mockState.creditPoint += 1000;
                sendUpdatedData();
            }
        }
    },

    // Acheter un compte épargne
    BuySavingAccount: (data) => {
        const savingConfig = {
            account_1: { cost: 100000, label: 'Épargne Court Terme' },
            account_2: { cost: 100000, label: 'Épargne Long Terme' },
            account_3: { cost: 50000, label: 'Plan Débutant' },
            account_4: { cost: 150000, label: 'Investissement Moyen Terme' },
            account_5: { cost: 500000, label: 'Plan Investissement VIP' }
        };
        const saving = savingConfig[data];
        if (saving && mockState.balance >= saving.cost) {
            mockState.balance -= saving.cost;
            mockState.activeSavingAccounts.push({
                name: data,
                boughtTime: new Date().toLocaleString('fr-FR')
            });
            sendUpdatedData();
        }
    },

    // Annuler un compte épargne
    cancelSavingAccount: (data) => {
        const savingConfig = {
            account_1: 100000, account_2: 100000, account_3: 50000,
            account_4: 150000, account_5: 500000
        };
        const index = mockState.activeSavingAccounts.findIndex(s => s.name === data);
        if (index !== -1) {
            mockState.balance += savingConfig[data] || 0;
            mockState.activeSavingAccounts.splice(index, 1);
            sendUpdatedData();
        }
    },

    // Changer le mot de passe
    changePassword: () => {
        mockState.accountUsed = { loginlimit: 3, withdrawlimit: 1000 };
        simulateNUIMessage('UpdateAccountUsedInUI', {
            data: mockState.accountUsed
        });
    },

    // Effacer les notifications
    clearNotifications: () => {
        mockState.notifications = [];
        sendUpdatedData();
    },

    // Effacer l'historique des transactions
    clearTransactions: () => {
        mockState.transactions = [];
        sendUpdatedData();
    },

    // Accepter une demande d'argent
    acceptRequest: (data) => {
        const amount = parseInt(data?.amount) || 0;
        if (data?.id !== undefined && mockState.balance >= amount) {
            mockState.balance -= amount;
            mockState.requests.splice(data.id, 1);
            addTransaction('remove', 'transfer', 'Virement', `Demande acceptée: $${amount}`, amount, 'transfer-given');
            sendUpdatedData();
        }
    },

    // Refuser une demande d'argent
    rejectRequest: (data) => {
        if (data?.id !== undefined) {
            mockState.requests.splice(data.id, 1);
            sendUpdatedData();
        }
    },

    // Retrait depuis un compte hacké
    WithdrawMoneyNonOwner: (data) => {
        const amount = parseInt(data?.amount) || 0;
        if (amount > 0 && amount <= mockState.accountUsed.withdrawlimit) {
            mockState.cash += amount;
            mockState.accountUsed.withdrawlimit -= amount;
            simulateNUIMessage('UpdateHackedAccountUI', {
                data: {
                    Balance: 50000 - amount,
                    Transactions: []
                }
            });
        }
    }
};

const postNUI = async (name, data) => {
    // Mode développement : retourne les mocks
    if (isDev) {
        console.log(`[DEV] postNUI: ${name}`, data);

        // Exécute l'action mockée si elle existe (simule les événements NUI)
        if (mockActions[name]) {
            mockActions[name](data);
        }

        // Retourne null après un petit délai (les vraies données sont envoyées via postMessage)
        return new Promise((resolve) => {
            setTimeout(() => resolve(null), 100);
        });
    }

    // Mode FiveM : fetch normal
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch {
        return null;
    }
}

// Assign to window for global access and export
window.postNUI = postNUI;

// Initialisation en mode dev : envoie Setup + OpenBank automatiquement
if (isDev) {
    setTimeout(() => {
        // Envoie d'abord le Setup avec la config
        window.postMessage({
            action: 'Setup',
            credits: mockConfig.credits,
            savingaccounts: mockConfig.savingAccounts,
            fastactions: mockConfig.fastActions,
            locales: mockConfig.locales,
            hacksettings: mockConfig.hackSettings
        }, '*');

        // Puis ouvre la banque avec les données joueur
        setTimeout(() => {
            window.postMessage({
                action: 'OpenBank',
                PlayerInformation: getMockPlayerData(),
                Transactions: mockState.transactions,
                Invoices: mockState.invoices
            }, '*');
        }, 100);
    }, 500);
}

export default postNUI;
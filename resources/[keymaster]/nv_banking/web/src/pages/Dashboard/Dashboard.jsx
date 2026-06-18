import React, { useState, useMemo, useEffect } from "react";
import { useSelector, useDispatch } from "react-redux";
import { useNavigate } from "react-router";
import { FormatMoney, setSelectedMenu, showErrorNotification } from "../../store/configSlice";
import { Line } from "react-chartjs-2";
import postNUI from "../../hooks/postNUI";
import CardCorners from "../../components/CardCorners";
import "./Dashbaord.css";
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend,
    Filler,
} from "chart.js";

ChartJS.register(
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend,
    Filler
);

function Dashboard() {
    const Config = useSelector((store) => store.config);
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const [ActiveActionMenu, setActiveActionMenu] = useState("withdraw");
    const [actionAmount, setActionAmount] = useState("");
    const [actionAccount, setActionAccount] = useState("");

    useEffect(() => {
        if (!Config.PlayerInformation.AccountOwner) {
            setActiveActionMenu("withdraw");
        }
    }, [Config.PlayerInformation.AccountOwner]);

    const handleActionMenuClick = (actionName) => {
        const restrictedActions = ["deposit", "transfer"];

        if (
            restrictedActions.includes(actionName) &&
            Config.PlayerInformation.AccountOwner == false
        ) {
            // Feedback intelligent selon l'action tentée
            const message = actionName === "transfer"
                ? Config.Locales["transfer_not_owner"] || "Vous devez être propriétaire du compte pour effectuer un virement"
                : Config.Locales["deposit_not_owner"] || "Vous devez être propriétaire du compte pour effectuer un dépôt";

            dispatch(showErrorNotification(Config.Locales["error"] || "Erreur", message));
            return;
        }

        setActiveActionMenu(actionName);
        setActionAmount("");
        setActionAccount("");
    };

    const handleConfirm = () => {
        const amount = parseInt(actionAmount);
        if (isNaN(amount) || amount <= 0) {
            dispatch(showErrorNotification(
                Config.Locales["error"] || "Erreur",
                Config.Locales["invalid_amount"] || "Veuillez entrer un montant valide"
            ));
            return;
        }

        if (ActiveActionMenu === "deposit") {
            if (Config.PlayerInformation.Cash < amount) {
                dispatch(showErrorNotification(
                    Config.Locales["error"] || "Erreur",
                    Config.Locales["not_enough_cash"] || "Vous n'avez pas assez d'argent liquide"
                ));
                return;
            }
            postNUI("DepositMoney", amount);
        } else if (ActiveActionMenu === "withdraw") {
            if (!Config.PlayerInformation.AccountOwner) {
                postNUI("WithdrawMoneyNonOwner", {
                    amount: amount,
                    iban: Config.PlayerInformation.IBAN,
                });
            } else {
                if (Config.PlayerInformation.Balance < amount) {
                    dispatch(showErrorNotification(
                        Config.Locales["error"] || "Erreur",
                        Config.Locales["not_enough_balance"] || "Solde bancaire insuffisant"
                    ));
                    return;
                }
                postNUI("WithdrawMoney", amount);
            }
        } else if (ActiveActionMenu === "transfer") {
            if (!actionAccount || actionAccount.trim() === "") {
                dispatch(showErrorNotification(
                    Config.Locales["error"] || "Erreur",
                    Config.Locales["no_target_account"] || "Veuillez entrer un compte cible (IBAN ou ID)"
                ));
                return;
            }
            if (Config.PlayerInformation.Balance < amount) {
                dispatch(showErrorNotification(
                    Config.Locales["error"] || "Erreur",
                    Config.Locales["not_enough_balance"] || "Solde bancaire insuffisant"
                ));
                return;
            }
            // Check if it's an IBAN (longer) or ID (shorter number)
            if (actionAccount.length > 5) {
                postNUI("TransferMoneyByIBAN", {
                    amount: amount,
                    iban: actionAccount,
                    playerIBAN: Config.PlayerInformation.IBAN,
                    description: "Transfer",
                });
            } else {
                postNUI("TransferMoneyByID", {
                    amount: amount,
                    id: actionAccount,
                    description: "Transfer",
                });
            }
        }

        setActionAmount("");
        setActionAccount("");
    };

    // Weekly chart data
    const chartData = useMemo(() => {
        const weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
        // Group transactions by day of week for current week simulation
        const weeklyData = Array(7).fill(0);

        Config.Transactions.forEach((transaction, index) => {
            // Distribute transactions across the week for demo
            const dayIndex = index % 7;
            if (transaction.type === "add") {
                weeklyData[dayIndex] += transaction.amount;
            } else {
                weeklyData[dayIndex] += transaction.amount * 0.5;
            }
        });

        return {
            labels: weekDays,
            datasets: [
                {
                    label: "Balance",
                    data: weeklyData.map((v) => (v > 0 ? v : Math.random() * 5000 + 1000)),
                    borderColor: "#c2c2c2",
                    backgroundColor: (context) => {
                        const ctx = context.chart.ctx;
                        const gradient = ctx.createLinearGradient(0, 0, 0, context.chart.height);
                        gradient.addColorStop(0, "rgba(255, 255, 255, 0.3)");
                        gradient.addColorStop(0.5, "rgba(255, 255, 255, 0.15)");
                        gradient.addColorStop(1, "rgba(255, 255, 255, 0)");
                        return gradient;
                    },
                    borderWidth: 2,
                    fill: true,
                    tension: 0.4,
                    pointRadius: 0,
                    pointHoverRadius: 6,
                    pointHoverBackgroundColor: "#c2c2c2",
                    pointHoverBorderColor: "rgba(255, 255, 255, 0.3)",
                    pointHoverBorderWidth: 4,
                },
            ],
        };
    }, [Config.Transactions]);

    const chartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
            y: {
                beginAtZero: true,
                grid: {
                    color: "rgba(255, 255, 255, 0.05)",
                    drawBorder: false,
                },
                ticks: {
                    color: "#6B6B6B",
                    font: {
                        family: "Geist",
                        size: 10,
                    },
                    callback: function (value) {
                        if (value >= 1000) return (value / 1000).toFixed(0) + "K";
                        return value;
                    },
                },
            },
            x: {
                grid: {
                    display: false,
                },
                ticks: {
                    color: "#6B6B6B",
                    font: {
                        family: "Geist",
                        size: 10,
                    },
                },
            },
        },
        plugins: {
            legend: {
                display: false,
            },
            tooltip: {
                enabled: true,
                backgroundColor: "rgba(21, 21, 21, 0.95)",
                titleFont: {
                    family: "Geist",
                    size: 12,
                },
                bodyFont: {
                    family: "Geist",
                    size: 11,
                },
                padding: 10,
                borderColor: "#4C4C4C",
                borderWidth: 1,
                callbacks: {
                    label: function (context) {
                        return `${FormatMoney(Math.abs(context.raw))}$`;
                    },
                },
            },
        },
    };

    // Get last 3 transactions for display
    const recentTransactions = useMemo(() => {
        return Config.Transactions.slice().reverse().slice(0, 3);
    }, [Config.Transactions]);

    return (
        <div className="w-full h-full flex flex-row dashboard theme-animate-in">
            {/* Left Column */}
            <div className="flex flex-col dashboard-leftcolumn flex-1">
                {/* Account Card Section */}
                <div className="h-[40%] dashboard-leftcolumn-account card-with-corners">
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className="flex items-center dashboard-leftcolumn-account-header justify-between w-full">
                        <div className="dashboard-leftcolumn-account-header-left flex items-center">
                            <div className="dashboard-leftcolumn-account-header-iconDiv flex items-center justify-center">
                                <i
                                    className="fa-duotone fa-solid fa-credit-card dashboard-leftcolumn-account-header-icon"
                                    style={{ color: "white" }}
                                ></i>
                            </div>
                            <div className="settings-section-titles flex flex-col">
                                <span className="settings-section-title">Comptes</span>
                                <span className="settings-section-subtitle">Compte principal</span>
                            </div>
                        </div>
                        <i
                            className="fa-duotone fa-solid fa-arrow-up-right-from-square dashboard-leftcolumn-account-header-shareIcon cursor-pointer hover:opacity-70 transition-opacity"
                            onClick={() => {
                                dispatch(setSelectedMenu(2));
                                navigate("/savingaccount");
                            }}
                        ></i>
                    </div>

                    {/* Bank Card Visual */}
                    <div
                        className="relative w-full dashboard-leftcolumn-account-card overflow-hidden"
                        style={{
                            background: "linear-gradient(135deg, #1A1A1A 0%, #1c1c1c 100%)",
                        }}
                    >
                        {/* Card stripes */}
                        <div
                            className="absolute right-0 top-0 h-full w-[45%]"
                            style={{
                                background:
                                    "linear-gradient(135deg, #444444 0%, #c2c2c2 0%, #444444 100%)",
                                clipPath: "polygon(30% 0, 100% 0, 100% 100%, 0% 100%)",
                            }}
                        ></div>
                        <div
                            className="absolute right-[15%] top-0 h-full w-[20%]"
                            style={{
                                background: "linear-gradient(135deg, #1c1c1c 0%, #1A1A1A 100%)",
                                clipPath: "polygon(50% 0, 100% 0, 50% 100%, 0% 100%)",
                            }}
                        ></div>

                        {/* Card content */}
                        <div className="absolute dashboard-leftcolumn-account-header-cardnamediv">
                            <span
                                className="theme-text dashboard-leftcolumn-account-header-cardnametext font-medium"
                                style={{ color: "#E5E5E5" }}
                            >
                                {Config.BankName || "Bank"}card.
                            </span>
                        </div>

                        {/* Card Number */}
                        <div className="absolute dashboard-leftcolumn-account-header-cardnumber flex items-center">
                            <span>
                                {Config.PlayerInformation.IBAN
                                    ? String(Config.PlayerInformation.IBAN).replace(/\s/g, "")
                                          .match(/.{1,4}/g)
                                          ?.join(" ")
                                    : "0000 0000 0000 0000"}
                            </span>
                            <i
                                className="fa-duotone fa-solid fa-copy dashboard-leftcolumn-account-header-cardcopy"
                                onClick={() =>
                                    navigator.clipboard.writeText(Config.PlayerInformation.IBAN)
                                }
                            ></i>
                        </div>

                        {/* Card Bottom Info */}
                        <div className="absolute dashboard-leftcolumn-account-header-cardbottom flex justify-between items-end">
                            <div className="flex flex-col">
                                <span className="dashboard-leftcolumn-account-header-cardlabel">
                                    VALID THRU
                                </span>
                                <span className="dashboard-leftcolumn-account-header-cardvalue">
                                    12/25
                                </span>
                            </div>
                            <div className="flex flex-col items-end">
                                <span className="dashboard-leftcolumn-account-header-cardlabel">
                                    CARD HOLDER
                                </span>
                                <span className="dashboard-leftcolumn-account-header-cardvalue">
                                    {Config.PlayerInformation.Firstname}{" "}
                                    {Config.PlayerInformation.Lastname}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Transactions Section */}
                <div className="h-[30%] dashboard-leftcolumn-account card-with-corners">
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className="flex items-center dashboard-leftcolumn-account-header justify-between w-full">
                        <div className="dashboard-leftcolumn-account-header-left flex items-center">
                            <div className="dashboard-leftcolumn-account-header-iconDiv flex items-center justify-center">
                                <i
                                    className="fa-duotone fa-solid fa-arrow-right-arrow-left dashboard-leftcolumn-account-header-icon"
                                    style={{ color: "white" }}
                                ></i>
                            </div>
                            <div className="settings-section-titles flex flex-col">
                                <span className="settings-section-title">Transactions</span>
                                <span className="settings-section-subtitle">
                                    Liste de vos dernières transactions
                                </span>
                            </div>
                        </div>
                        <i
                            className="fa-duotone fa-solid fa-arrow-up-right-from-square dashboard-leftcolumn-account-header-shareIcon cursor-pointer hover:opacity-70 transition-opacity"
                            onClick={() => {
                                dispatch(setSelectedMenu(1));
                                navigate("/transactions");
                            }}
                        ></i>
                    </div>

                    <div className="flex flex-col dashboard-leftcolumn-transactions">
                        {recentTransactions.length > 0 ? (
                            recentTransactions.map((transaction, index) => (
                                <div
                                    key={index}
                                    className="flex items-center dashboard-leftcolumn-transactions-transaction"
                                    style={{ background: "rgba(255,255,255,0.03)" }}
                                >
                                    <div
                                        className="dashboard-leftcolumn-transactions-transaction-type flex items-center justify-center"
                                        style={{
                                            background:
                                                transaction.type === "add"
                                                    ? "#fafafa1a"
                                                    : "#c507171a",
                                        }}
                                    >
                                        <i
                                            className={`fa-duotone fa-solid ${
                                                transaction.type === "add"
                                                    ? "fa-arrow-down"
                                                    : "fa-arrow-up"
                                            } dashboard-leftcolumn-transactions-transaction-type-icon`}
                                            style={{
                                                color:
                                                    transaction.type === "add"
                                                        ? "white"
                                                        : "#CD412C",
                                            }}
                                        ></i>
                                    </div>
                                    <div className="flex flex-col flex-1 dashboard-leftcolumn-transactions-transaction-texts">
                                        <span className="theme-text dashboard-leftcolumn-transactions-transaction-label font-medium">
                                            {transaction.transferDescription || transaction.label}
                                        </span>
                                        <span className="theme-text-secondary dashboard-leftcolumn-transactions-transaction-date">
                                            {transaction.date}
                                        </span>
                                    </div>
                                    <span
                                        className="theme-text dashboard-leftcolumn-transactions-transaction-amount font-semibold"
                                        style={{
                                            color: transaction.type === "add" ? "white" : "#CD412C",
                                        }}
                                    >
                                        {transaction.type === "add" ? "+" : "-"}$
                                        {FormatMoney(transaction.amount)}
                                    </span>
                                </div>
                            ))
                        ) : (
                            <div className="flex items-center justify-center py-[20px]">
                                <span className="theme-text-secondary text-[12px]">
                                    {Config.Locales["no_transactions"]}
                                </span>
                            </div>
                        )}
                    </div>
                </div>

                {/* Actions Section */}
                <div className="h-[36%] dashboard-leftcolumn-account card-with-corners">
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className="flex items-center dashboard-leftcolumn-account-header justify-between w-full">
                        <div className="dashboard-leftcolumn-account-header-left flex items-center">
                            <div className="dashboard-leftcolumn-account-header-iconDiv flex items-center justify-center">
                                <i
                                    className="fa-duotone fa-solid fa-list dashboard-leftcolumn-account-header-icon"
                                    style={{ color: "white" }}
                                ></i>
                            </div>
                            <div className="settings-section-titles flex flex-col">
                                <span className="settings-section-title">Actions</span>
                                <span className="settings-section-subtitle">
                                    Ajouter, Retirer, Virer de l'argent
                                </span>
                            </div>
                        </div>
                        <i
                            className="fa-duotone fa-solid fa-arrow-up-right-from-square dashboard-leftcolumn-account-header-shareIcon"
                            style={{ opacity: 0.3 }}
                        ></i>
                    </div>

                    {/* Action Buttons */}
                    <div className="flex dashboard-leftcolumn-actions-buttons">
                        <button
                            className={`flex-1 dashboard-leftcolumn-actions-button font-medium ${
                                ActiveActionMenu === "withdraw"
                                    ? "dashboard-leftcolumn-actions-button-active"
                                    : ""
                            }`}
                            onClick={() => handleActionMenuClick("withdraw")}
                        >
                            {Config.Locales["withdraw"] || "Withdraw"}
                        </button>
                        <button
                            className={`flex-1 dashboard-leftcolumn-actions-button font-medium ${
                                ActiveActionMenu === "deposit"
                                    ? "dashboard-leftcolumn-actions-button-active"
                                    : ""
                            }`}
                            onClick={() => handleActionMenuClick("deposit")}
                        >
                            {Config.Locales["deposit"] || "Deposit"}
                        </button>
                        <button
                            className={`flex-1 dashboard-leftcolumn-actions-button font-medium ${
                                ActiveActionMenu === "transfer"
                                    ? "dashboard-leftcolumn-actions-button-active"
                                    : ""
                            }`}
                            onClick={() => handleActionMenuClick("transfer")}
                        >
                            {Config.Locales["transfer"] || "Transfer"}
                        </button>
                    </div>

                    {/* Input Fields - Always visible */}
                    <div className="flex flex-col dashboard-leftcolumn-actions-inputs">
                        {/* Account Field - Only for transfer */}
                        {ActiveActionMenu === "transfer" && (
                            <div
                                className="flex items-center dashboard-leftcolumn-actions-inputrow dashboard-leftcolumn-actions-accountfield"
                                style={{
                                    background: "rgba(255,255,255,0.03)",
                                    border: "1px solid rgba(255,255,255,0.08)",
                                }}
                            >
                                <div
                                    className="dashboard-leftcolumn-actions-inputicon flex items-center justify-center"
                                    style={{ background: "rgba(255,255,255,0.05)" }}
                                >
                                    <i
                                        className="fa-duotone fa-solid fa-user dashboard-leftcolumn-actions-inputicon-icon"
                                        style={{ color: "white" }}
                                    ></i>
                                </div>
                                <input
                                    type="text"
                                    className="flex-1 bg-transparent border-none outline-none text-white dashboard-leftcolumn-actions-input"
                                    placeholder="Compte cible"
                                    value={actionAccount}
                                    onChange={(e) => setActionAccount(e.target.value)}
                                    style={{ fontFamily: "Geist, sans-serif" }}
                                />
                            </div>
                        )}
                        {/* Amount Field with Confirm Button */}
                        <div className="flex items-center dashboard-leftcolumn-actions-amountrow">
                            <div
                                className="flex items-center dashboard-leftcolumn-actions-inputrow flex-1"
                                style={{
                                    background: "rgba(255,255,255,0.03)",
                                    border: "1px solid rgba(255,255,255,0.08)",
                                }}
                            >
                                <div
                                    className="dashboard-leftcolumn-actions-inputicon flex items-center justify-center"
                                    style={{ background: "rgba(255,255,255,0.05)" }}
                                >
                                    <i
                                        className="fa-duotone fa-solid fa-dollar-sign dashboard-leftcolumn-actions-inputicon-icon"
                                        style={{ color: "white" }}
                                    ></i>
                                </div>
                                <input
                                    type="number"
                                    className="flex-1 bg-transparent border-none outline-none text-white dashboard-leftcolumn-actions-input"
                                    placeholder="Montant"
                                    value={actionAmount}
                                    onChange={(e) =>
                                        setActionAmount(e.target.value.replace(/[^0-9]/g, ""))
                                    }
                                    style={{ fontFamily: "Geist, sans-serif" }}
                                />
                            </div>
                            <button
                                className="dashboard-leftcolumn-actions-confirm font-semibold uppercase transition-all"
                                onClick={handleConfirm}
                            >
                                {Config.Locales["confirm"] || "Confirmer"}
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            {/* Right Column */}
            <div className="flex flex-col dashboard-rightcolumn h-full">
                {/* Balance Info */}
                <div className="dashboard-rightcolumn-balanceinfo card-with-corners">
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className="flex items-center justify-between">
                        {/* Left side - Balances */}
                        <div className="flex flex-col dashboard-rightcolumn-balances">
                            <div className="flex items-center dashboard-rightcolumn-balance-row">
                                <div className="dashboard-leftcolumn-account-header-iconDiv dashboard-leftcolumn-account-header-iconDiv-big flex items-center justify-center">
                                    <i className="fa-duotone fa-solid fa-building-columns dashboard-leftcolumn-account-header-icon"></i>
                                </div>
                                <div className="flex flex-col">
                                    <span className="theme-text-secondary dashboard-rightcolumn-balance-label uppercase">
                                        Solde bancaire
                                    </span>
                                    <span className="dashboard-rightcolumn-balance-value font-semibold">
                                        ${FormatMoney(Config.PlayerInformation.Balance)}
                                    </span>
                                </div>
                            </div>
                            <div className="flex items-center dashboard-rightcolumn-balance-row">
                                <div className="dashboard-leftcolumn-account-header-iconDiv dashboard-leftcolumn-account-header-iconDiv-big flex items-center justify-center">
                                    <i className=" fa-duotone fa-solid fa-wallet dashboard-leftcolumn-account-header-icon"></i>
                                </div>
                                <div className="flex flex-col">
                                    <span className="theme-text-secondary dashboard-rightcolumn-balance-label uppercase">
                                        Cash
                                    </span>
                                    <span className="dashboard-rightcolumn-balance-value font-semibold">
                                        ${FormatMoney(Config.PlayerInformation.Cash || 0)}
                                    </span>
                                </div>
                            </div>
                        </div>
                        {/* Right side - Name and Icon */}
                        <div className="flex items-center dashboard-rightcolumn-userinfo">
                            <div className="flex flex-col items-end">
                                <span className="theme-title dashboard-rightcolumn-username">
                                    {Config.PlayerInformation.Firstname}{" "}
                                    {Config.PlayerInformation.Lastname}
                                </span>
                                <span className="theme-text-secondary dashboard-rightcolumn-iban">
                                    #{Config.PlayerInformation.IBAN}
                                </span>
                            </div>
                            <div className="dashboard-rightcolumn-avatar rounded-full flex items-center justify-center">
                                <i className="fa-duotone fa-solid fa-landmark"></i>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Statistics Chart */}
                <div className="flex-1 flex flex-col dashboard-rightcolumn-statistics card-with-corners">
                    <CardCorners color="rgba(255, 255, 255, 0.5)" />
                    <div className="flex items-center dashboard-rightcolumn-statistics-header">
                        <div className="dashboard-leftcolumn-account-header-iconDiv flex items-center justify-center">
                            <i className="fa-duotone fa-solid fa-chart-line dashboard-leftcolumn-account-header-icon"></i>
                        </div>
                        <div className="settings-section-titles flex flex-col">
                            <span className="settings-section-title">Statistiques</span>
                            <span className="settings-section-subtitle">Votre compte principal</span>
                        </div>
                    </div>

                    <div className="w-full flex-1 max-h-[90%]">
                        <Line data={chartData} options={chartOptions} />
                    </div>
                </div>
            </div>
        </div>
    );
}

export default Dashboard;

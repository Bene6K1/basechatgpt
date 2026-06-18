import './index.css'
import postNUI from './hooks/postNUI'
import { useSelector, useDispatch } from 'react-redux'
import { setShow, setScreen, hideNotification, setSelectedMenu } from './store/configSlice2'
import { useState, useEffect } from 'react'
import { Routes, Route } from 'react-router-dom'
import { useNavigate } from 'react-router'
import Dashboard from './pages/Dashboard/Dashboard'
import Transactions from './pages/Transactions/Transactions'
import Invoices from './pages/Invoices/Invoices'
import Loans from './pages/Loans/Loans'
import SavingAccount from './pages/SavingAccount/SavingAccount'
import Enterprise from './pages/Enterprise/Enterprise'
import Crypto from './pages/Crypto'
import Settings from './pages/Settings/Settings'
import Notify from './components/Notify'
import CardCorners from './components/CardCorners'

function App() {
    const Config = useSelector((store) => store.config)
    const dispatch = useDispatch()
    const navigate = useNavigate()
    const [signature, setSignature] = useState(false)
    const [signatureText, setSignatureText] = useState('')
    const [isWriting, setIsWriting] = useState(false)
    const [password, setPassword] = useState(['', '', '', '', '', '']) // Create password screen
    const [currentInputIndex, setCurrentInputIndex] = useState(0)
    const [showPassword, setShowPassword] = useState(false)
    const [atmPassword, setAtmPassword] = useState(['', '', '', '', '', '']) // Atm password screen
    const [atmIBAN, setAtmIBAN] = useState('')
    const [keypad, setKeypad] = useState([
        {type: 'number', label: '1'},
        {type: 'number', label: '2'},
        {type: 'number', label: '3'},
        {type: 'number', label: '4'},
        {type: 'number', label: '5'},
        {type: 'number', label: '6'},
        {type: 'number', label: '7'},
        {type: 'number', label: '8'},
        {type: 'number', label: '9'},
        {type: 'remove', label: ''},
        {type: 'number', label: '0'},
        {type: 'backspace', label: ''}
    ])
    const [menu, setMenu] = useState([
        {name: 'dashboard', path: '/', icon: 'fa-grid-2'},
        {name: 'transaction', path: '/transactions', icon: 'fa-arrow-right-arrow-left'},
        {name: 'saving_account', path: '/savingaccount', icon: 'fa-piggy-bank'},
        {name: 'loans', path: '/loans', icon: 'fa-building'},
        {name: 'society', path: '/enterprise', icon: 'fa-briefcase'},
        // {name: 'crypto_market', path: '/crypto', icon: 'fa-coins'},
        {name: 'settings', path: '/settings', icon: 'fa-gear'},
    ])
    const selectedMenu = Config.SelectedMenu
    const [isInputFocused, setIsInputFocused] = useState(false)

    useEffect(() => {
        if (Config.Show) {
            // UI açıldığında tüm state'leri sıfırla
            setAtmIBAN('')
            setSignature(false)
            setSignatureText('')
            setIsWriting(false)
            setPassword(['', '', '', '', '', ''])
            setCurrentInputIndex(0)
            setShowPassword(false)
            setAtmPassword(['', '', '', '', '', ''])
            dispatch(setSelectedMenu(0))
            setIsInputFocused(false)
            navigate('/')
        }
    }, [Config.Show])

    useEffect(() => {
        const handleKeyPress = (e) => {
            if (e.key === 'Escape') {
                if (Config.LoanPopupOpen) {
                    return
                }
                postNUI('CloseUI')
                dispatch(setShow(false))
                dispatch(hideNotification())
                return
            }

            if (isInputFocused && Config.Screen === 'atm' && Config.atmScreen === 'new') {
                return
            }

            if (Config.Screen === 'createPassword') {
                if (e.key >= '0' && e.key <= '9') {
                    if (password.every(digit => digit !== '')) return

                    const newPassword = [...password]
                    newPassword[currentInputIndex] = e.key
                    setPassword(newPassword)
                    
                    if (currentInputIndex < 5) {
                        setCurrentInputIndex(currentInputIndex + 1)
                    }
                } else if (e.key === 'Backspace') {
                    const newPassword = [...password]
                    if (newPassword[currentInputIndex] === '') {
                        if (currentInputIndex > 0) {
                            newPassword[currentInputIndex - 1] = ''
                            setCurrentInputIndex(currentInputIndex - 1)
                        }
                    } else {
                        newPassword[currentInputIndex] = ''
                    }
                    setPassword(newPassword)
                }
            } else if (Config.Screen === 'atm' && Config.atmScreen === 'new') {
                if (e.key >= '0' && e.key <= '9') {
                    if (atmPassword.every(digit => digit !== '')) return

                    const newPassword = [...atmPassword]
                    const currentIndex = newPassword.findIndex(digit => digit === '')
                    if (currentIndex !== -1) {
                        newPassword[currentIndex] = e.key
                        setAtmPassword(newPassword)
                    }
                } else if (e.key === 'Backspace') {
                    const newPassword = [...atmPassword]
                    const lastFilledIndex = newPassword.map((digit, index) => digit !== '' ? index : -1).filter(index => index !== -1).pop()
                    
                    if (lastFilledIndex !== undefined) {
                        newPassword[lastFilledIndex] = ''
                        setAtmPassword(newPassword)
                    }
                }
            }
        }

        window.addEventListener('keydown', handleKeyPress)
        return () => window.removeEventListener('keydown', handleKeyPress)
    }, [Config.Screen, Config.atmScreen, password, currentInputIndex, atmPassword, isInputFocused])

    const handleKeypadClick = (type, label) => {
        if (Config.Screen === 'atm' && Config.atmScreen === 'new') {
            if (type === 'number') {
                if (atmPassword.every(digit => digit !== '')) return

                const newPassword = [...atmPassword]
                const currentIndex = newPassword.findIndex(digit => digit === '')
                if (currentIndex !== -1) {
                    newPassword[currentIndex] = label
                    setAtmPassword(newPassword)
                }
            } else if (type === 'remove') {
                setAtmPassword(['', '', '', '', '', ''])
            } else if (type === 'backspace') {
                const newPassword = [...atmPassword]
                const lastFilledIndex = newPassword.map((digit, index) => digit !== '' ? index : -1).filter(index => index !== -1).pop()
                
                if (lastFilledIndex !== undefined) {
                    newPassword[lastFilledIndex] = ''
                    setAtmPassword(newPassword)
                }
            }
        }
    }

    function SignContract() {
        if (!signature && !isWriting) {
            setIsWriting(true)
            setSignatureText('')
            const fullName = Config.PlayerInformation.Firstname + ' ' + Config.PlayerInformation.Lastname
            let currentIndex = 0
            const writeSignature = () => {
                if (currentIndex < fullName.length) {
                    setSignatureText(fullName.substring(0, currentIndex + 1))
                    currentIndex++
                    setTimeout(writeSignature, 100)
                } else {
                    setIsWriting(false)
                    setSignature(true)
                }
            }
            writeSignature()
        }
    }

    function SetCurrentRoute(key, path) {
        if (selectedMenu != key) {
            const restrictedMenus = ['loans', 'saving_account', 'crypto_market', 'settings']
            const menuName = menu[key].name

            if (restrictedMenus.includes(menuName) && Config.PlayerInformation.AccountOwner == false) {
                // Notification désactivée
                // dispatch(showNotification({
                //     label: Config.Locales['error'],
                //     description: Config.Locales['need_account_owner'],
                //     type: 'error',
                //     ms: 3000
                // }))
                return
            }

            dispatch(setSelectedMenu(key))
            navigate(path)
        }
    }

    function AtmAnotherAccountLogin() {
        if (atmIBAN.length > 0) {
            if (atmPassword.join('').length == 6) {
                postNUI('LoginToAnotherAccount', {iban: atmIBAN, password: atmPassword.join('')})
            } else {
                // Notification désactivée
                // dispatch(showNotification({
                //     label: Config.Locales['error'],
                //     description: Config.Locales['write_password'],
                //     type: 'error',
                //     ms: 3000
                // }))
            }
        } else {
            // Notification désactivée
            // dispatch(showNotification({
            //     label: 'Error',
            //     description: Config.Locales['write_iban'],
            //     type: 'error',
            //     ms: 3000
            // }))
        }
    }

    function CreateAccount() {
        if (password.join('').length == 6) {
            postNUI('RegisterAccount', password.join(''))
        } else {
            // Notification désactivée
            // dispatch(showNotification({
            //     label: 'Error',
            //     description: Config.Locales['create_6digit_password'],
            //     type: 'error',
            //     ms: 3000
            // }))
        }
    }

    function handleCreatePasswordKeypad(key) {
        if (key.type === 'number') {
            if (password.every(digit => digit !== '')) return
            const newPassword = [...password]
            newPassword[currentInputIndex] = key.label
            setPassword(newPassword)
            if (currentInputIndex < 5) {
                setCurrentInputIndex(currentInputIndex + 1)
            }
        } else if (key.type === 'backspace') {
            const newPassword = [...password]
            if (newPassword[currentInputIndex] === '') {
                if (currentInputIndex > 0) {
                    newPassword[currentInputIndex - 1] = ''
                    setCurrentInputIndex(currentInputIndex - 1)
                }
            } else {
                newPassword[currentInputIndex] = ''
            }
            setPassword(newPassword)
        } else if (key.type === 'remove') {
            setPassword(['', '', '', '', '', ''])
            setCurrentInputIndex(0)
        }
    }

    if (!Config.Show) return null
    return (
        <div className='w-full h-[100vh] flex items-center justify-center'>
            { Config.Screen == 'bankAgreement' && (
                <div className='flex justify-center items-center w-full h-full relative theme-animate-in'>
                    <div className='flex flex-col items-start agreement-container card-with-corners theme-scrollbar'>
                        <CardCorners color="rgba(255, 255, 255, 0.5)" />
                        <div className='flex flex-row justify-between items-center w-full agreement-header'>
                            <span className='theme-title agreement-title uppercase'>{ Config.Locales.bankAgreement['header'] }</span>
                        </div>

                        <div className='theme-divider'></div>

                        <div className='flex flex-col agreement-description w-full'>
                            <p className='theme-text-secondary agreement-description'>
                                { Config.Locales.bankAgreement['description'] + ' ' + Config.BankName + ' ' + Config.Locales['and'] + ' ' + Config.PlayerInformation.Firstname + ' ' + Config.PlayerInformation.Lastname }
                            </p>
                        </div>

                        <div className='flex flex-col agreement-sections w-full'>
                            <div className='flex flex-col agreement-section'>
                                <span className='theme-title agreement-section-title uppercase'>1. { Config.Locales.bankAgreement['services'] }</span>
                            </div>

                            <div className='flex flex-col agreement-section'>
                                <span className='theme-title agreement-section-title uppercase'>2. { Config.Locales.bankAgreement.customer['header'] }</span>
                                <ul className='agreement-list theme-text-secondary agreement-section-text list-disc'>
                                    <li className='agreement-list-item'>{ Config.Locales.bankAgreement.customer['provide'] }</li>
                                    <li className='agreement-list-item'>{ Config.Locales.bankAgreement.customer['usage'] }</li>
                                    <li className='agreement-list-item'>{ Config.Locales.bankAgreement.customer['notify'] }</li>
                                </ul>
                            </div>

                            <div className='flex flex-col agreement-section'>
                                <span className='theme-title agreement-section-title uppercase'>3. { Config.Locales['bankAgreement']['account']['header'] }</span>
                                <p className='theme-text-secondary agreement-section-text'>{ Config.Locales['bankAgreement']['account']['description'] }</p>
                            </div>

                            <div className='flex flex-col agreement-section'>
                                <span className='theme-title agreement-section-title uppercase'>4. { Config.Locales['bankAgreement']['banking']['header'] }</span>
                                <p className='theme-text-secondary agreement-section-text'>{ Config.Locales['bankAgreement']['banking']['description'] }</p>
                            </div>

                            <div className='flex flex-col agreement-section'>
                                <span className='theme-title agreement-section-title uppercase'>5. { Config.Locales['bankAgreement']['functions']['header'] }</span>
                                <p className='theme-text-secondary agreement-section-text'>{ Config.Locales['bankAgreement']['functions']['description'] }</p>
                            </div>

                            <div className='flex flex-col agreement-section'>
                                <span className='theme-title agreement-section-title uppercase'>6. { Config.Locales['bankAgreement']['security']['header'] }</span>
                                <p className='theme-text-secondary agreement-section-text'>{ Config.Locales['bankAgreement']['security']['description'] }</p>
                            </div>
                        </div>


                        <div className='flex flex-col agreement-form w-full'>
                            <div className='flex flex-row agreement-form-row w-full'>
                                <div className='flex flex-col agreement-form-col'>
                                    <span className='theme-text agreement-form-label'>{ Config.Locales['firstname'] }</span>
                                    <input type='text' readOnly className='theme-input agreement-form-input' value={ Config.PlayerInformation.Firstname } />
                                </div>
                                <div className='flex flex-col agreement-form-col'>
                                    <span className='theme-text agreement-form-label'>{ Config.Locales['lastname'] }</span>
                                    <input type='text' readOnly className='theme-input agreement-form-input' value={ Config.PlayerInformation.Lastname } />
                                </div>
                            </div>

                            <div className='flex flex-col agreement-signature'>
                                <span className='theme-text agreement-form-label'>{ Config.Locales['signature'] }</span>
                                <div onClick={SignContract} className='theme-input agreement-signature flex items-center justify-center cursor-pointer hover:bg-[rgba(255,255,255,0.1)] transition-all'>
                                    { !signatureText ? (
                                        <span className='theme-text-secondary agreement-signature-placeholder italic'>{ Config.Locales['click_to_sign'] }</span>
                                    ) : (
                                        <span className='theme-text agreement-signature-text font-["signature"]'>{ signatureText }</span>
                                    )}
                                </div>
                            </div>

                            <button
                                className='theme-button agreement-validate-btn w-full'
                                onClick={() => signature && dispatch(setScreen('createPassword'))}
                                disabled={!signature}
                            >
                                <i className="fa-duotone fa-solid fa-check"></i>
                                <span>{ Config.Locales['validate'] || 'VALIDER' }</span>
                            </button>
                        </div>
                    </div>
                    <div className='top-[3vw] absolute'>
                        <Notify></Notify>
                    </div>
                </div>
            )}
            { Config.Screen == 'createPassword' && (
                <div className='flex justify-center items-center w-full h-full relative theme-animate-in'>
                    <div className='flex flex-col items-center createPassword-container card-with-corners'>
                        <CardCorners color="rgba(255, 255, 255, 0.5)" />
                        <div className='flex flex-col items-center createPassword-header w-full'>
                            <span className='theme-title createPassword-title uppercase text-center'>
                                { Config.Locales['createPassword']['header'] + ' ' + Config.Locales['createPassword']['secondheader'] }
                            </span>
                            <p className='theme-text-secondary createPassword-description text-center'>
                                { Config.Locales['createPassword']['description'] }
                            </p>
                        </div>

                        <div className='theme-divider'></div>

                        <div className='flex flex-col createPassword-content w-full items-center'>
                            <div className='flex items-center justify-center cursor-pointer hover:opacity-70 transition-opacity' onClick={() => setShowPassword(!showPassword)}>
                                <i className={`fa-duotone fa-solid ${showPassword ? 'fa-eye' : 'fa-eye-slash'} text-white createPassword-eye-icon`}></i>
                            </div>

                            <div className='flex flex-row createPassword-inputs justify-center w-full'>
                                {[...Array(6)].map((_, index) => (
                                    <input
                                        key={index}
                                        type={showPassword ? "text" : "password"}
                                        className='theme-input nopadding createPassword-input text-center font-bold p-0'
                                        value={password[index]}
                                        readOnly
                                    />
                                ))}
                            </div>

                            <div className='grid grid-cols-3 createPassword-keypad w-full'>
                                {keypad.map((key, index) => (
                                    <button
                                        key={index}
                                        className='flex items-center justify-center createPassword-keypad-button'
                                        onClick={() => handleCreatePasswordKeypad(key)}
                                    >
                                        {key.type === 'number' && <span className='createPassword-keypad-number'>{key.label}</span>}
                                        {key.type === 'remove' && <i className="fa-duotone fa-solid fa-times text-white createPassword-keypad-icon"></i>}
                                        {key.type === 'backspace' && <i className="fa-duotone fa-solid fa-backspace text-white createPassword-keypad-icon"></i>}
                                    </button>
                                ))}
                            </div>
                        </div>

                        <div className='theme-divider'></div>

                        <button className='theme-button createPassword-submit-btn w-full' onClick={() => CreateAccount()}>
                            <i className="fa-duotone fa-solid fa-check"></i>
                            <span>{ Config.Locales['createPassword']['button_text'] }</span>
                        </button>
                    </div>
                    <div className='top-[1vw] absolute'>
                        <Notify></Notify>
                    </div>
                </div>
            )}
            { Config.Screen == 'atm' && (
                <div className='flex justify-center items-center w-full h-full relative theme-animate-in'>
                    <div className='flex flex-col items-start atm-container card-with-corners'>
                        <CardCorners color="rgba(255, 255, 255, 0.5)" />
                        <div className='flex flex-row justify-between items-center w-full'>
                            <span className='theme-title atm-title uppercase'>{ Config.Locales['atm']['header'] }</span>
                            <div
                                className='flex items-center atm-leaveBtn cursor-pointer transition-all mt-auto'
                                onClick={() => { postNUI('CloseUI'); dispatch(setShow(false)); }}
                            >
                                <i className="fa-duotone fa-regular fa-xmark atm-leaveBtn-icon"></i>
                            </div>
                        </div>

                        <div className='theme-divider'></div>

                        <div className='flex flex-col items-center w-full atm-profile-section'>
                            <div className='atm-account-div flex justify-center items-center'>
                                <i className="fa-duotone fa-solid fa-user text-white atm-profile-icon-text opacity-70"></i>
                            </div>

                            <div className='flex flex-col items-center atm-player-info'>
                                <span className='theme-title atm-player-name uppercase text-center'>{ Config.PlayerInformation.Firstname + ' ' + Config.PlayerInformation.Lastname }</span>
                                <span className='theme-text-secondary atm-player-iban'>{ Config.Locales['iban_prefix'] }{ Config.PlayerInformation.IBAN }</span>
                            </div>
                        </div>

                        <div className='theme-divider'></div>

                        <div className='flex flex-col atm-buttons-section w-full'>
                            <button className='theme-button atm-connect-btn w-full' onClick={() => postNUI('normalATMLogin')}>
                                <i className="fa-duotone fa-solid fa-sign-in-alt"></i>
                                <span>{ Config.Locales['login'] }</span>
                            </button>

                            <p className='theme-text-secondary atm-description text-center w-full leading-relaxed'>
                                { Config.Locales['atm']['description'] }
                            </p>
                        </div>
                    </div>
                    <div className='top-[1vw] absolute'>
                        <Notify></Notify>
                    </div>
                </div>
            )}
            { Config.Screen == 'bank' && (
                <div className='flex justify-center items-center w-full h-full relative theme-animate-in'>
                    <div className='flex flex-row gap-[20px] w-auto h-[77vh] bankContainer'>
                        {/* Sidebar */}
                        <div className='bankContainerLeftSidebar flex flex-col h-full'>
                            <CardCorners color="rgba(255, 255, 255, 0.5)" />
                            {/* Logo */}
                            <div className='flex items-center bankContainerLeftSidebar-header'>
                                <i className="fa-duotone fa-solid fa-building-columns bankContainerLeftSidebar-header-icon" style={{ color: 'white' }}></i>
                                <div className='flex flex-col'>
                                    <span className='theme-title uppercase leading-none bankContainerLeftSidebar-header-title'>{ Config.BankName }</span>
                                    <span className='uppercase tracking-[2px] bankContainerLeftSidebar-header-subtitle'>B A N K I N G</span>
                                </div>
                            </div>
                            
                            <div className='divider'></div>

                            {/* Menu Items */}
                            <div className='flex flex-col flex-1 bankContainerLeftSidebar-items'>
                                { menu.map((v, k) => (
                                    <div
                                        key={k}
                                        className={`flex items-center bankContainerLeftSidebar-item cursor-pointer transition-all ${selectedMenu === k ? 'bankContainerLeftSidebar-item-active' : ''}`}
                                        onClick={() => SetCurrentRoute(k, v.path)}
                                    >
                                        <i className={`fa-duotone fa-solid ${v.icon} bankContainerLeftSidebar-item-icon`} style={{
                                            color: selectedMenu === k ? 'rgb(255, 255, 255)' : '#6B6B6B'
                                        }}></i>
                                        <span className='bankContainerLeftSidebar-item-text' style={{
                                            color: selectedMenu === k ? '#FFFFFF' : '#8B8B8B',
                                            fontFamily: 'Geist, sans-serif'
                                        }}>
                                            { Config.Locales[v.name] }
                                        </span>
                                    </div>
                                ))}
                            </div>

                            {/* Leave Button */}
                            <div
                                className='flex items-center bankContainerLeftSidebar-leaveBtn cursor-pointer transition-all mt-auto'
                                onClick={() => { postNUI('CloseUI'); dispatch(setShow(false)); }}
                            >
                                <div className='flex items-center justify-center bankContainerLeftSidebar-leaveBtn-iconDiv'>
                                    <i className="fa-duotone fa-solid fa-right-from-bracket transactions-leaveBtn-icon"></i>
                                </div>
                                <span className='bankContainerLeftSidebar-leaveBtn-text'>Quitter</span>
                            </div>
                        </div>

                        {/* Main Content */}
                        <div className='flex-1 h-full overflow-y-auto theme-scrollbar' style={{ paddingRight: '5px' }}>
                            <Routes>
                                <Route path='/' element={<Dashboard/>}/>
                                <Route path='/transactions' element={<Transactions/>} />
                                <Route path='/invoices' element={<Invoices/>} />
                                <Route path='/loans' element={<Loans/>} />
                                <Route path='/savingaccount' element={<SavingAccount/>} />
                                <Route path='/enterprise' element={<Enterprise/>} />
                                <Route path='/crypto' element={<Crypto/>} />
                                <Route path='/settings' element={<Settings/>} />
                            </Routes>
                        </div>
                    </div>
                    <div className='right-[1vw] top-[2vw] absolute'>
                        <Notify></Notify>
                    </div>
                    { Config.PlayerInformation.AccountUsed.loginlimit < Config.HackSettings.LoginLimit && Config.PlayerInformation.AccountOwner && (
                        <div className='w-full h-[50px] flex items-center justify-center theme-button-danger left-0 top-0 absolute rounded-none'>
                            <i className="fa-duotone fa-solid fa-exclamation-triangle mr-[8px]"></i>
                            <span className='theme-text text-[14px] font-bold'>{ Config.Locales['account_hacked'] }</span>
                        </div>
                    )}
                </div>
            )}
        </div>
    )
}

export default App